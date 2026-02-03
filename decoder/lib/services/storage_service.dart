import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_models.dart';

class StorageService {
  static const String _profilesKey = 'speaker_profiles';
  static const String _ageKey = 'isAgeVerified';
  static const String _premiumKey = 'hasPaidPremium';

  static Future<List<SpeakerProfile>> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profilesJson = prefs.getString(_profilesKey);
    if (profilesJson == null) return [];
    final List<dynamic> decoded = jsonDecode(profilesJson);
    return decoded.map((e) => SpeakerProfile.fromJson(e)).toList();
  }

  static Future<void> saveProfiles(List<SpeakerProfile> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _profilesKey,
      jsonEncode(profiles.map((e) => e.toJson()).toList()),
    );
  }

  static Future<void> addConversationToProfile(
    String name,
    ConversationLog log,
  ) async {
    final profiles = await loadProfiles();
    final index = profiles.indexWhere(
      (p) => p.name.toLowerCase() == name.toLowerCase(),
    );
    if (index != -1) {
      profiles[index].conversationHistory.add(log);
    } else {
      profiles.add(SpeakerProfile(name: name, conversationHistory: [log]));
    }
    await saveProfiles(profiles);
  }

  static Future<bool> isAgeVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_ageKey) ?? false;
  }

  static Future<void> setAgeVerified() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_ageKey, true);
  }

  static Future<bool> isPremium() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_premiumKey) ?? false;
  }

  static Future<void> setPremium(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, status);
  }
}

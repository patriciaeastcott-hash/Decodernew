import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants.dart';
import '../widgets/app_header.dart';
import 'splash_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Settings"),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Terms"),
            onTap: () async {
              final Uri url = Uri.parse(kTermsUrl);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            title: const Text("Privacy"),
            onTap: () async {
              final Uri url = Uri.parse(kPrivacyUrl);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            title: const Text(
              "Reset Data",
              style: TextStyle(color: kColorError),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SplashScreen()),
                (r) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

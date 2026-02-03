import 'dart:convert';
import 'package:http/http.dart' as http;

class DecoderService {
  static const String baseUrl =
      'https://decoder_new-222632046587.us-central1.run.app';
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
  };

  // 1. Full Communication Analysis
  static Future<Map<String, dynamic>> analyzeText(String text) async {
    final response = await http.post(
      Uri.parse('$baseUrl/analyze'),
      headers: _headers,
      body: jsonEncode({'text': text}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Analysis Failed');
  }

  // 2. Speaker Identification (Unlabeled Text)
  static Future<Map<String, dynamic>> identifySpeakers(String text) async {
    final response = await http.post(
      Uri.parse('$baseUrl/identify-speakers'),
      headers: _headers,
      body: jsonEncode({'text': text}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Identification Failed');
  }

  // 3. Response Simulation (Draft Analysis)
  static Future<Map<String, dynamic>> simulateResponse(
    String context,
    String draft,
    String? profile,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/simulate'),
      headers: _headers,
      body: jsonEncode({
        'context': context,
        'draft': draft,
        'recipient_profile': profile,
      }),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Simulation Failed');
  }

  // 4. Pattern Profile Analysis (History-based)
  static Future<Map<String, dynamic>> analyzeProfile(
    String name,
    List<dynamic> logs,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/analyze-profile'),
      headers: _headers,
      body: jsonEncode({'name': name, 'logs': logs}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Profile Analysis Failed');
  }
}

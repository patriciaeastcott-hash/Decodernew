import 'package:flutter/material.dart';
import '../config/constants.dart';

class AnalysisResultsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const AnalysisResultsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analysis Results',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorNavy,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildSection(
                  'Overview',
                  data['conversation_overview']?['interaction_summary'] ??
                      'No summary available',
                ),
                const Divider(),
                // Speaker cards would be mapped here...
              ],
            ),
          ),
          // MANDATORY AI DISCLOSURE (Transparency & Store Compliance)
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[200],
            child: Text(
              data['ai_disclosure'] ?? 'AI-Generated Content',
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kStyleHeader.copyWith(fontSize: 18)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

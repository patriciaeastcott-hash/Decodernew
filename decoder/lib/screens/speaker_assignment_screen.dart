import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/decoder_service.dart';
import '../services/storage_service.dart';
import '../models/profile_models.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_exit_button.dart';
import 'analysis_results_screen.dart';

class SpeakerAssignmentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> transcript;
  final String originalText;
  const SpeakerAssignmentScreen({
    super.key,
    required this.transcript,
    required this.originalText,
  });

  @override
  State<SpeakerAssignmentScreen> createState() =>
      _SpeakerAssignmentScreenState();
}

class _SpeakerAssignmentScreenState extends State<SpeakerAssignmentScreen> {
  late List<Map<String, dynamic>> _transcript;
  bool _isDecoding = false;

  @override
  void initState() {
    super.initState();
    _transcript = List.from(widget.transcript);
  }

  Future<void> _runFullDecode() async {
    setState(() => _isDecoding = true);
    try {
      final result = await DecoderService.analyzeText(jsonEncode(_transcript));

      for (var speaker in result['speakers']) {
        await StorageService.addConversationToProfile(
          speaker['label'] ?? 'Unknown',
          ConversationLog(
            date: DateTime.now().toString(),
            text: widget.originalText,
            context: "Analyzed conversation",
          ),
        );
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AnalysisResultsScreen(data: result)),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Analysis Error")));
      }
    } finally {
      if (mounted) setState(() => _isDecoding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Step 2: Assign Speakers"),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 100,
              left: 16,
              right: 16,
              top: 16,
            ),
            itemCount: _transcript.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: TextFormField(
                    initialValue: _transcript[index]['speaker'],
                    onChanged: (v) => _transcript[index]['speaker'] = v,
                    decoration: const InputDecoration(
                      labelText: "Speaker Name",
                    ),
                  ),
                  subtitle: Text(_transcript[index]['text']),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: _isDecoding ? null : _runFullDecode,
              child: const Text("Analyze Conversation"),
            ),
          ),
          const QuickExitButton(),
        ],
      ),
    );
  }
}

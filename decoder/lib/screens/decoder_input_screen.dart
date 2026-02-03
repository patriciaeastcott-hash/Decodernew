import 'package:flutter/material.dart';
import '../services/decoder_service.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_exit_button.dart';
import 'speaker_assignment_screen.dart';

class DecoderInputScreen extends StatefulWidget {
  const DecoderInputScreen({super.key});
  @override
  State<DecoderInputScreen> createState() => _DecoderInputScreenState();
}

class _DecoderInputScreenState extends State<DecoderInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _processText() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    try {
      final data = await DecoderService.identifySpeakers(_controller.text);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SpeakerAssignmentScreen(
            transcript: List<Map<String, dynamic>>.from(data['transcript_log']),
            originalText: _controller.text,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Service Error")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: "Step 1: Input"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: "Paste conversation...",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _processText,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Identify Speakers"),
                ),
              ],
            ),
          ),
          const QuickExitButton(),
        ],
      ),
    );
  }
}

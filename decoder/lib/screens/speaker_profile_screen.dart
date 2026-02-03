import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_exit_button.dart';

class SpeakerProfilesScreen extends StatelessWidget {
  const SpeakerProfilesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: "Profiles"),
      body: Stack(
        children: [
          Center(child: Text("Profiles List")),
          QuickExitButton(),
        ],
      ),
    );
  }
}

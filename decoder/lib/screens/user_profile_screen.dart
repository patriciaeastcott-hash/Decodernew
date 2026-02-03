import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Unbiased Profile")),
      body: const Center(
        child: Text("AI-Driven Self Evaluation logic goes here."),
      ),
    );
  }
}

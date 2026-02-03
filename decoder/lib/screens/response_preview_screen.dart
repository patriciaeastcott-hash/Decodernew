import 'package:flutter/material.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_exit_button.dart';

class ResponsePreviewScreen extends StatelessWidget {
  const ResponsePreviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(title: "Response Simulator"),
      body: Stack(
        children: [
          Center(child: Text("Simulator logic goes here.")),
          QuickExitButton(),
        ],
      ),
    );
  }
}

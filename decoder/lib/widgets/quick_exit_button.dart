import 'package:flutter/material.dart';
import '../config/constants.dart';

class QuickExitButton extends StatelessWidget {
  const QuickExitButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 32,
      child: FloatingActionButton.extended(
        heroTag: 'quickExit',
        backgroundColor: kColorError,
        onPressed: () => Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamedAndRemoveUntil('/', (route) => false),
        label: const Text(
          "QUICK EXIT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

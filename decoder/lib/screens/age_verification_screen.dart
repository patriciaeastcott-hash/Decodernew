import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../services/storage_service.dart';
import 'paywall_screen.dart';

class AgeVerificationScreen extends StatelessWidget {
  const AgeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorNavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Eligibility Confirmation", style: kStyleHeader),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await StorageService.setAgeVerified();
                if (!context.mounted) return; // FIX: Handled async gap
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PaywallScreen()),
                );
              },
              child: const Text("Confirm Eligibility (17+)"),
            ),
          ],
        ),
      ),
    );
  }
}

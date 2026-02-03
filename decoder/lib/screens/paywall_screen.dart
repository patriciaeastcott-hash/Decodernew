import 'package:flutter/material.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});
  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final TextEditingController _promoController = TextEditingController();

  void _checkPromo() {
    if (_promoController.text == "demo2025") {
      // Logic to unlock premium features locally
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid Promo Code"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Unlock Premium Decoding", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Subscribe - $9.99/mo")),
            TextButton(onPressed: () {}, child: const Text("Restore Purchases")),
            const Divider(),
            TextField(
              controller: _promoController,
              decoration: const InputDecoration(labelText: "Enter Promo Code (e.g. demo2025)"),
            ),
            ElevatedButton(onPressed: _checkPromo, child: const Text("Apply Code")),
          ],
        ),
      ),
    );
  }
}
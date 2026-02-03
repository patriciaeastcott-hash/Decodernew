import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../config/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    bool ageVerified = await StorageService.isAgeVerified();
    if (!ageVerified) {
      if (mounted) Navigator.pushReplacementNamed(context, '/age-check');
      return;
    }
    bool premium = await StorageService.isPremium();
    if (!premium) {
      if (mounted) Navigator.pushReplacementNamed(context, '/paywall');
      return;
    }
    if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kColorNavy,
      body: Center(
        child: Icon(Icons.psychology, size: 80, color: Colors.white),
      ),
    );
  }
}

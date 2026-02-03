import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/age_verification_screen.dart';
import 'screens/paywall_screen.dart';
import 'screens/dashboard_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DecoderApp());
}

class DecoderApp extends StatelessWidget {
  const DecoderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF1E3A8A)),
      // The app starts at Splash, which then redirects based on logic
      home: const SplashScreen(),
      routes: {
        '/age-check': (context) => const AgeVerificationScreen(),
        '/paywall': (context) => const PaywallScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}

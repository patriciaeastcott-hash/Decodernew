import 'package:flutter/material.dart';
import '../config/constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Linguistic Decoder',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorNavy,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildCard(
            context,
            "Decode String",
            Icons.psychology,
            '/decoder-input',
          ),
          _buildCard(
            context,
            "Behavior Library",
            Icons.library_books,
            '/library',
          ),
          _buildCard(
            context,
            "Speaker Profiles",
            Icons.people,
            '/speaker-profiles',
          ),
          _buildCard(
            context,
            "My Evaluation",
            Icons.person_search,
            '/user-profile',
          ),
          _buildCard(context, "Settings", Icons.settings, '/settings'),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: kColorPurple),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

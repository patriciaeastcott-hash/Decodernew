import 'package:flutter/material.dart';
import '../config/constants.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> traits = List.generate(
      100,
      (index) => "Behavioral Trait #$index: Linguistic Marker",
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Behavioral Library")),
      body: ListView.builder(
        itemCount: traits.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.bookmark, color: kColorPurple),
            title: Text(traits[index]),
            onTap: () {
              // Navigation to trait detail
            },
          );
        },
      ),
    );
  }
}

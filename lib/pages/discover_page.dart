import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const DiscoverPage(),
  );
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS FOR THIS PAGE'S CONTENTS.
    return Container(
        color: Colors.blue,
        child: const Center(
            child: Text(
              "Discover",
            )
        )
    );
  }
}
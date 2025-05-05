import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS FOR THIS PAGE'S CONTENTS.
    return Container(
        color: Colors.green,
        child: const Center(
            child: Text(
              "Profile",
            )
        )
    );
  }
}
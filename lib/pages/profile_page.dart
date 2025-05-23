import 'package:flutter/material.dart';
import '../services/auth/authentication.dart';
import 'create_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
        backgroundColor: Colors.green,
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              signOut(context);
            },
            child: const Text('Logout'),
          ),
        ),

    ); //scaffold

  }
}
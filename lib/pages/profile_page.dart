import 'package:flutter/material.dart';
import '../services/auth/authentication.dart';
import '../services/auth/user.dart';
import 'create_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData?>(
      future: UserData.fetchCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return const Center(child: Text("Error loading user data"));
        }
        else if (!snapshot.hasData) {
          return const Center(child: Text("No user data found"));
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile Page')),
          backgroundColor: Colors.green,

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // centers both text and button vertically
              children: [
                Text(
                  "Your UID: ${user.UserUID}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Your Name: ${user.UserName}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Your Email: ${user.UserEmail}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Your Major: ${user.UserMajor}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "Your College: ${user.UserCollege}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20), // spacing between text and button
                ElevatedButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:OurSpace/services/auth/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/create_profile.dart';
import '../../pages/logIn_page.dart';
import '../../pages/navigation_bar.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> hasUserProfile() async {
    final user = await UserData.fetchCurrentUser();

    if (user == null) return false;

    return user.UserName != null && user.UserName!.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user == null) {
            return LoginSignUpPage();
          }

          return FutureBuilder<bool>(
            future: hasUserProfile(),
            builder: (context, profileSnapshot) {
              if (!profileSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final hasProfile = profileSnapshot.data!;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => hasProfile ? const NavBar() : const CreateProfilePage(),
                ));
              });

              return const Center(child: CircularProgressIndicator());
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
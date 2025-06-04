import 'package:OurSpace/services/auth/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/navigation_bar.dart';

class UploadGate extends StatelessWidget {
  const UploadGate({super.key});

  Future<bool> hasUserData() async {
    final user = await UserData.fetchCurrentUser();

    if (user == null) return false;

    return user.UserMajor != null && user.UserMajor!.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {

          return FutureBuilder<bool>(
            future: hasUserData(),
            builder: (context, profileSnapshot) {
              if (!profileSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => NavBar(),
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
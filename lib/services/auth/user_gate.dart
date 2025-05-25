import 'package:OurSpace/pages/create_profile.dart';
import 'package:OurSpace/services/auth/user.dart';
import 'package:flutter/material.dart';
import '../../pages/navigation_bar.dart';

class UserGate extends StatelessWidget {
  const UserGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: User.fetchCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            if (user.UserName == null) {
              return CreateProfilePage();
            }
            else {
              return NavBar();
            }
          }
          else {
            Exception("Error: No User Data");
            return SizedBox(); // to satisfy return
          }
        }
        );
  }
}
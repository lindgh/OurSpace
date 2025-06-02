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

          backgroundColor: Colors.white,

          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              // centers both text and button vertically
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(user.UserProfilePicture!),
                          ),
                          SizedBox(height: 30),
                          Text(
                            user.UserName!,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 15,
                          children: [
                            Icon(Icons.school),
                            Text(
                              user.UserCollege!,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 200), // spacing between text and button
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(

                  ),
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
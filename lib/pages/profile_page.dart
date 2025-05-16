import 'package:flutter/material.dart';
import 'create_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS FOR THIS PAGE'S CONTENTS.

    // return Container(
    //     color: Colors.green,
    //     child: const Center(
    //         child: Text(
    //           "Profile",
    //         )
    //     )
    // );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
        backgroundColor: Colors.green,
        body: Center(
          child: const Text('Profile Page'),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const CreateProfilePage()),
          //     );
          //   },
          //   child: const Text('Create your profile'),
          // ),
        ),

    ); //scaffold

  }
}
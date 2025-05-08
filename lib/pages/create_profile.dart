import 'package:flutter/material.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS FOR THIS PAGE'S CONTENTS.
    // return Container(
    //     color: Colors.pink,
    //     child: const Center(
    //         child: Text(
    //           "Create your profile! :3",
    //         )
    //     )
    // );
    return Scaffold(
      appBar: AppBar(title: const Text('Create your profile')),
      backgroundColor: Colors.pink,
      // body: Center(
      //   child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: const Text('Go back to profile page.'),
      //   ),
      //)
    ); //scaffold
  }
}
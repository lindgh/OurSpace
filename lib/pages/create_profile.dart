import 'package:flutter/material.dart';
import 'text_field.dart';
import 'nav_bar.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create your profile'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          leadingWidth: 100,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          //name
          MyTextField(text: 'Name'),

          //major
          MyTextField(text: 'Major'),

          //school
          MyTextField(text: 'College/University'),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.indigoAccent,
                  surfaceTintColor: Colors.indigoAccent,
                  textStyle: TextStyle(
                    fontSize: 18,
                  ),
              ),
              onPressed: () { //When create prof button pushed: just goes to nav rn, but should store user data
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    ); //scaffold
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nav_bar.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final collegeController = TextEditingController();
  final majorController = TextEditingController();

  void uploadUserInfo() {
    //if all fields contain info, then we can upload
    if ((nameController.text.isNotEmpty) && (majorController.text.isNotEmpty) &&
        (collegeController.text.isNotEmpty)) {
      FirebaseFirestore.instance.collection("Users").add({
        'Name': nameController.text,
        'Major': majorController.text,
        'College': collegeController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create your profile'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white, //makes app bar text white
          leadingWidth: 100, //centers text on app bar
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
            child: Column(
              children: [
                TextField( //THIS DISPLAYS NAME TEXT FIELD!
                  controller: nameController, //this lets us save the name they type!
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: UnderlineInputBorder(),
                    //contentPadding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                  ),
                ),

                SizedBox(width: 30.0, height: 30.0), //this puts space btwn name & major box

                TextField( //THIS DISPLAYS MAJOR TEXT FIELD!
                  controller: majorController,
                  decoration: InputDecoration(
                    labelText: 'Major',
                    border: UnderlineInputBorder(),
                    //contentPadding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  ),
                ),

                SizedBox(width: 30.0, height: 30.0), //this puts space btwn major & college box

                TextField( //THIS DISPLAYS COLLEGE TEXT FIELD!
                  controller: collegeController,
                  decoration: InputDecoration(
                    labelText: 'College',
                    border: UnderlineInputBorder(),
                    //contentPadding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  ),
                ),
              ],
            ),
          ),
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
              onPressed: () {
                uploadUserInfo();
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
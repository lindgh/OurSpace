import 'package:OurSpace/pages/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth/authentication.dart';
import '../services/auth/user.dart';
import 'create_profile.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import '../models/pickImage.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream = _firestore
      .collection("Users")
      .doc(_auth.currentUser!.uid)
      .snapshots();
  Uint8List? _userImage;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _userImage = img;
    });
  }

  Future openDialog(String oldImage) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile Picture',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: <Widget>[
                _userImage != null ?
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: MemoryImage(_userImage!),
                )
                    :
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(oldImage),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(Icons.add_a_photo_rounded),
                    iconSize: 40,
                    hoverColor: Colors.indigo,
                    color: Colors.white,
                  ),
                  bottom: -4,
                  left: 140,
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Save',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                style: TextStyle(
                  fontSize: 17,
                ),
              )
          ),
        ],
      ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: documentStream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            Map<String, dynamic> data =
            snapshot.data!.data()! as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  children: <Widget>[
                    Container( //profile picture & name container
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
                              SizedBox(height: 30.0),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 100.0,
                                    backgroundImage: NetworkImage(data['Profile Picture']),
                                  ),
                                  Positioned(
                                    child: IconButton(
                                      onPressed: () {
                                        openDialog(data['Profile Picture']);
                                      },
                                      icon: const Icon(Icons.add_a_photo_rounded),
                                      iconSize: 40,
                                      hoverColor: Colors.indigo,
                                      color: Colors.white,
                                    ),
                                    bottom: -4,
                                    left: 140,
                                    //top: -30,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[400],
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    child: Container(
                                      width: 250.0,
                                      height: 50.0,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(data['Name'],
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container( //user info container
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row( //major
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15.0,
                              children: [
                                Icon(Icons.menu_book,
                                  color: Colors.indigo,
                                  size: 34.0,
                                ),
                                Text(data['Major'],
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row( //college
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 26.0,
                              children: [
                                Icon(Icons.place,
                                  color: Colors.indigo,
                                  size: 25.0,
                                ),
                                Text(data['College'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row( //grad year
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 26.0,
                              children: [
                                Icon(Icons.school,
                                  color: Colors.indigo,
                                  size: 25.0,
                                ),
                                Text(data['Graduation Year'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.0),
                                color: Colors.grey[200],
                              ),
                              child: Container(
                                width: 350.0,
                                height: 160.0,

                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              spacing: 20.0,
                                              children: [
                                                Icon(Icons.message,
                                                  color: Colors.grey[800],
                                                  size: 25.0,
                                                ),
                                                Flexible(
                                                    child: Text(data['Biography'],
                                                      softWrap: true,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row( //buttons
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 30.0,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            fixedSize: Size.fromWidth(150.0),
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => EditProfilePage(),
                                )
                            );
                          },
                          child: const Text('Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            fixedSize: Size.fromWidth(150.0),
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            signOut(context);
                          },
                          child: const Text('Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//HOW TO Access DATA:
// data['uid'],
// data['Email'],
// data['Name'],
// data['Major'],
// data['College'],
// data['Graduation Year'],
// data['Biography'],
// data['Profile Picture'],


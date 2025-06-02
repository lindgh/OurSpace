import 'dart:convert';
import 'dart:typed_data';

//import 'package:OurSpace/models/pickImage.dart';
import 'package:OurSpace/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../components/majors.dart';
import '../components/colleges.dart';
import '../components/graduation_years.dart';
import '../models/pickImage.dart';
import '../services/upload/add_data.dart';
import '../services/upload/upload_gate.dart';
import '../services/auth/authentication.dart';
import '../services/auth/user.dart';
import 'create_profile.dart';

class EditProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const EditProfilePage(),
  );
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final nameController = TextEditingController();
  final collegeController = TextEditingController();
  final gradYearController = TextEditingController();
  final majorController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _userImage;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _userImage = img;
    });
  }

  void uploadUserInfo() async {
    String response = await StoreData().saveData(
        name: nameController.text,
        major: majorController.text,
        college: collegeController.text,
        gradYear: gradYearController.text,
        biography: bioController.text,
        file: _userImage!
    );
  }

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
            appBar: AppBar(
              title: const Text('Edit your profile'),
              centerTitle: true,
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
                      SizedBox(width: 30.0, height: 10.0),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
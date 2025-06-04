import 'dart:convert';
//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'dart:typed_data';

//import 'package:OurSpace/models/pickImage.dart';
import 'package:OurSpace/pages/navigation_bar.dart';
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

  var editNameController = TextEditingController();
  final editCollegeController = TextEditingController();
  final editGradYearController = TextEditingController();
  final editMajorController = TextEditingController();
  var editBioController = TextEditingController();
  Uint8List? _userImage;
  bool isLoading = false;

  void selectEditedImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _userImage = img;
    });
  }

  Future<String> uploadEditedUserInfo(String currentProfilePicture) async {
    String newImageURL = currentProfilePicture;
    if (_userImage != null) {
      newImageURL = await StoreData().uploadImageToStorage(_userImage!);
    }
    String response = await StoreData().saveData(
        name: editNameController.text,
        major: editMajorController.text,
        college: editCollegeController.text,
        gradYear: editGradYearController.text,
        biography: editBioController.text,
        imageURL: newImageURL,
    );

    return response;
  }

  void saveChanges(String userImage) async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.wait([
        uploadEditedUserInfo(userImage),
        Future.delayed(Duration(seconds: 3)),
      ]);

      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NavBar(index: 2),
          )
      );
    } catch (e) {
      print("Error: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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

          //initialize controllers with information stored in database
          editNameController = new TextEditingController(text: user.UserName);
          editBioController = new TextEditingController(text: user.UserBiography);
          //printToConsole('Major selected: ${user.UserMajor}');

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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                  child: Column(
                    children: [
                      SizedBox(width: 30.0, height: 30.0),
                      TextField( //THIS DISPLAYS NAME TEXT FIELD!
                        controller: editNameController, //this lets us save the name they type!
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.user),
                        ),
                      ),
                      SizedBox(width: 30.0, height: 30.0), //this puts space btwn name & major box
                      DropdownMenu(
                        label: const Text('Select Major'),
                        initialSelection: user.UserMajor,
                        controller: editMajorController,
                        expandedInsets: EdgeInsets.zero,
                        requestFocusOnTap: true,
                        enableSearch: true,
                        enableFilter: true,
                        menuHeight: 400.0,
                        onSelected: (value){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        dropdownMenuEntries: majorOptions.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                      ),
                      SizedBox(width: 30.0, height: 30.0), //this puts space btwn major & college box
                      DropdownMenu(
                        label: const Text('Select College'),
                        initialSelection: user.UserCollege,
                        controller: editCollegeController,
                        expandedInsets: EdgeInsets.zero,
                        requestFocusOnTap: true,
                        enableSearch: true,
                        enableFilter: true,
                        menuHeight: 400.0,
                        onSelected: (value){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        dropdownMenuEntries: collegeOptions.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                      ),
                      SizedBox(width: 30.0, height: 30.0),
                      DropdownMenu(
                        label: const Text('Select Graduation Year'),
                        initialSelection: user.UserGradYear,
                        controller: editGradYearController,
                        expandedInsets: EdgeInsets.zero,
                        requestFocusOnTap: true,
                        enableSearch: true,
                        enableFilter: true,
                        menuHeight: 400.0,
                        onSelected: (value){
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        dropdownMenuEntries: gradYearOptions.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                      ),
                      SizedBox(width: 30.0, height: 30.0),
                      TextFormField(
                        //initialValue: user.UserBiography,
                        keyboardType: TextInputType.multiline,
                        controller: editBioController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 73),
                            child: Icon(LineAwesomeIcons.comment),
                          ),
                          alignLabelWithHint: true,
                          labelText: 'Biography',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: ()  async {
                              isLoading ? null : saveChanges(user.UserProfilePicture!);
                            },
                            child: isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            :
                              const Text('Save Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: ()  {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => NavBar(index: 2),
                                  )
                              );
                            },
                            child: const Text('Cancel',
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
              ],
            ),
          );
        },
    );
  }
}
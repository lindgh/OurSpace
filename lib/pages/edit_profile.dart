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

  var nameController = TextEditingController();
  var collegeController = TextEditingController();
  var gradYearController = TextEditingController();
  var majorController = TextEditingController();
  var bioController = TextEditingController();
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

          //initialize controllers with information stored in database
          nameController = new TextEditingController(text: user.UserName);
          collegeController = new TextEditingController(text: user.UserCollege);
          gradYearController = new TextEditingController(text: user.UserGradYear);
          majorController = new TextEditingController(text: user.UserMajor);
          bioController = new TextEditingController(text: user.UserBiography);


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
                      Stack (
                        children: [
                          user.UserProfilePicture != null ?
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(user.UserProfilePicture!),
                          )
                              :
                          const CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage('https://i.imgur.com/aNPydA6.png'),
                          ),
                          Positioned(
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo_rounded),
                              iconSize: 30,
                              hoverColor: Colors.indigo,
                            ),
                            bottom: -4,
                            left: 95,
                            //top: -30,
                          ),
                        ],
                      ),
                      SizedBox(width: 30.0, height: 30.0),
                      TextField( //THIS DISPLAYS NAME TEXT FIELD!
                        controller: nameController, //this lets us save the name they type!
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(100.0)
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.user),
                          //icon: ,
                          //contentPadding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                        ),
                      ),
                      SizedBox(width: 30.0, height: 30.0), //this puts space btwn name & major box

                      DropdownMenu(
                        label: const Text('Select Major'),
                        controller: majorController,
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
                        controller: collegeController,
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
                        controller: gradYearController,
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
                        keyboardType: TextInputType.multiline,
                        controller: bioController,
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
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => ProfilePage(),
                            )
                          );
                        },
                        child: const Text('Cancel',
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          uploadUserInfo();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => UploadGate(),
                              )
                          );
                        },
                        child: const Text('Save Changes',
                        ),
                      )
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
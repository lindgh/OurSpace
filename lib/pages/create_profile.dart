//import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:convert';
import 'dart:typed_data';

//import 'package:OurSpace/models/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../components/majors.dart';
import '../components/colleges.dart';
import '../components/graduation_years.dart';
import '../models/pickImage.dart';
import '../services/upload/add_data.dart';
import '../services/upload/upload_gate.dart';

import 'edit_profile.dart';

class CreateProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const CreateProfilePage(),
  );
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {

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
    String newImageURL = 'https://i.imgur.com/aNPydA6.png'; //this is default pfp

    if (_userImage != null) {
      String newImageURL = await StoreData().uploadImageToStorage(_userImage!);
    }

    String response = await StoreData().saveData(
        name: nameController.text,
        major: majorController.text,
        college: collegeController.text,
        gradYear: gradYearController.text,
        biography: bioController.text,
        imageURL: newImageURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create your profile'),
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

                Stack(
                  children: [
                    _userImage != null ?
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: MemoryImage(_userImage!),
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
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
            child: ElevatedButton(
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
                    ));
              },
              child: const Text('Join OurSpace',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ); //scaffold
  }


}
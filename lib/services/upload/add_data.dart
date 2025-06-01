import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData{

  Future<String> uploadImageToStorage(String childName, Uint8List file) async{
    Reference imageDirectoryReference = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = imageDirectoryReference.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> saveData({
    required String name,
    required String major,
    required String college,
    required String biography,
    required Uint8List file,
  }) async {
    String response = "An error occurred while saving data.";
    try{
      if (name.isNotEmpty && major.isNotEmpty && college.isNotEmpty) {
        String imageURL = await uploadImageToStorage('profile_images', file);
        await _firestore.collection("Users").doc(_auth.currentUser!.uid).update(
            {
              'Name': name,
              'Major': major,
              'College': college,
              'Biography': biography,
              'Profile Picture': imageURL,
            });
        response = "Data save successful.";
      }
    }
        catch(err) {
          response = err.toString();
        }
    return response;

  }

}
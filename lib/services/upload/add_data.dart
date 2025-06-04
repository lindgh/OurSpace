import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData{

  Future<String> uploadImageToStorage(Uint8List file) async{
    Reference imageDirectoryReference = _storage
        .ref()
        .child('profile_images')
        .child(_auth.currentUser!.uid);

    UploadTask uploadTask = imageDirectoryReference.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

  Future<String> saveData({
    required String name,
    required String major,
    required String college,
    required String gradYear,
    required String biography,
    required String imageURL,
  }) async {
    String response = "An error occurred while saving data.";
    try{
      if (name.isNotEmpty && major.isNotEmpty && college.isNotEmpty) {
        await _firestore.collection("Users").doc(_auth.currentUser!.uid).update(
            {
              'Name': name,
              'Major': major,
              'College': college,
              'Graduation Year': gradYear,
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
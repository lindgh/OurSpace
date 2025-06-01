import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String UserUID;
  final String UserEmail;

  // these must all be nullable (have a ?)
  final String? UserName;
  final String? UserMajor; // change to int?
  final String? UserCollege; // change to int?
  final String? UserBiography;
  final Uint8List? UserProfilePicture;

  UserData({
    required this.UserUID,
    required this.UserEmail,
    required this.UserName,
    required this.UserMajor,
    required this.UserCollege,
    required this.UserBiography,
    required this.UserProfilePicture,
  });

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData(
      UserUID: data['uid'],
      UserEmail: data['Email'],
      UserName: data['Name'],
      UserMajor: data['Major'],
      UserCollege: data['College'],
      UserBiography: data['Biography'],
      UserProfilePicture: data['Profile Picture'],
    );
  }

  static Future<UserData?> fetchCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (!doc.exists) return null;

      return UserData.fromFirestore(doc);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

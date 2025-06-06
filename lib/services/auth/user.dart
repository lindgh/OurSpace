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
  final String? UserGradYear;
  final String? UserBiography;
  final String? UserProfilePicture;
  final List<String>? inquiredUsers;
  final List<String>? matchedUsers;

  UserData({
    required this.UserUID,
    required this.UserEmail,
    required this.UserName,
    required this.UserMajor,
    required this.UserCollege,
    required this.UserGradYear,
    required this.UserBiography,
    required this.UserProfilePicture,
    this.inquiredUsers,
    this.matchedUsers
  });

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData(
      UserUID: data['uid'],
      UserEmail: data['Email'],
      UserName: data['Name'],
      UserMajor: data['Major'],
      UserCollege: data['College'],
      UserGradYear: data['Graduation Year'],
      UserBiography: data['Biography'],
      UserProfilePicture: data['Profile Picture'],
      inquiredUsers: (data['inquired_users'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      matchedUsers: (data['matched_users'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }

  static Future<UserData?> fetchCurrentUser({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
}) async {
    auth ??= FirebaseAuth.instance;
    firestore ??= FirebaseFirestore.instance;
    try {
      final user = auth.currentUser;
      if (user == null) return null;

      final doc = await firestore
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

Future<bool> addInquiredUser(String swipedUserId, {
  FirebaseAuth? auth,
  FirebaseFirestore? firestore,
}) async {
  auth ??= FirebaseAuth.instance;
  firestore ??= FirebaseFirestore.instance;

  final currentUser = auth.currentUser;
  if (currentUser == null) return false;

  final userDoc = firestore.collection('Users').doc(currentUser.uid);
  final swipedDoc = firestore.collection('Users').doc(swipedUserId);

  final swipedSnapshot = await swipedDoc.get();

  List<dynamic> swipedInquired = swipedSnapshot['inquired_users'] ?? [];

  if (swipedInquired.contains(currentUser.uid)) {
    await userDoc.update({
      'matched_users': FieldValue.arrayUnion([swipedUserId]),
    });
    await swipedDoc.update({
      'matched_users': FieldValue.arrayUnion([currentUser.uid]),
    });
    return true;
  } else {
    await userDoc.update({
      'inquired_users': FieldValue.arrayUnion([swipedUserId])
    });
    return false;
  }
}


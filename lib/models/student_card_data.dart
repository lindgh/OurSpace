import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_card_model.dart';

Future<List<StudentCard>> getAllUserData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    QuerySnapshot querySnapshot =  await _firestore.collection("TestUsers").get();

    List<StudentCard> studentCards = await querySnapshot.docs.where(
      (doc) => doc.id != _auth.currentUser!.uid).map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return StudentCard(
        UserName: data['Name'] ?? '',
        UserCollege: data['College'] ?? '',
        UserMajor: data['Major'] ?? '',
        UserGraduationYear: data['GraduationYear'] ?? '',
        headerImagePath: "assets/images/placeholder_OI.jpg",
        profileImagePath: "assets/images/placeholder_OI_pfp.jpg",
        schoolImagePath: "assets/images/placeholder_school_ucr.jpg",
        courses: ["CS147", "CS173", "EE120B", "MATH009B", "EE108"],
        studyFocusText: "Looking for someone to help me study the CS153 exam. I really don't understand this stuff. \n\nMaybe if you help me learn a lot, I'll take you out on a date..",
        bio: "I love computer science as much as I love acting. Add me on Discord!",
      );
    }).toList();

    return studentCards;
  } catch (e) {
    print("Error fetching user data: $e");
    return [];
  }
}
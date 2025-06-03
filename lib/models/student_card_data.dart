import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_card_model.dart';

Future<List<StudentCard>> getAllUserData() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  try{
    QuerySnapshot querySnapshot =  await _firestore.collection("Users").get();

    List<StudentCard> studentCards = await querySnapshot.docs.where(
      (doc) => doc.id != _auth.currentUser!.uid).map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return StudentCard(
        UserName: data['Name'] ?? '',
        UserCollege: data['College'] ?? '',
        UserMajor: data['Major'] ?? '',
        UserGradYear: data['Graduation Year'] ?? '',
        profileImagePath: data['Profile Picture'] ?? '',
        UserBio: data['Biography'] ?? '',
      );
    }).toList();

    return studentCards;
  } catch (e) {
    print("Error fetching user data: $e");
    return [];
  }
}
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// put the class that you want to mock here
@GenerateMocks([
  FirebaseAuth,
  User,
  UserCredential,
  FirebaseFirestore,
  DocumentSnapshot<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  CollectionReference<Map<String, dynamic>>,
])
void main() {}

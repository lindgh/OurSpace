import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:OurSpace/services/chat/chat_services.dart';
import '../lib/services/upload/add_data.dart';

// put the class that you want to mock here
@GenerateMocks([
  FirebaseAuth,
  User,
  UserCredential,
  FirebaseFirestore,
  DocumentSnapshot<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  CollectionReference<Map<String, dynamic>>,
  StoreData,
])
void main() {}

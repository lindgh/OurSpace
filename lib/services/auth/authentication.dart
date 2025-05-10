import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/home_page.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final formKey = GlobalKey<FormState>();

class authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // log in
  Future <UserCredential> loginUserWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );

      _firestore.collection("ChatClient").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future <UserCredential> signUpUserWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      _firestore.collection("ChatClient").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

void login(BuildContext context) async {
  final authService = authentication();

  try {
    await authService.loginUserWithEmailAndPassword(emailController.text, passwordController.text);
    Navigator.push(context, HomePage.route());
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
      )
    );
  }
}

void signup(BuildContext context) async {
  final authService = authentication();

  try {
    await authService.signUpUserWithEmailAndPassword(emailController.text, passwordController.text);
    Navigator.push(context, HomePage.route());
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
    );
  }
}

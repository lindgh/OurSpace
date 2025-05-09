import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/nav_bar.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final formKey = GlobalKey<FormState>();

class authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future <UserCredential> loginUserWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future <UserCredential> signUpUserWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
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
    Navigator.push(context, NavBar.route());
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
    Navigator.push(context, NavBar.route());
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
    );
  }
}

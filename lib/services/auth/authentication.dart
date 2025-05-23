import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/create_profile.dart';
import '../../pages/home_page.dart';
import '../../pages/logIn_page.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final formKey = GlobalKey<FormState>();

class authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future <void> logoutOfAccount() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

void login(BuildContext context) async {
  final authService = authentication();

  try {
    await authService.loginUserWithEmailAndPassword(emailController.text, passwordController.text);
    Navigator.popUntil(context, ((route) => route.isFirst));
    Navigator.pushReplacement(context, HomePage.route());
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
    Navigator.popUntil(context, ((route) => route.isFirst));
    Navigator.pushReplacement(context, CreateProfilePage.route());
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        )
    );
  }
}

void signOut(BuildContext context) async {
  final authService = authentication();
  try {
    await authService.logoutOfAccount();
    Navigator.popUntil(context, ((route) => route.isFirst));
    Navigator.pushReplacement(context, LoginPage.route());
  } catch (e) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(e.toString()),
            )
    );
  }
}
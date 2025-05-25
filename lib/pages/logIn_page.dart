import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../services/auth/auth_gate.dart';
import '../services/auth/authentication.dart';

class LoginSignUpPage extends StatelessWidget {
  LoginSignUpPage({super.key});

  final authService = authentication();
  Duration get loadingTime => const Duration(milliseconds: 2000);

  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loadingTime).then((_) async {
      try {
        await authService.loginUserWithEmailAndPassword(
            data.name, data.password);
      } catch (e) {
        return "Invalid username or password!";
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loadingTime).then((_) async {
      try {
        await authService.signUpUserWithEmailAndPassword(
            data.name!, data.password!);
      } catch (e) {
        if (e.toString() == "Exception: weak-password") {
          return "Password is too weak!";
        }
        else {
          return e.toString();
        }
      }
    });
  }

  Future<String?> _recoverPassword(String data) {
    // DUMMY FUNCTION -> TO SATISFY REQUIRED PARAMETER
    return Future.delayed(loadingTime).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        //title: 'OurSpace',
        logo: "assets/images/OurSpace.png",
        theme: LoginTheme(
          logoWidth: 1,
        ),
        onSignup: _signupUser,
        onLogin: _authUser,
        onRecoverPassword: _recoverPassword, //dummy function, not used
        hideForgotPasswordButton: true,
        loginAfterSignUp: true,
        onSubmitAnimationCompleted: () {
          Navigator.popUntil(context, ((route) => route.isFirst));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AuthGate(),
          ));
        },
      ),
    );
  }
}
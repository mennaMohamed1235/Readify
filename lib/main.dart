import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readify/ChangePassword.dart';
import 'package:readify/SignUpAuthor.dart';
import 'package:readify/SignUpUser.dart';
import 'package:readify/congratulation.dart';
import 'package:readify/signin.dart';
import 'package:readify/verf.dart';

void main() {
  // ignore: prefer_const_constructors
  // ignore: prefer_const_constructors
  // ignore: prefer_typing_uninitialized_variables
  runApp(SignupAuthor());
  runApp(SignUpUser());
  runApp(VerificationPage(email: ''));
  runApp(CongratulationsScreen());
  runApp(Splach());
  runApp(ChangePassword());
    runApp(SignIn());

}

// ignore: use_key_in_widget_constructors
class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a delayed future to navigate to the home screen after 5 seconds
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color(0xFF141478),
      // ignore: prefer_const_constructors
      body: Center(
        // ignore: prefer_const_constructors
        child: Image(
          // ignore: prefer_const_constructors
          image: AssetImage('images/74E328AC-07CA-4C9D-AA88-63AE66EF4C78.jpeg'),
        ),
      ),
    );
  }
}

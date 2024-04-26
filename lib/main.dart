import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readify/ChangePassword.dart';
import 'package:readify/SignUpAuthor.dart';
import 'package:readify/SignUpUser.dart';
import 'package:readify/congratulation.dart';
import 'package:readify/setting.dart';
import 'package:readify/signin.dart';
import 'package:readify/verf.dart';

void main() {
  runApp(congratulation());
  // ignore: prefer_const_constructors
  // ignore: prefer_const_constructors
  runApp(settings());
  runApp(signup_author());
  runApp(VerificationPage());
  runApp(Splach());
  runApp(SignIn());
  runApp(ChangePassword());
  runApp(SignUpUser());
}

class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a delayed future to navigate to the home screen after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('images/1A8AB0CD-A5B1-4713-9118-9BC3950BD2A1.jpeg'),
        ),
      ),
    );
  }
}

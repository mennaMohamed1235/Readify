import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readify/ChangePassword.dart';
import 'package:readify/SignUpUser.dart';
import 'package:readify/congratulation.dart';
import 'package:readify/profile/personal_data.dart';
import 'package:readify/setting.dart';
import 'package:readify/signin.dart';
import 'package:readify/verf.dart';

void main() {
  // ignore: prefer_const_constructors
  // ignore: prefer_const_constructors
  runApp(settings());
  runApp(VerificationPage());
  runApp(ChangePassword());
  runApp(SignIn());
  runApp(SignUpUser());
  runApp(CongratulationsScreen());
  runApp(PersonalDataScreen());
  runApp(Splach());
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
      backgroundColor: Color(0xFF141478),
      body: Center(
        child: Image(
          image: AssetImage('images/74E328AC-07CA-4C9D-AA88-63AE66EF4C78.jpeg'),
        ),
      ),
    );
  }
}

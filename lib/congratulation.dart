import 'dart:async';
import 'package:flutter/material.dart';
import 'package:readify/ChangePassword.dart';

class CongratulationsScreen extends StatefulWidget {
  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChangePassword()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFDFDFD),
        body: Center(
          child: Image(
            image:
                AssetImage('images/245C2828-E6EF-4411-86EA-4C3D5364E97D.jpeg'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CongratulationsScreen(),
    );
  }
}

void main() {
  runApp(CongratulationsScreen());
}

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
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image:
                AssetImage('images/A36F26CE-D860-4C98-8827-00ED5857AA6E.jpeg'),
            fit: BoxFit.cover,
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

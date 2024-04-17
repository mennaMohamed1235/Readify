import 'package:flutter/material.dart';

class congratulation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Image(
            image:
                AssetImage('images/A36F26CE-D860-4C98-8827-00ED5857AA6E.jpeg'),
          ),
        ),
      ),
    );
  }
}

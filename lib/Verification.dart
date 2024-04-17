import 'package:flutter/material.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VerificationPage(),
    );
  }
}

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _verificationCodeController =
      TextEditingController();
  bool _isCodeValid = false;

  void _verifyCode() {
    // Here you can implement your verification logic.
    // For example, you might compare the entered code with a pre-defined one.
    String validCode = "123456"; // Example valid code
    if (_verificationCodeController.text == validCode) {
      setState(() {
        _isCodeValid = true;
      });
    } else {
      setState(() {
        _isCodeValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text('Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/images (1).png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _verificationCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  prefixIcon: Icon(Icons.code),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _verifyCode,
                  child: Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF28277D),
                    // fixedSize: Size(399, 66),
                  )),
              SizedBox(height: 20),
              _isCodeValid
                  ? Text(
                      'Verification Successful',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    )
                  : Text(
                      'Verification Failed',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

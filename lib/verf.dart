import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/congratulation.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  String errorMessage = ''; // Error message for verification failure

  Future<void> _verifyCode() async {
    String code = _controllers.map((controller) => controller.text).join();
    final url = Uri.parse('http://readify.runasp.net/api/Auth/VerifyEmail');
    final response = await http.post(
      url,
      body: json.encode({'code': code}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CongratulationsScreen()),
      );
    } else {
      setState(() {
        errorMessage = 'Verification failed. Please try again.';
      });
    }
  }

  Future<void> _resendCode() async {
    final url =
        Uri.parse('http://readify.runasp.net/api/Auth/ResendVerificationCode');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Resend code successful!');
      // You can show a message or perform any additional action
    } else {
      // Resend code failed
      print('Resend code failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'images/21885736-833B-451D-A4A4-2DFE81AD8819.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  ' Verify your email ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' Please enter the 6-digit code sent to the email you wrote    ',
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: 50.0,
                      child: TextField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: _resendCode, // Call _resendCode on button press
                  child: Text('Resend Code'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _verifyCode,
                  child: const Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF28277D),
                  ),
                ),
                SizedBox(height: 10.0),
                // Show error message if verification fails
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

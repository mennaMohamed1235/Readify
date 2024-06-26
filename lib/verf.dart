import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/congratulation.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  VerificationPage({required this.email});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _verifyCode() async {
    if (!_formKey.currentState!.validate()) return;

    String code = _controllers.map((controller) => controller.text).join();

    print('Email: ${widget.email}');
    print('Code: $code');

    final url = Uri.parse('http://readify.runasp.net/api/Auth/VerifyEmail')
        .replace(queryParameters: {
      'email': widget.email,
      'code': code,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CongratulationsScreen()),
        );
      } else {
        String responseBody = response.body;
        if (responseBody.isEmpty) {
          setState(() {
            errorMessage =
                'Verification failed. Please check the code and try again.';
          });
        } else {
          try {
            final errorResponse = json.decode(responseBody);
            print('Verification failed: $responseBody');
            setState(() {
              errorMessage = errorResponse['title'] ??
                  'Verification failed. Please check the code and try again.';
            });
          } catch (e) {
            print('Error decoding response: $e');
            setState(() {
              errorMessage =
                  'Verification failed. Please check the code and try again.';
            });
          }
        }
      }
    } catch (error) {
      print('Unexpected error: $error');
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  Future<void> _resendCode() async {
    final url =
        Uri.parse('http://readify.runasp.net/api/Auth/ResendVerificationCode')
            .replace(queryParameters: {
      'email': widget.email,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('resend code');
      } else {
        String responseBody = response.body;
        if (responseBody.isEmpty) {
          _showSnackBar(
              'Failed to resend verification code. Please try again.');
        } else {
          try {
            final errorResponse = json.decode(responseBody);
            print('Error body: $responseBody');
            _showSnackBar(
                'Failed to resend verification code: ${errorResponse['title']}');
          } catch (e) {
            print('Error decoding response: $e');
            _showSnackBar(
                'Failed to resend verification code. Please try again.');
          }
        }
      }
    } catch (error) {
      _showSnackBar('An error occurred. Please try again later.');
    }
  }

  void _showSnackBar(String message) {
    if (ScaffoldMessenger.of(context).mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      print("ScaffoldMessenger not available to show snackbar: $message");
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'images/21885736-833B-451D-A4A4-2DFE81AD8819.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Verify your email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'We sent a confirmation code to the email addreess that you provided: ${widget.email}',
                ),
                Text(
                  'Please enter the 6-digit code ',
                ),
                const SizedBox(height: 50.0),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 50.0,
                        child: TextFormField(
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
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: _resendCode,
                  child: Text('Resend Code'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _verifyCode,
                  child: const Text('Verify'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF28277D),
                  ),
                ),
                const SizedBox(height: 10.0),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/ChangePassword.dart';
import 'package:readify/SignUpUser.dart';
import 'package:readify/SignUpAuthor.dart';
//import 'package:readify/congratulation.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> signIn() async {
    final String apiUrl = 'http://readify.runasp.net/api/Auth/Login';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePassword()),
      );
      //print('authetintacation sussesfull');
    } else {
      setState(() {
        errorMessage = 'Authentication failed';
      });
    }
  }

  void validatePasswords() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all password fields';
      });
    } else {
      setState(() {
        errorMessage = ''; // Clear the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Image.asset(
                      'images/431382558_934333264581957_6966909f827530271850_n.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFDFDFD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email/username',
                            hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFDFDFD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  ElevatedButton(
                    onPressed: () {
                      signIn();
                      validatePasswords();
                    },
                    child: const Text('Sign in'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF28277D),
                      fixedSize: const Size(450, 45),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      const Text('    Don’t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpUser()),
                          );
                        },
                        child: const Text('Sign up'),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF28277D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_author()),
                          );
                        },
                        child: const Text(' Sign up as an author'),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF28277D),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                  errorMessage.isNotEmpty
                      ? Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

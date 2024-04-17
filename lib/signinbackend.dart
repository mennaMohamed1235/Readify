import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'your_backend_url';

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful sign-in
        return true;
      } else {
        // Unsuccessful sign-in
        return false;
      }
    } catch (e) {
      // Handle error
      return false;
    }
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';
  AuthService _authService = AuthService();

  void validatePasswords() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all password fields';
      });
    } else {
      // Call backend service for authentication
      bool success = await _authService.signIn(email, password);
      if (success) {
        // Navigate to next screen upon successful sign-in
        // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
      } else {
        setState(() {
          errorMessage = 'Invalid email or password';
        });
      }
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
                  Image.asset(
                    'images/431382558_934333264581957_6966909f827530271850_n.jpg',
                    height: 300,
                    width: 300,
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
                      validatePasswords();
                    },
                    child: const Text('Sign in'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF28277D),
                      fixedSize: Size(450, 32),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text('      Don’t have an account?'),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => SignupScreen()),
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
                  TextButton(
                    onPressed: () {
                      // Navigator.push(context,MaterialPageRoute( builder: (context) => signup_author()));
                    },
                    child: const Text('Sign up as an author'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF28277D),
                      ),
                    ),
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

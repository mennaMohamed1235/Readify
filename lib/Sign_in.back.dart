import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/SignUpAuthor.dart';
import 'package:readify/SignUpUser.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse('http://your-backend-url/signin');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        // Sign-in successful, handle navigation or other actions
        print('Sign-in successful');
      } else {
        // Sign-in failed, display error message
        setState(() {
          errorMessage = 'Sign-in failed: ${response.body}';
        });
      }
    } catch (error) {
      // Error occurred during sign-in process
      print('Error signing in: $error');
      setState(() {
        errorMessage = 'Error signing in. Please try again later.';
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
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      signIn(email, password);
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => signup_author()),
                      );
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

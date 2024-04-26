import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  String errorMessage = '';

  Future<void> changePassword() async {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        retypePasswordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all password fields';
      });
      return;
    } else if (newPasswordController.text != retypePasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
      });
      return;
    } else {
      setState(() {
        errorMessage = '';
      });
    }

    final Map<String, dynamic> requestData = {
      "email": "your_email@example.com",
      "currentPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text,
    };

    final String url = 'http://readify.runasp.net/api/Auth/ChangePasswordAsync';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully');
      } else {
        print('Failed to change password');
      }
    } catch (e) {
      // Exception occurred during the HTTP request
      // You can handle the exception scenario here
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFD),
          title: Row(
            children: [
              const SizedBox(width: 0.5),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {},
              ),
              const SizedBox(width: 30),
              Text('Change password',
                  style:
                      GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold)),
              const Icon(Icons.lock_outline),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: currentPasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Current Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: retypePasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Re-type New Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                errorMessage.isNotEmpty
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.black),
                      )
                    : Container(),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    changePassword();
                  },
                  child: const Text('Change password'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF28277D),
                    fixedSize: const Size(450, 45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

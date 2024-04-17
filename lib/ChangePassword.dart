import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  String errorMessage = '';

  void validatePasswords() {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        retypePasswordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all password fields';
      });
    } else if (newPasswordController.text == retypePasswordController.text) {
      setState(() {
        errorMessage = '';
      });
      // Passwords match, you can proceed with the change password logic
    } else {
      setState(() {
        errorMessage = 'Passwords mismatch';
      });
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
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {},
              ),
              const SizedBox(width: 90),
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
                        // obscureText: true,
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
                    validatePasswords();
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

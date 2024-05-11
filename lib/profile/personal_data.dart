import 'package:flutter/material.dart';
import 'package:readify/ChangePassword.dart';
import 'package:readify/profile/edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonalDataScreen(),
    );
  }
}

class PersonalDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: Text(
          '   Your Profile    ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFFFDFDFD),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "images/149071.png",
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildDataRow("First Name", "menna"),
              buildDataRow("Middle Name", "mohamed"),
              buildDataRow("LastName", "Elsayed"),
              buildDataRow("Date of Birth", "22/11/2002"),
              buildDataRow("Phone number", "01092441655"),
              buildDataRow("Email", "mennamohamed2002@gmail.com"),
              SizedBox(height: 30),
              buildButton(
                text: "Change Password",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              buildButton(
                text: "Edit Personal Data",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataRow(String title, String value) {
    return SizedBox(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/profile_icon.png",
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF28277D),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

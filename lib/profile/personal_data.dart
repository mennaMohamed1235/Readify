import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readify/ChangePassword.dart';
import 'package:readify/profile/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  User user = await fetchUserData(
      'USER_ID'); // Replace 'USER_ID' with the actual user ID
  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User user;

  MyApp({required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersonalDataScreen(
        user: user,
        use: '',
      ),
    );
  }
}

Future<User> fetchUserData(String userId) async {
  final response =
      await http.get(Uri.parse('http://readify.runasp.net/api/Auth/$userId'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

class User {
  final String firstName;
  final String middleName;
  final String lastName;
  final String birthDate;
  final String phoneNumber;

  User({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class PersonalDataScreen extends StatelessWidget {
  final User user;

  PersonalDataScreen({required this.user, required String use});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        title: const Text(
          'Your Profile',
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
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "images/149071.png",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildDataRow("First Name", user.firstName),
              buildDataRow("Middle Name", user.middleName),
              buildDataRow("Last Name", user.lastName),
              buildDataRow("Birth Date", user.birthDate),
              buildDataRow("Phone number", user.phoneNumber),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              buildButton(
                text: "Edit Personal Data",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(
                        userId: '',
                      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            title + ": ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
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
          color: const Color(0xFF28277D),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
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
            style: const TextStyle(
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

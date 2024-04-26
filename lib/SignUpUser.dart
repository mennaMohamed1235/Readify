import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SignUpUser extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _register(BuildContext context) async {
    final url = Uri.parse('http://readify.runasp.net/api/Auth/Register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': '/',
      },
      body: jsonEncode({
        'FirstName': firstNameController.text,
        'MiddleName': middleNameController.text,
        'LastName': lastNameController.text,
        'BirthDate':
            '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
        'PhoneNumber': phoneNumberController.text,
        'Email': emailController.text,
        'Password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      print(' Authentication successful');
    } else {
      print('Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fill your profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'Don’t worry, you can always change it later',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/149071.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC4C4C4)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: middleNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Middle Name',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC4C4C4)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFC4C4C4)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        MyDatePicker(),
                        SizedBox(height: 5),
                        TextField(
                          controller: phoneNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // to allow only numbers
                          ],
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _register(context),
                          child: Text('Create'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF28277D),
                            fixedSize: Size(500, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDatePicker extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Birth Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      ),
      onTap: () => _selectDate(context),
    );
  }
}

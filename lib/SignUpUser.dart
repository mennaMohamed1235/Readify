import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:readify/verf.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: SignUpUser(),
      ),
    ),
  );
}

class SignUpUser extends StatefulWidget {
  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Uint8List? _image;
  DateTime selectedDate = DateTime.now();

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
              child: Form(
                key: _formKey,
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
                          _image != null
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundImage: MemoryImage(_image!))
                              : CircleAvatar(
                                  radius: 100,
                                  backgroundImage: AssetImage(
                                      'images/149071.png'), // Default image
                                ),
                          Positioned(
                            bottom: 0,
                            left: 140,
                            child: IconButton(
                              onPressed: () {
                                _pickImage(context);
                              },
                              icon: Icon(Icons.add_a_photo),
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
                              Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
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
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: middleNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your middle name';
                                    }
                                    return null;
                                  },
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
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
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
                            ],
                          ),
                          SizedBox(height: 5),
                          MyDatePicker(
                              selectedDate: selectedDate,
                              onDateChanged: (newDate) {
                                setState(() {
                                  selectedDate = newDate;
                                });
                              }),
                          SizedBox(height: 5),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: phoneNumberController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC4C4C4)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC4C4C4)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFC4C4C4)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              _register(context);
                            },
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
      ),
    );
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    registerUser(context);
  }

  void registerUser(BuildContext context) async {
    FormData formData = FormData.fromMap({
      'FirstName': firstNameController.text,
      'MiddleName': middleNameController.text,
      'LastName': lastNameController.text,
      'PhoneNumber': phoneNumberController.text,
      'Email': emailController.text,
      'Password': passwordController.text,
      'isAuther': false,
      'BirthDate':
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      'NationalityId': '',
    });

    try {
      var response = await Dio().post(
        'http://readify.runasp.net/api/Auth/Register',
        data: formData,
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerificationPage(email: emailController.text)),
        );
      } else {
        print('Registration failed: ${response.data}');
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  void _pickImage(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}

class MyDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  MyDatePicker({required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Birth Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      ),
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }
}

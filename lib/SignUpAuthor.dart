import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readify/verf.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignupAuthor(),
  ));
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
        'BirthDate: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      ),
      onTap: () => _selectDate(context),
    );
  }
}

class SignupAuthor extends StatefulWidget {
  @override
  _SignupAuthorState createState() => _SignupAuthorState();
}

class _SignupAuthorState extends State<SignupAuthor> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedCountry = 'Egypt';
  String selectedDegree = 'Professor';
  String selectedSpecialization = 'Science';
  DateTime selectedDate = DateTime.now();

  Future<void> _pickImage(BuildContext context) async {
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

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.of(context).pop(); // Close the modal sheet
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.of(context).pop(); // Close the modal sheet
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

    await registerUser(context);
  }

  Future<void> registerUser(BuildContext context) async {
    FormData formData = FormData.fromMap({
      'FirstName': firstNameController.text,
      'MiddleName': middleNameController.text,
      'LastName': lastNameController.text,
      'PhoneNumber': phoneNumberController.text,
      'Email': emailController.text,
      'Password': passwordController.text,
      'isAuther': true,
      'BirthDate':
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      'NationalityId': selectedCountry,
    });

    try {
      var response = await Dio().post(
        'http://readify.runasp.net/api/Auth/Register',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.data}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Log the full error
      print('Error registering user: $e');
      if (e is DioException && e.response != null) {
        print('Response data: ${e.response?.data}');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error registering user: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Fill your profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Don’t worry, you can always change it later',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('images/149071.png') as ImageProvider,
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
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: middleNameController,
                                decoration: InputDecoration(
                                  hintText: 'Middle Name',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your middle name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      MyDatePicker(),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 100, child: Text('Specialization')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SpecializationDropdown(
                              selectedSpecialization: selectedSpecialization,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedSpecialization = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 100, child: Text('Degree')),
                          SizedBox(width: 5),
                          Expanded(
                            child: DegreeDropdown(
                              selectedDegree: selectedDegree,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDegree = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 100, child: Text('Country')),
                          SizedBox(width: 5),
                          Expanded(
                            child: CountryDropdown(
                              selectedCountry: selectedCountry,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCountry = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
    );
  }
}

class CountryDropdown extends StatefulWidget {
  final String selectedCountry;
  final ValueChanged<String?> onChanged;

  CountryDropdown({required this.selectedCountry, required this.onChanged});

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<String> countryOptions = [
    'Bolivia',
    'Egypt',
    'Algeria',
    'Belgium',
    'Libya',
    'Kuwait',
    'Jordan',
    'Iraq',
    'United Arab Emirates',
    'Saudi Arabia',
    'Qatar',
    'Bahrain',
    'Syria',
    'Oman',
    'Lebanon',
    'Yemen',
    'Palestine',
    'Tunisia'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedCountry,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: countryOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SpecializationDropdown extends StatefulWidget {
  final String selectedSpecialization;
  final ValueChanged<String?> onChanged;

  SpecializationDropdown(
      {required this.selectedSpecialization, required this.onChanged});

  @override
  _SpecializationDropdownState createState() => _SpecializationDropdownState();
}

class _SpecializationDropdownState extends State<SpecializationDropdown> {
  List<String> specializationOptions = [
    'Science',
    'History',
    'Arts',
    'Social Science',
    'Technology',
    'Medicine',
    'Economics',
    'Computer Science',
    'Anthropology',
    'Linguistics',
    'Engineering'
  ]; // Default specialization options

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedSpecialization,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items:
          specializationOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DegreeDropdown extends StatefulWidget {
  final String selectedDegree;
  final ValueChanged<String?> onChanged;

  DegreeDropdown({required this.selectedDegree, required this.onChanged});

  @override
  _DegreeDropdownState createState() => _DegreeDropdownState();
}

class _DegreeDropdownState extends State<DegreeDropdown> {
  List<String> degreeOptions = [
    'Bachelor\'s',
    'Master\'s',
    'Doctorate',
    'Professor'
  ]; // Default degree options

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedDegree,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: degreeOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

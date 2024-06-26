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
  DateTime selectedDate = DateTime(1920, 11, 22);

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
  DateTime selectedDate = DateTime(1920, 11, 22);

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
    Navigator.of(context).pop();
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
      'NationalityId': '',
      if (_image != null)
        'ProfileImage': await MultipartFile.fromFile(_image!.path),
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
                      SizedBox(height: 5),
                      Text(
                        'Don’t worry, you can always change it later',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(children: [
                    Stack(children: [
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
                    ])
                  ]),
                ),
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
                          SizedBox(
                            width: 100,
                            child: Text('Specialization'),
                          ),
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

List<String> fallbackDegrees = [
  'Bachelor\'s',
  'Master\'s',
  'Doctorate',
  'Professor',
];

class DegreeDropdown extends StatefulWidget {
  final String selectedDegree;
  final ValueChanged<String?> onChanged;

  DegreeDropdown({
    required this.selectedDegree,
    required this.onChanged,
  });

  @override
  _DegreeDropdownState createState() => _DegreeDropdownState();
}

class _DegreeDropdownState extends State<DegreeDropdown> {
  List<String> degreeOptions = [];
  String selectedDegree = 'Professor';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDegrees();
  }

  Future<void> _fetchDegrees() async {
    try {
      final response =
          await Dio().get('http://readify.runasp.net/api/Auth/GetAllDegrees');
      if (response.statusCode == 200) {
        setState(() {
          degreeOptions = List<String>.from(response.data['\$values']);
          selectedDegree = degreeOptions.contains('Professor')
              ? 'Professor'
              : degreeOptions.first;
          isLoading = false;
        });
      } else {
        setState(() {
          degreeOptions = fallbackDegrees;
          selectedDegree = 'Professor';
          isLoading = false;
        });
        print('Failed to load degrees');
      }
    } catch (e) {
      setState(() {
        degreeOptions = fallbackDegrees;
        selectedDegree = 'Professor';
        isLoading = false;
      });
      print('Error fetching degrees: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedDegree,
      onChanged: (isLoading || degreeOptions.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedDegree = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : degreeOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}

List<String> fallbackSpecializations = [
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
  'Engineering',
];

class SpecializationDropdown extends StatefulWidget {
  final String selectedSpecialization;
  final ValueChanged<String?> onChanged;

  SpecializationDropdown({
    required this.selectedSpecialization,
    required this.onChanged,
  });

  @override
  _SpecializationDropdownState createState() => _SpecializationDropdownState();
}

class _SpecializationDropdownState extends State<SpecializationDropdown> {
  List<String> specializations = [];
  String selectedSpecialization = 'Science';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSpecializations();
  }

  Future<void> _fetchSpecializations() async {
    try {
      final response = await Dio()
          .get('http://readify.runasp.net/api/Auth/GetAllSpecializations');
      if (response.statusCode == 200) {
        setState(() {
          specializations = List<String>.from(response.data['\$values']);
          selectedSpecialization = specializations.contains('Science')
              ? 'Science'
              : specializations.first;
          isLoading = false;
        });
      } else {
        setState(() {
          specializations = fallbackSpecializations; // Use fallback list
          selectedSpecialization = 'Science'; // Set a default value
          isLoading = false;
        });
        print('Failed to load specializations');
      }
    } catch (e) {
      setState(() {
        specializations = fallbackSpecializations;
        selectedSpecialization = 'Science';
        isLoading = false;
      });
      print('Error fetching specializations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSpecialization,
      onChanged: (isLoading || specializations.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedSpecialization = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : specializations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}

List<String> fallbackCountries = [
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

class CountryDropdown extends StatefulWidget {
  final String selectedCountry;
  final ValueChanged<String?> onChanged;

  CountryDropdown({
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<String> countries = [];
  String selectedCountry = 'Egypt';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final response = await Dio()
          .get('http://readify.runasp.net/api/Auth/GetAllNationlaites');
      if (response.statusCode == 200) {
        setState(() {
          countries = List<String>.from(response.data['\$values']);
          selectedCountry =
              countries.contains('Egypt') ? 'Egypt' : countries.first;
          isLoading = false;
        });
      } else {
        setState(() {
          countries = fallbackCountries;
          selectedCountry = 'Egypt';
          isLoading = false;
        });
        print('Failed to load countries');
      }
    } catch (e) {
      setState(() {
        countries = fallbackCountries;
        selectedCountry = 'Egypt';
        isLoading = false;
      });
      print('Error fetching countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCountry,
      onChanged: (isLoading || countries.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedCountry = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}

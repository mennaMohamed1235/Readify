import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
        'BirthDate:${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      ),
      onTap: () => _selectDate(context),
    );
  }
}

class signup_author extends StatefulWidget {
  @override
  _signup_authorState createState() => _signup_authorState();
}

class _signup_authorState extends State<signup_author> {
  File? _image; // Define _image variable

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '  Fill your profile ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '    Don’t worry, you can always change it later  ',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 5),
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage:
                                  MemoryImage(_image! as Uint8List),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage('images/149071.png'),
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
                              child: TextField(
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
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextField(
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
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextField(
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      MyDatePicker(),
                      SizedBox(height: 5),
                      Row(children: [
                        Text('Specialization  '),
                        SizedBox(width: 5),
                        Expanded(
                          child: SpecializationDropdown(),
                        ),
                      ]),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Degree         '),
                          SizedBox(width: 5),
                          Expanded(
                            child: DegreeDropdown(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Country        '),
                          SizedBox(width: 5),
                          Expanded(
                            child: CountryDropdown(),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: 'phone number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
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
                      TextField(
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
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    Navigator.of(context).pop(); //close the model sheet
  }

  Future<void> _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    Navigator.of(context).pop();
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: signup_author(),
      ),
    ),
  );
}

class SpecializationDropdown extends StatefulWidget {
  @override
  _SpecializationDropdownState createState() => _SpecializationDropdownState();
}

class _SpecializationDropdownState extends State<SpecializationDropdown> {
  String selectedSpecialization = 'Science'; // Default selected specialization

  List<String> SpecializationOptions = [
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

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSpecialization,
      onChanged: (newValue) {
        setState(() {
          selectedSpecialization = newValue!;
        });
      },
      items:
          SpecializationOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DegreeDropdown extends StatefulWidget {
  @override
  _DegreeDropdownState createState() => _DegreeDropdownState();
}

class _DegreeDropdownState extends State<DegreeDropdown> {
  String selectedDegree = 'Professor'; // Default selected degree

  List<String> degreeOptions = [
    'Bachelor\'s',
    'Master\'s',
    'Doctorate',
    'Professor'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedDegree,
      onChanged: (newValue) {
        setState(() {
          selectedDegree = newValue!;
        });
      },
      items: degreeOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CountryDropdown extends StatefulWidget {
  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String selectedCountry = 'Egypt'; // Default selected country

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
      value: selectedCountry,
      onChanged: (newValue) {
        setState(() {
          selectedCountry = newValue!;
        });
      },
      items: countryOptions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

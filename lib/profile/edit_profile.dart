import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/EditProfileScreen";

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late File _image;
  bool buttonClicked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _image = File('');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF28277D),
          centerTitle: true,
          title: Text(
            "Update Your Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.white, // Set the color of the icon to white
          ),
          iconTheme:
              IconThemeData(color: Colors.white), // Ensure icon color is white
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Stack(
                        children: [
                          // ignore: unnecessary_null_comparison
                          _image != null && _image.path.isNotEmpty
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundImage: FileImage(_image),
                                )
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
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "First Name",
                                hintText: "Enter your first name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Middle Name",
                                hintText: "Enter your middle name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your middle name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                hintText: "Enter your last name",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Birth Date",
                          hintText: "Enter your birth date",
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birth date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: media.height * 0.02,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: media.height * 0.05,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process form data
                          }
                        },
                        child: Text("Update Profile"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF28277D),
                        ),
                      ),
                      SizedBox(
                        height: media.height * 0.015,
                      ),
                    ],
                  ),
                ),
              ),
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

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    Navigator.of(context).pop(); //close the model sheet
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    Navigator.of(context).pop();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfileScreen(),
    );
  }
}

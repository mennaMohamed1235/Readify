import 'package:flutter/material.dart';

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
          'Birth_Date:${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
      onTap: () => _selectDate(context),
    );
  }
}

class SignUpUser extends StatelessWidget {
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Color(0xFF28277D),
                          ),
                          // child: EditIconExample(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                      TextField(
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
                      MyDatePicker(),
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
                      SizedBox(height: 3),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'confirm_password',
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
                        onPressed: () {},
                        child: Text('create'),
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

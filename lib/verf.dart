import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset(
                    'images/images (1).png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  ' Verify your email ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '  Please enter the 6-digit code sent to regors@example.com   ',
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: 50.0,
                      child: TextField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Resend code functionality
                    // Implement resend code logic here
                  },
                  child: Text('Resend Code'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Confirm button functionality
                    // Implement confirm code logic here
                  },
                  child: Text('Confirm'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Change email button functionality
                    // Implement change email code logic here
                  },
                  child: Text('Change Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

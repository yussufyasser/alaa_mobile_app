import 'dart:typed_data';

import 'package:fintech/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _loginScreen();
  }

}



class _loginScreen extends State<LoginScreen>{

Future<void> sendImageToAPI(String base64Image) async {
  print('sendddddddd');
  try {
    final url = 'http://'+Main.ip+':8000/get_email'; 
    final payload = {'image': base64Image};

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );


    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if(responseData['message']=='1')
      Main.Alert('please','check your email',context);
      print('Response from API: ${responseData['message']}');
    } else {
      print('Failed to send image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending image to API: $e');
  }
}

  TextEditingController _emailController=TextEditingController(),_passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/luxury_villa_2.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Content (Login Form)
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'Fractional Nest',
                    style: TextStyle(
                      fontSize: 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Login Form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 550,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Semi-transparent background
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Email Field
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'email / phone number',
                              filled: true,
                              fillColor: Color(0xFFD1E3F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          // Password Field
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'password',
                              filled: true,
                              fillColor: Color(0xFFD1E3F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Forgot Password Text
                          TextButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                              print('iiiiii');
                              if (pickedFile != null) {
                                final imageBytes = await pickedFile.readAsBytes();
                                String base64Image = base64Encode(imageBytes);
                                print('fffffff');
                                sendImageToAPI(base64Image);
                              }

                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          // Login Button
                          ElevatedButton(
                            onPressed: () async {

                              try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text
                                );
                                Navigator.pushReplacementNamed(context, '/intro');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found' && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                  Main.Alert('sorry','mismatch between password and email',context);
                                } else if (e.code == 'wrong-password'&& _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty ) {
                                  Main.Alert('sorry','mismatch between password and email',context);
                                }
                                else if(_emailController.text.isEmpty || _passwordController.text.isEmpty){

                                  Main.Alert('sorry','fill the whole requirements',context);

                                }
                                else{
                                  Main.Alert('sorry','mismatch between password and email',context);

                                }
                              }

                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6D7D7F),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Register Prompt
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  // About Us, Privacy Policy, Contact Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "About Us",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Phone: +201115013137\nEmail: support@fractionalnest.com",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Follow Us
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Follow Us:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
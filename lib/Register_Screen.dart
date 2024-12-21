import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fintech/main.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

Future<bool> sendImageToAPI(String base64Image,String email) async {
  try {
    final url = 'http://'+Main.ip+':9000/send_image';
    final payload = {'email': email,'image':base64Image};
    print(url);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response from API: ${responseData['message']}');
      if(responseData['message']=='1')
      return true;
      else
      return false;
    } else {
      print('Failed to send image. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error sending image to API: $e');
  }

  return false;
}
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  bool isStrongPassword(String password) {
    if (password.length >= 8 && 
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password)) {
      return true; // Strong password
    }
    return false; // Weak password
  }


  // Validator for matching passwords
  String? _validatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    if(!isStrongPassword(value))
    return 'please use password at least of 8 characters,contain \nat least one number,big \ncharacter,small character and symbol';

    return null;
  }

  // Validator for phone number
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+20\d{10}$').hasMatch(value)) {
      return 'Phone number must start with +20 and have exactly 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/luxury_villa_1.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Content (Registration Form)
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 44,
                      color: const Color.fromARGB(255, 247, 0, 0),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Register Form
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                fillColor: Color(0xFFD1E3F1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email or phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                                                           
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(hintText: '+20XXXXXXXXXX',filled: true,
                              fillColor: Color(0xFFD1E3F1),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none,),),
                              maxLength: 13, 
                              validator: _validatePhoneNumber,
                              ),
                            SizedBox(height: 15),
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                fillColor: Color(0xFFD1E3F1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                filled: true,
                                fillColor: Color(0xFFD1E3F1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: _validatePasswordConfirmation,
                            ),
                            SizedBox(height: 15),
                            // Register Button
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {

                     
                                final ImagePicker _picker = ImagePicker();
                                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                                if (pickedFile != null) {
                                  final imageBytes = await pickedFile.readAsBytes();
                                  String base64Image = base64Encode(imageBytes);
                                  Future<bool> flag=sendImageToAPI(base64Image,_emailController.text);
                                  if(await flag){

                                    try {
                                          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword
                                          (email: _emailController.text,password: _passwordController.text);
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful!')),);
                                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); 
                                        } on FirebaseAuthException catch (e) {
                                         if (e.code == 'email-already-in-use') {
                                            Main.Alert('sorry', 'Email is used', context);
                                          }
                                        } catch (e) {
                                          print(e);
                                  }
                                  }
                                  else
                                  Main.Alert('please', 'take a prober image\n where your face appear in it', context);
                                  
                                }
 
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF6D7D7F),
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Login Prompt
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/');
                              },
                              child: Text(
                                "Already have an account?",
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


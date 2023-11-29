import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/error_handling/error_handler.dart'; // Import your ErrorHandler class

class Signup extends StatefulWidget {
  static const String id = "/signup";

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

  List<String> roles = ['student', 'academy', 'mentor', 'trainer'];
  String? selectedRole;
  Widget? _captchaImageWidget;
  // ignore: unused_field
  bool _refresh = false;
  String error = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void handleRefresh() {
    setState(() {
      _refresh = true;
    });
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _refresh = false;
      });
    });
  }

  void handleDropdownChange(String? value) {
    setState(() {
      selectedRole = value;
    });
  }

  void refreshCaptcha() {
    setState(() {
      displayCaptcha();
    });
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        error = '';
      });

      try {
        final response = await APIService.registerUser(
          usernameController.text,
          passwordController.text,
          phoneController.text,
          captchaController.text,
          selectedRole!,
        );

        if (response != null) {
          final status = response['status'];
          if (status == 200) {
            print('Registration successful');
            Navigator.of(context).pushReplacementNamed(Login.id);
          } else if (status == 401) {
            _showErrorDialog('Incorrect captcha. Please try again.');
            _clearCaptchaField();
            refreshCaptcha();
          } else if (status == 409) {
            setError('User already exists. Please sign in.');
          } else {
            setError('An unexpected error occurred. Please try again later.');
          }
        } else {
          setError('No response from server. Please try again.');
        }
      } catch (e) {
        setError('An error occurred: $e');
      }
    }
  }

  void _clearCaptchaField() {
    captchaController.clear();
  }

  void setError(String errorMsg) {
    setState(() {
      error = errorMsg;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    displayCaptcha();
    super.initState();
  }

  Future<void> displayCaptcha() async {
    final captchaImageData = await APIService.fetchCaptchaImageData();

    if (captchaImageData != null &&
        captchaImageData.containsKey('imageBase64')) {
      final base64String = captchaImageData['imageBase64'];
      final List<int> bytes = base64Decode(base64String);

      setState(() {
        _captchaImageWidget = Image.memory(Uint8List.fromList(bytes));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: size.height * 0.001,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.1,
                    ),
                  ),
                  SizedBox(height: size.height * 0.023),
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: size.height * 0.018),
                  Text(
                    "Create a new account",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: size.height * 0.020),
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: ErrorHandler.validateEmail,
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: ErrorHandler.validatePassword,
                  ),
                  SizedBox(height: size.height * 0.016),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Phone",
                    ),
                    validator: ErrorHandler.validatePhoneNumber,
                  ),
                  SizedBox(height: size.height * 0.020),
                  Row(
                    children: [
                      _captchaImageWidget ?? Container(),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: refreshCaptcha,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: captchaController,
                    decoration: InputDecoration(
                      hintText: "Captcha",
                    ),
                    validator: ErrorHandler.validateCaptcha,
                  ),
                  SizedBox(height: size.height * 0.020),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Role',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    onChanged: handleDropdownChange,
                    items: roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.025),
                  ElevatedButton(
                    onPressed: registerUser,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
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

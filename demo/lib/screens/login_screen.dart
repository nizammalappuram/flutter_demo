import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/screens/welcome_screen.dart';
import 'package:demo/screens/signup_screen.dart';

class Login extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = ''; // Initialize with the default value
  String? errorUsername;
  String? errorPassword;
  String? errorRole;
  String? errorMessage;

  List<Map<String, String>> roleOptions = [
    {'key': 'student', 'text': 'Student', 'value': 'student'},
    {'key': 'trainer', 'text': 'Trainer', 'value': 'trainer'},
    {'key': 'mentor', 'text': 'Mentor', 'value': 'mentor'},
    {'key': 'academy', 'text': 'Academy', 'value': 'academy'},
  ];

  void handleRoleSelection(String? value) {
    setState(() {
      selectedRole = value ?? '';
      errorRole = null;
    });
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final String username = usernameController.text;
    final String password = passwordController.text;

    setState(() {
      errorUsername = null;
      errorPassword = null;
      errorMessage = null;
    });

    if (selectedRole.isEmpty) {
      setState(() {
        errorRole = 'Please select a role';
      });
      return;
    }

    try {
      final Map<String, dynamic>? response =
          await APIService.loginUser(username, password, selectedRole);

      if (response != null) {
        print('Login Response: $response');

        if (response.containsKey('token')) {
          final String? token = response['token'];

          final parts = token!.split('.');
          if (parts.length != 3) {
            throw Exception('Invalid token');
          }

          final payload = parts[1];
          final normalized = base64Url.normalize(payload);
          final decodedPayload = utf8.decode(base64Url.decode(normalized));

          final payloadMap = json.decode(decodedPayload);
          print('Decoded Token Payload: $payloadMap');

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          print('Token saved to shared preferences');

          print('Login successful!');
          Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
          return;
        }
      }
      print('Failed to log in. Invalid response or token');
      setState(() {
        errorMessage = 'username and password are incorrect';
      });
    } on DioError catch (e) {
      print('DioError occurred: $e');
      if (e.response?.statusCode == 401) {
        setState(() {
          errorMessage = 'Invalid credentials. Please check your username, password, and role.';
        });
      } else {
        setState(() {
          errorMessage = 'Unexpected error occurred: $e';
        });
      }
    } on Exception catch (e) {
      print('Exception occurred: $e');
      setState(() {
        errorMessage = 'Error occurred: $e';
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
              vertical: size.height * 0.05,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.2,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Text(
                    "Welcome!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: size.height * 0.05),
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username can\'t be empty';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can\'t be empty';
                      }
                      return null;
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: roleOptions.map((role) {
                      return ElevatedButton(
                        onPressed: () {
                          handleRoleSelection(role['value']);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: role['value'] == selectedRole
                              ? Colors.blue
                              : null,
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          role['text']!,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 40.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  if (_hasError())
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          if (errorUsername != null)
                            Text(errorUsername!,
                                style: TextStyle(color: Colors.red)),
                          if (errorPassword != null)
                            Text(errorPassword!,
                                style: TextStyle(color: Colors.red)),
                          if (errorRole != null)
                            Text(errorRole!,
                                style: TextStyle(color: Colors.red)),
                          if (errorMessage != null)
                            Text(errorMessage!,
                                style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Signup.id);
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _hasError() {
    return errorUsername != null ||
        errorPassword != null ||
        errorRole != null ||
        errorMessage != null;
  }
}




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String apiUrl = 'http://10.0.2.2:5000/student/login'; // Replace with your login API endpoint

    final Map<String, dynamic> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successful login
      print('User logged in successfully');
      // You can navigate to the home screen or handle it as needed.
    } else {
      // Login failed
      print('Failed to log in. Status code: ${response.statusCode}');
      // You can handle errors, show an error message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Define the 'size' variable here

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: size.height * 0.001,
            ),
            child: Column(
              children: [
                // ... Your login screen UI

                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: Text("Login"),
                ),
                // ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

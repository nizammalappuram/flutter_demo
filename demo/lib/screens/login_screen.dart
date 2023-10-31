import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/app_style.dart';
import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/dashboard_screen.dart'; // Import your dashboard screen file

class Login extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final userData = await APIService.loginUser(email, password);

    if (userData != null) {
      print('User logged in successfully');
      // Navigate to the dashboard after successful login
      Navigator.of(context).pushReplacementNamed(Dashboard.id);
    } else {
      print('Failed to log in');
      // Handle errors or display an error message
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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    logoImage, // Replace with your actual logo image path
                    height: size.height * 0.1,
                  ),
                ),
                SizedBox(height: size.height * 0.023),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.018),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: kLightTextColor),
                  decoration: InputDecoration(
                    hintText: "Email",
                    // Include your email icon
                  ),
                ),
                // Add other TextFields like password field, etc.
                SizedBox(height: size.height * 0.025),
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: size.height * 0.034),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?\t",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Signup.id, (route) => false);
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: kTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

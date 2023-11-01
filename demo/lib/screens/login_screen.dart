import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    try {
      final Map<String, dynamic>? response = await APIService.loginUser(email, password);

      if (response != null && response.containsKey('statusCode') && response['statusCode'] == 200) {
        final String? rawCookie = response['set-cookie'];

        if (rawCookie != null) {
          await saveCookie(rawCookie);

          final String? token = response['token']; // Extract token from the response

          if (token != null) {
            // Token handling - saving token to SharedPreferences
            await saveToken(token);
          }

          // Successful login, move to dashboard screen
          Navigator.of(context).pushReplacementNamed(Dashboard.id);
        } else {
          // Handle null cookie if required
          print('Cookie is null');
        }
      } else {
        // Handle login failure
        print('Failed to log in');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to log in'),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // Handle network errors or exceptions
      print('Exception occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again.'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookie', cookie);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
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
                    'assets/images/logo.png', // Replace with your actual logo image path
                    height: size.height * 0.1,
                  ),
                ),
                SizedBox(height: size.height * 0.023),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline5,
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
                SizedBox(height: size.height * 0.018),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: kLightTextColor),
                  decoration: InputDecoration(
                    hintText: "Password",
                    // Include your password icon
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                SizedBox(height: size.height * 0.034),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?\t",
                      style: Theme.of(context).textTheme.subtitle1,
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
                            .subtitle1!
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

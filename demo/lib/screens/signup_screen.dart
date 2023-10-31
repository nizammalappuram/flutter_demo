

import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Signup extends StatefulWidget {
  static const String id = "/signup";

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    final String email = emailController.text;
    final String username = usernameController.text;
    final String password = passwordController.text;

    final userData = await APIService.registerUser(email, username, password);


    if (userData != null) {
      print('User registered successfully');
      // Navigate to the login screen
      Navigator.of(context).pushReplacementNamed(Login.id);
    } else {
      print('Failed to register user');
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
              "Sign Up",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: size.height * 0.018),
            Text(
              "Create a new account",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 15),
            ),
            SizedBox(height: size.height * 0.020),
            TextField(
              controller: emailController,
              style: const TextStyle(color: kLightTextColor),
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    'assets/icons/email.svg', // Replace with your email icon path
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.016),
            TextField(
              controller: usernameController,
              style: const TextStyle(color: kLightTextColor),
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    'assets/icons/user.svg', // Replace with your user icon path
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.016),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: kLightTextColor),
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    'assets/icons/lock.svg', // Replace with your lock icon path
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.016),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: kLightTextColor),
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(
                    'assets/icons/lock.svg', // Replace with your lock icon path
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  registerUser();
                } else {
                  print("Passwords don't match.");
                }
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: size.height * 0.034),
            Row(
              children: [
                const Expanded(child: Divider(color: kLightTextColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "or Sign Up with Google",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Expanded(child: Divider(color: kLightTextColor)),
              ],
            ),
            SizedBox(height: size.height * 0.025),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: kWhiteColor, // Use 'primary' to set the background color
                elevation: 0,
              ),
              child: Text(
                "Sign Up with Google",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16, color: kBlackColor),
              ),
            ),
            SizedBox(height: size.height * 0.041),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a member?\t",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Login.id, (route) => false);
                  },
                  child: Text(
                    "Sign In",
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


// import 'package:flutter/material.dart';
// import 'package:demo/services/user_service.dart';
// import 'package:demo/app_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:demo/screens/signup_screen.dart';
// import 'package:demo/screens/dashboard_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login extends StatefulWidget {
//   static const String id = "/login";

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> loginUser() async {
//     final String email = emailController.text;
//     final String password = passwordController.text;

//     try {
//       final Map<String, dynamic>? response = await APIService.loginUser(email, password);

//       if (response != null && response.containsKey('statusCode') && response['statusCode'] == 200) {
//         final String? rawCookie = response['set-cookie'];

//         if (rawCookie != null) {
//           await saveCookie(rawCookie);

//           final String? token = response['token']; // Extract token from the response

//           if (token != null) {
//             // Token handling - saving token to SharedPreferences
//             await saveToken(token);
//           }

//           // Successful login, move to dashboard screen
//           Navigator.of(context).pushReplacementNamed(Dashboard.id);
//         } else {
//           // Handle null cookie if required
//           print('Cookie is null');
//         }
//       } else {
//         // Handle login failure
//         print('Failed to log in');
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to log in'),
//           duration: Duration(seconds: 3),
//         ));
//       }
//     } catch (e) {
//       // Handle network errors or exceptions
//       print('Exception occurred: $e');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('An error occurred. Please try again.'),
//         duration: Duration(seconds: 3),
//       ));
//     }
//   }

//   Future<void> saveCookie(String cookie) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('cookie', cookie);
//   }

//   Future<void> saveToken(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.width * 0.1,
//               vertical: size.height * 0.001,
//             ),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Image.asset(
//                     'assets/images/logo.png', // Replace with your actual logo image path
//                     height: size.height * 0.1,
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.023),
//                 Text(
//                   "Login",
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 SizedBox(height: size.height * 0.018),
//                 TextField(
//                   controller: emailController,
//                   style: const TextStyle(color: kLightTextColor),
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     // Include your email icon
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.018),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   style: const TextStyle(color: kLightTextColor),
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     // Include your password icon
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.025),
//                 ElevatedButton(
//                   onPressed: () {
//                     loginUser();
//                   },
//                   child: Text(
//                     "Login",
//                     style: Theme.of(context).textTheme.button,
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.034),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account?\t",
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                     CupertinoButton(
//                       padding: EdgeInsets.zero,
//                       onPressed: () {
//                         Navigator.of(context).pushNamedAndRemoveUntil(
//                             Signup.id, (route) => false);
//                       },
//                       child: Text(
//                         "Sign Up",
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1!
//                             .copyWith(color: kTextColor),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// --------------------------------------------------------------------------

import 'package:demo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/services/user_service.dart';
import 'package:demo/app_style.dart';
import 'package:demo/screens/signup_screen.dart';

class Login extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = ''; // Initialize with the default value

  List<Map<String, String>> roleOptions = [
    {'key': 'student', 'text': 'Student', 'value': 'student'},
    {'key': 'trainer', 'text': 'Trainer', 'value': 'trainer'},
    {'key': 'mentor', 'text': 'Mentor', 'value': 'mentor'},
    {'key': 'academy', 'text': 'Academy', 'value': 'academy'},
  ];

  void handleRoleSelection(String? value) {
    // Ensure a default value is provided in case value is null
    setState(() {
      selectedRole = value ?? '';
    });
  }

  Future<void> loginUser() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (selectedRole.isEmpty) {
      print('No role selected');
      // Handle no role selected scenario
      return;
    }

    try {
      final Map<String, dynamic>? response =
          await APIService.loginUser(username, password, selectedRole);

      if (response != null) {
      print('Login Response: $response');

      if (response.containsKey('token')) {
        final String? token = response['token'];

        if (token != null) {
          // Store the token locally using shared_preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          // Handle successful login
          print('Login successful!');

          // Navigate to the dashboard screen or any other screen
          Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
        } else {
          print('Token is null');
          // Handle token null scenario
        }
      } else {
        print('Response does not contain a token');
        // Handle response without a token
      }
    } else {
      print('Failed to log in. Response is null.');
      // Handle null response
    }
  } on Exception catch (e) {
    print('Exception occurred: $e');
    // Handle other exceptions
  } catch (e) {
    print('Unexpected error: $e');
    // Handle unexpected errors
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png', // Replace with your actual logo image path
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  "Welcome!",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: size.height * 0.05),
                TextField(
                  controller: usernameController,
                  style: const TextStyle(color: kLightTextColor),
                  decoration: InputDecoration(
                    hintText: "Username",
                    // Include your username icon
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: kLightTextColor),
                  decoration: InputDecoration(
                    hintText: "Password",
                    // Include your password icon
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                // Use ElevatedButtons for role selection
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
                            ? Colors
                                .blue // Change the color for the selected role
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
                  onPressed: () {
                    loginUser();
                  },
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







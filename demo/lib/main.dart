// import 'package:flutter/material.dart';
// import 'package:demo/screens/login_screen.dart';
// import 'package:demo/screens/signup_screen.dart';
// import 'package:demo/screens/home_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App',
//       initialRoute: SignupScreen.id,
//       routes: {
//         LoginScreen.id: (context) => LoginScreen(),
//         SignupScreen.id: (context) => SignupScreen(),
//         HomeScreen.id: (context) => HomeScreen(),
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/screens/dashboard_screen.dart'; // Assuming the dashboard screen is named 'Dashboard'

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduvocate',
      initialRoute: Signup.id,
      routes: {
        Signup.id: (context) => Signup(),
        Login.id: (context) => Login(),
        Dashboard.id: (context) => Dashboard(), // Replace 'Dashboard' with your actual dashboard screen
      },
    );
  }
}

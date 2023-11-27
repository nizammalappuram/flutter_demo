
// // import 'package:demo/screens/home_screen.dart';
// // import 'package:demo/screens/welcome_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:demo/screens/signup_screen.dart';
// // import 'package:demo/screens/login_screen.dart';
// // // ignore: duplicate_import

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Eduvocate',
// //       initialRoute: Signup.id,
// //       routes: {
// //         Signup.id: (context) => Signup(),
// //         Login.id: (context) => Login(),
// //         WelcomeScreen.id: (context) => WelcomeScreen(),
// //         Home.id: (context) => Home()
// //       },
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:demo/screens/home_screen.dart';
// import 'package:demo/screens/welcome_screen.dart';
// import 'package:demo/screens/signup_screen.dart';
// import 'package:demo/screens/login_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Eduvocate',
//       initialRoute: '/', // Update with the relevant initial route
//       routes: {
//         '/': (context) => HomeScreen(), // Update this with your landing page widget
//         Signup.id: (context) => Signup(),
//         Login.id: (context) => Login(),
//         WelcomeScreen.id: (context) => WelcomeScreen(),
//       },
//     );
//   }
// }

import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/home_screen.dart';
import 'package:demo/screens/welcome_screen.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:demo/app_config.dart';
import 'package:demo/logging/logging_setup.dart'; // Import the logging setup file

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogging().then((_) {
    final AppConfig config = AppConfig(apiUrl: 'dev'); // Instantiate your AppConfig
    final APIService apiService = APIService(config); // Instantiate your APIService
    runApp(MyApp(config: config, apiService: apiService)); // Provide both config and apiService
  });
}

class MyApp extends StatelessWidget {
  final AppConfig config;

  MyApp({required this.config, required APIService apiService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eduvocate',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(config: config),
        Signup.id: (context) => Signup(),
        Login.id: (context) => Login(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
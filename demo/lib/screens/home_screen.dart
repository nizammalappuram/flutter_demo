// import 'package:flutter/material.dart';
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
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomeScreen(),
//         Signup.id: (context) => Signup(),
//         Login.id: (context) => Login(),
//       },
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create your future career'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/logo.png', // Replace with your image path
//                 width: 300,
//                 height: 200,
//                 fit: BoxFit.contain,
//               ),

//               SizedBox(height: 20),

//               Text(
//                 'Welcome to Eduvocate',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               Text('Powered by Future Ready foundation.'),

//               SizedBox(height: 20),

//               Text(
//                 'Get Ready for an excellent career guidance...',
//                 textAlign: TextAlign.center,
//               ),

//               SizedBox(height: 20),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, Signup.id); // Navigate to signup page
//                     },
//                     child: Text('Signup'),
//                   ),
//                   SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, Login.id); // Navigate to login page
//                     },
//                     child: Text('Login'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(20.0),
//         color: Colors.grey[300],
//         child: Text(
//           '© Eduvocate 2023. All rights reserved.',
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// // Placeholder pages for signup and login screens
// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Signup'),
//       ),
//       body: Center(
//         child: Text('Signup Page'),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Center(
//         child: Text('Login Page'),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:demo/app_config.dart'; // Import your AppConfig file
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppConfig config; // Add AppConfig as a parameter

  HomeScreen({required this.config}); // Constructor accepting AppConfig

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your future career'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20),

              Text(
                'Welcome to Eduvocate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Powered by Future Ready foundation.'),

              SizedBox(height: 20),

              Text(
                'Get Ready for an excellent career guidance...',
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Signup.id);
                    },
                    child: Text('Signup'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Text('Login'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                'API URL: ${config.apiUrl}', // Use the API URL from AppConfig
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          '© Eduvocate 2023. All rights reserved.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

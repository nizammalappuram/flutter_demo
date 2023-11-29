import 'package:flutter/material.dart';
import 'package:demo/app_config.dart'; // Import your AppConfig file
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/login_screen.dart';
// import 'package:demo/logging_setup.dart'; // Import the logging setup file
import 'package:demo/app_config.dart'; // Import your AppConfig file
// import 'package:demo/logging/logging_setup.dart'; // Import the logging setup file
// import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  final AppConfig config; // Add AppConfig as a parameter

  HomeScreen({required this.config}); // Constructor accepting AppConfig

  @override
  Widget build(BuildContext context) {
    // logger.info('Building HomeScreen'); // Log an informational message
    // // Example scenario: Checking a specific configuration
    // if (config.someValue == null) {
    //   logger.warning('Configuration value is null. Some features may not work.'); // Log a warning message
    // }
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create your future career',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 20),

              Text(
                'Welcome to Eduvocate',
                style: TextStyle(fontSize: 20),
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
                      // if (someCondition) {
                      //   logger.error('Error: Condition is not met.'); // Log an error message
                      // }
                      // logger.debug('Signup button pressed'); // Log a debug message
                      Navigator.pushNamed(context, Signup.id);
                    },
                    child: Text('Signup'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // logger.debug('Login button pressed'); // Log a debug message
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Text('Login'),
                  ),
                ],
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

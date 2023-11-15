// import 'package:flutter/material.dart';
// import 'package:demo/services/user_service.dart';
// import 'package:demo/app_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:demo/screens/login_screen.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Signup extends StatefulWidget {
//   static const String id = "/signup";

//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   Future<void> registerUser() async {
//     final String email = emailController.text;
//     final String username = usernameController.text;
//     final String password = passwordController.text;

//     final userData = await APIService.registerUser(email, username, password);

//     if (userData != null) {
//       print('User registered successfully');
//       // Navigate to the login screen
//       Navigator.of(context).pushReplacementNamed(Login.id);
//     } else {
//       print('Failed to register user');
//       // Handle errors or display an error message
//     }
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
//               Align(
//               alignment: Alignment.topCenter,
//               child: Image.asset(
//                 logoImage, // Replace with your actual logo image path
//                 height: size.height * 0.1,
//               ),
//             ),
//             SizedBox(height: size.height * 0.023),
//             Text(
//               "Sign Up",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             SizedBox(height: size.height * 0.018),
//             Text(
//               "Create a new account",
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall!
//                   .copyWith(fontSize: 15),
//             ),
//             SizedBox(height: size.height * 0.020),
//             TextField(
//               controller: emailController,
//               style: const TextStyle(color: kLightTextColor),
//               decoration: InputDecoration(
//                 hintText: "Email",
//                 prefixIcon: IconButton(
//                   onPressed: null,
//                   icon: SvgPicture.asset(
//                     'assets/icons/email.svg', // Replace with your email icon path
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: size.height * 0.016),
//             TextField(
//               controller: usernameController,
//               style: const TextStyle(color: kLightTextColor),
//               decoration: InputDecoration(
//                 hintText: "Username",
//                 prefixIcon: IconButton(
//                   onPressed: null,
//                   icon: SvgPicture.asset(
//                     'assets/icons/user.svg', // Replace with your user icon path
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: size.height * 0.016),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               style: const TextStyle(color: kLightTextColor),
//               decoration: InputDecoration(
//                 hintText: "Password",
//                 prefixIcon: IconButton(
//                   onPressed: null,
//                   icon: SvgPicture.asset(
//                     'assets/icons/lock.svg', // Replace with your lock icon path
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: size.height * 0.016),
//             TextField(
//               controller: confirmPasswordController,
//               obscureText: true,
//               style: const TextStyle(color: kLightTextColor),
//               decoration: InputDecoration(
//                 hintText: "Confirm Password",
//                 prefixIcon: IconButton(
//                   onPressed: null,
//                   icon: SvgPicture.asset(
//                     'assets/icons/lock.svg', // Replace with your lock icon path
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: size.height * 0.025),
//             ElevatedButton(
//               onPressed: () {
//                 if (passwordController.text == confirmPasswordController.text) {
//                   registerUser();
//                 } else {
//                   print("Passwords don't match.");
//                 }
//               },
//               child: Text(
//                 "Sign Up",
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ),
//             SizedBox(height: size.height * 0.034),
//             Row(
//               children: [
//                 const Expanded(child: Divider(color: kLightTextColor)),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     "or Sign Up with Google",
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                 ),
//                 const Expanded(child: Divider(color: kLightTextColor)),
//               ],
//             ),
//             SizedBox(height: size.height * 0.025),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 primary: kWhiteColor, // Use 'primary' to set the background color
//                 elevation: 0,
//               ),
//               child: Text(
//                 "Sign Up with Google",
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleSmall!
//                     .copyWith(fontSize: 16, color: kBlackColor),
//               ),
//             ),
//             SizedBox(height: size.height * 0.041),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Already a member?\t",
//                   style: Theme.of(context).textTheme.titleSmall,
//                 ),
//                 CupertinoButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () {
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                         Login.id, (route) => false);
//                   },
//                   child: Text(
//                     "Sign In",
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall!
//                         .copyWith(color: kTextColor),
//                   ),
//                 ),
//               ],
//             ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// -----------------------------------------------------------------------------

// // test code

// import 'dart:convert';
// import 'dart:typed_data'; // Import dart:typed_data for Uint8List

// import 'package:flutter/material.dart';
// import 'package:demo/services/user_service.dart';
// // ignore: unused_import
// import 'package:demo/app_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:demo/screens/login_screen.dart';
// // ignore: unused_import
// import 'package:flutter_svg/flutter_svg.dart';

// class Signup extends StatefulWidget {
//   static const String id = "/signup";

//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController captchaController = TextEditingController();

//   List<String> roles = ['student', 'academy', 'mentor', 'trainer'];
//   String? selectedRole;
//   Image? _captchaImage; // Captcha image variable

//   @override
//   void initState() {
//     displayCaptcha(); // Fetch the captcha image URL when the UI initializes
//     super.initState();
//   }

//   Future<void> displayCaptcha() async {
//     final captchaImageData = await APIService.fetchCaptchaImageData();

//     if (captchaImageData != null &&
//         captchaImageData.containsKey('imageBase64')) {
//       setState(() {
//         final base64String = captchaImageData['imageBase64'];
//         final List<int> bytes = base64Decode(base64String);
//         _captchaImage = Image.memory(Uint8List.fromList(bytes));
//       });
//     }
//   }

//   Future<void> registerUser() async {
//     try {
//       final String username = usernameController.text;
//       final String password = passwordController.text;
//       final String phone = phoneController.text;
//       final String captcha = captchaController.text;

//       if (selectedRole == null) {
//         print('Please select a role');
//         return;
//       }
//       final response = await APIService.registerUser(
//           username, password, phone, captcha, selectedRole);

//       if (response != null) {
//         print('User registered successfully');
//         // Navigate to the login screen
//         Navigator.of(context).pushReplacementNamed(Login.id);
//       } else {
//         print('Failed to register user');
//         // Handle errors or display an error message
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//     }
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
//                   "Sign Up",
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 SizedBox(height: size.height * 0.018),
//                 Text(
//                   "Create a new account",
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 SizedBox(height: size.height * 0.020),
//                 TextField(
//                   controller: usernameController,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: "Username",
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.016),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.016),
//                 TextField(
//                   controller: phoneController,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: "Phone",
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.020),
//                 // Display the captcha image before the captcha text field
//                 _captchaImage != null ? _captchaImage! : Container(),
//                 SizedBox(height: size.height * 0.025),
//                 TextField(
//                   controller: captchaController,
//                   style: TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     hintText: "Captcha",
//                   ),
//                 ),
//                 Container(
//                   height: size.height * 0.06,
//                   child: SingleChildScrollView(
//                     child: DropdownButton<String>(
//                       value: selectedRole,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedRole = newValue;
//                         });
//                       },
//                       items: roles.map((String role) {
//                         return DropdownMenuItem<String>(
//                           value: role,
//                           child: Text(role),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.025),
//                 ElevatedButton(
//                   onPressed: registerUser,
//                   child: Text("Sign Up", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // test code

// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data'; // Import dart:typed_data for Uint8List

// import 'package:demo/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:demo/services/user_service.dart';

// class Signup extends StatefulWidget {
//   static const String id = "/signup";

//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _captchaController = TextEditingController();

//   List<String> roles = ['student', 'academy', 'mentor', 'trainer'];
//   String? _selectedRole;
//   Image? _captchaImage;
//   // ignore: unused_field
//   bool _refresh = false;
//   String _error = '';

//   List<Map<String, String>> _roleOptions = [
//     {'key': 'student', 'text': 'Student', 'value': 'student'},
//     {'key': 'trainer', 'text': 'Trainer', 'value': 'trainer'},
//     {'key': 'mentor', 'text': 'Mentor', 'value': 'mentor'},
//     {'key': 'academy', 'text': 'Academy', 'value': 'academy'},
//   ];

//   void _handleRefresh() {
//     setState(() {
//       _refresh = true;
//     });
//     Timer(const Duration(milliseconds: 100), () {
//       setState(() {
//         _refresh = false;
//       });
//     });
//   }

//   void _handleDropdownChange(String? value) {
//     setState(() {
//       _selectedRole = value;
//     });
//   }

//   void _handleFormSubmission() async {
//     String username = _nameController.text.trim();
//     String phone = _phoneController.text.trim();
//     String password = _passwordController.text.trim();
//     String captcha = _captchaController.text.trim();

//     if (_selectedRole == null) {
//       setState(() {
//         _error = 'Please select a role.';
//       });
//       return;
//     }

//     if (username.isEmpty || phone.isEmpty || password.isEmpty || captcha.isEmpty) {
//       setState(() {
//         _error = username.isEmpty ? 'Please enter your email.'
//                  : phone.isEmpty ? 'Please enter your phone number.'
//                  : password.isEmpty ? 'Please enter your password.'
//                  : 'Please enter the captcha.';
//       });
//       return;
//     }

//     setState(() {
//       _error = '';
//     });

//     bool isValidEmail(String email) {
//       RegExp emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
//       return emailRegex.hasMatch(email);
//     }

//     if (!isValidEmail(username)) {
//       setState(() {
//         _error = 'Please enter a valid email address.';
//       });
//       return;
//     }

//     if (password.length < 6) {
//       setState(() {
//         _error = 'Password must be at least 6 characters long.';
//       });
//       return;
//     }

//     bool isValidPhoneNumber(String input) {
//       return RegExp(r'^[0-9]{10}$').hasMatch(input);
//     }

//     if (!isValidPhoneNumber(phone)) {
//       setState(() {
//         _error = 'Please enter a valid 10-digit phone number.';
//       });
//       return;
//     }

//     final response = await APIService.registerUser(
//         username, password, phone, captcha, _selectedRole);

//     if (response?['status'] == 200) {
//       print(response?['status']);
//       // Navigate to the login screen after successful signup
//       Navigator.of(context).pushReplacementNamed(Login.id);
//     } else if (response?['status'] == 401) {
//       _setError('Captcha validation failed. Please try again.');
//       print(response?['status']);
//       _captchaController.text = '';
//       _handleRefresh();
//     } else if (response?['status'] == 409) {
//       _setError('User already exists. Please sign in.');
//       print(response?['status']);
//     }
//   }

//   void _setError(String error) {
//     setState(() {
//       _error = error;
//     });
//   }

//   @override
//   void initState() {
//     displayCaptcha();
//     super.initState();
//   }

//   Future<void> displayCaptcha() async {
//     final captchaImageData = await APIService.fetchCaptchaImageData();

//     if (captchaImageData != null &&
//         captchaImageData.containsKey('imageBase64')) {
//       setState(() {
//         final base64String = captchaImageData['imageBase64'];
//         final List<int> bytes = base64Decode(base64String);
//         _captchaImage = Image.memory(Uint8List.fromList(bytes));
//       });
//     }
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
//               vertical: size.height * 0.05,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/logo.png',
//                   height: size.height * 0.1,
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 Text(
//                   "Sign Up",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 if (_error.isNotEmpty)
//                   Text(
//                     _error,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(
//                     labelText: 'Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly,
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 DropdownButtonFormField<String>(
//                   value: _selectedRole,
//                   hint: Text('Select Role'),
//                   onChanged: _handleDropdownChange,
//                   items: _roleOptions.map((role) {
//                     return DropdownMenuItem<String>(
//                       value: role['value']!,
//                       child: Text(role['text']!),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 _captchaImage != null ? _captchaImage! : Container(),
//                 SizedBox(height: size.height * 0.02),
//                 TextField(
//                   controller: _captchaController,
//                   decoration: InputDecoration(
//                     hintText: 'Captcha',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 ElevatedButton(
//                   onPressed: _handleFormSubmission,
//                   child: Text("Sign Up", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ------------------------------------------------------------
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:demo/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo/screens/login_screen.dart';

class Signup extends StatefulWidget {
  static const String id = "/signup";

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

  List<String> roles = ['student', 'academy', 'mentor', 'trainer'];
  String? selectedRole;
  Image? _captchaImage;
  // ignore: unused_field
  bool _refresh = false;
  String error = '';

  void handleRefresh() {
    setState(() {
      _refresh = true;
    });
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _refresh = false;
      });
    });
  }

  void handleDropdownChange(String? value) {
    setState(() {
      selectedRole = value;
    });
  }

  void refreshCaptcha() {
    setState(() {
      displayCaptcha();
    });
  }

  late String expectedCaptcha = '';

  Future<void> registerUser() async {
    if (selectedRole == null ||
        usernameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        captchaController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields.');
      return;
    }

    setState(() {
      error = '';
    });

    bool isValidEmail(String email) {
      RegExp emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      return emailRegex.hasMatch(email);
    }

    if (!isValidEmail(usernameController.text)) {
      _showErrorDialog('Please enter a valid email address.');
      return;
    }

    if (passwordController.text.length < 6) {
      _showErrorDialog('Password must be at least 6 characters long.');
      return;
    }

    bool isValidPhoneNumber(String input) {
      return RegExp(r'^[0-9]{10}$').hasMatch(input);
    }

    if (!isValidPhoneNumber(phoneController.text)) {
      _showErrorDialog('Please enter a valid 10-digit phone number.');
      return;
    }

    if (selectedRole == null) {
      _showErrorDialog('Please select a role');
      return;
    }

    try {
      final response = await APIService.registerUser(
        usernameController.text,
        passwordController.text,
        phoneController.text,
        captchaController.text,
        selectedRole!,
      );

      if (response != null) {
        final status = response['status'];
        if (status == 200) {
          print('Registration successful');
          Navigator.of(context).pushReplacementNamed(Login.id);
        } else if (status == 401) {
          _showErrorDialog('Incorrect captcha. Please try again.');
          _clearCaptchaField();
          refreshCaptcha();
        } else if (status == 409) {
          setError('User already exists. Please sign in.');
        } else {
          setError('An unexpected error occurred. Please try again later.');
        }
      } else {
        setError('No response from server. Please try again.');
      }
    } catch (e) {
      setError('An error occurred: $e');
    }
  }

  void _clearCaptchaField() {
    captchaController.clear();
  }

  void setError(String errorMsg) {
    setState(() {
      error = errorMsg;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    displayCaptcha();
    super.initState();
  }

  Future<void> displayCaptcha() async {
    final captchaImageData = await APIService.fetchCaptchaImageData();

    if (captchaImageData != null &&
        captchaImageData.containsKey('imageBase64')) {
      setState(() {
        final base64String = captchaImageData['imageBase64'];
        final List<int> bytes = base64Decode(base64String);
        _captchaImage = Image.memory(Uint8List.fromList(bytes));
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
              vertical: size.height * 0.001,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.1,
                  ),
                ),
                SizedBox(height: size.height * 0.023),
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: size.height * 0.018),
                Text(
                  "Create a new account",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: size.height * 0.020),
                TextField(
                  controller: usernameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: size.height * 0.016),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: size.height * 0.016),
                TextField(
                  controller: phoneController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone",
                  ),
                ),
                SizedBox(height: size.height * 0.020),
                Row(
                  children: [
                    _captchaImage != null ? _captchaImage! : Container(),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: refreshCaptcha,
                    ),
                  ],
                ),
                TextField(
                  controller: captchaController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Captcha",
                  ),
                ),
                Container(
                  height: size.height * 0.06,
                  child: SingleChildScrollView(
                    child: DropdownButton<String>(
                      value: selectedRole,
                      onChanged: handleDropdownChange,
                      items: roles.map((String role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                ElevatedButton(
                  onPressed: registerUser,
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

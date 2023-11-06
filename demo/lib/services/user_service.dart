// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class APIService {
//   static Future<Map<String, dynamic>?> registerUser(
//       String email, String username, String password) async {
//     final String apiUrl = 'http://localhost:5000/student/signup'; // Replace with your API URL

//     final Map<String, dynamic> data = {
//       'email': email,
//       'username': username,
//       'password': password,
//       'roles': 'student',
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: json.encode(data),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final userData = jsonDecode(response.body);
//         return userData;
//       } else {
//         print('Failed to register user. Status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }
// }

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class APIService {
//   static Future<Map<String, dynamic>?> registerUser(
//       String email, String username, String password) async {
//     final String registerUrl = 'http://10.0.2.2:5000/student/signup'; // Replace with your register API URL

//     final Map<String, dynamic> registerData = {
//       'email': email,
//       'username': username,
//       'password': password,
//       'roles': 'student',
//     };

//     try {
//       final registerResponse = await http.post(
//         Uri.parse(registerUrl),
//         body: json.encode(registerData),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (registerResponse.statusCode == 200) {
//         final userData = jsonDecode(registerResponse.body);
//         return userData;
//       } else {
//         print('Failed to register user. Status code: ${registerResponse.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> loginUser(
//       String email, String password) async {
//     final String loginUrl = 'http://10.0.2.2:5000/student/login'; // Replace with your login API URL

//     final Map<String, dynamic> loginData = {
//       'email': email,
//       'password': password,
//     };

//     try {
//       final loginResponse = await http.post(
//         Uri.parse(loginUrl),
//         body: json.encode(loginData),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (loginResponse.statusCode == 200) {
//         final userData = jsonDecode(loginResponse.body);
//         return userData;
//       } else {
//         print('Failed to log in. Status code: ${loginResponse.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }
// }

// ----------------------------------------------------------------------
// test api

// user_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static var selectedRole;

  static Future<Map<String, dynamic>?> registerUser(String email,
      String username, String password, String? selectedRole) async {
    final String registerUrl = 'http://localhost:5000/$selectedRole/signup';

    if (selectedRole == null || selectedRole.isEmpty) {
      print('No role selected');
      return null;
    }

    final Map<String, dynamic> registerData = {
      'email': email,
      'username': username,
      'password': password,
      'roles': selectedRole,
    };

    try {
      final registerResponse = await http.post(
        Uri.parse(registerUrl),
        body: json.encode(registerData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (registerResponse.statusCode == 200) {
        return jsonDecode(registerResponse.body);
      } else {
        print(
            'Failed to register user. Status code: ${registerResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> loginUser(
      String username, String password, String selectedRole) async {
    final String loginUrl = 'http://localhost:5000/$selectedRole/login';

    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    try {
      final loginResponse = await http.post(
        Uri.parse(loginUrl),
        body: json.encode(loginData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (loginResponse.statusCode == 200) {
        return jsonDecode(loginResponse.body);
      } else {
        print('Failed to log in. Status code: ${loginResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

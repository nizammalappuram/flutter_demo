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
// import 'package:dio/dio.dart';

// class APIService {
//   static var selectedRole;

//   static Future<Map<String, dynamic>?> registerUser(String email,
//       String username, String password, String? selectedRole) async {
//     final String registerUrl = 'http://localhost:5000/$selectedRole/signup';

//     if (selectedRole == null || selectedRole.isEmpty) {
//       print('No role selected');
//       return null;
//     }

//     final Map<String, dynamic> registerData = {
//       'email': email,
//       'username': username,
//       'password': password,
//       'roles': selectedRole,
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
//         return jsonDecode(registerResponse.body);
//       } else {
//         print(
//             'Failed to register user. Status code: ${registerResponse.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }

//   static Dio dio = Dio();
//   static const String baseUrl = 'http://localhost:5000'; // Replace with your actual API base URL

//   static Future<Map<String, dynamic>?> loginUser(String username, String password, String selectedRole) async {
//     final String loginUrl = '$baseUrl/$selectedRole/login';

//     try {
//       Response response = await dio.post(
//         loginUrl,
//         data: {
//           'username': username,
//           'password': password,
//         },
//         options: Options(
//           contentType: Headers.jsonContentType,
//           receiveDataWhenStatusError: true,
//         ),
//       );

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         print('Failed to log in. Status code: ${response.statusCode}');
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

//---------------------------------------------------------------------------------

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class APIService {
//   static const String baseUrl =
//       'http://localhost:5000'; // Replace with your actual API base URL

//   static Future<Map<String, dynamic>?> registerUser(
//       String username,
//       String password,
//       String phone,
//       String? captcha,
//       String? selectedRole) async {
//     final String signupUrl = '$baseUrl/$selectedRole/signup';

//     if (selectedRole == null || selectedRole.isEmpty) {
//       print('No role selected');
//       return null;
//     }

//     final Map<String, dynamic> requestData = {
//       'username': username,
//       'password': password,
//       'phone': phone,
//       'captcha': captcha,
//       'roles': selectedRole,
//     };

//     try {
//       final signupResponse = await http.post(
//         Uri.parse(signupUrl),
//         body: json.encode(requestData),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (signupResponse.statusCode == 200) {
//         return json.decode(signupResponse.body);
//       } else {
//         print('Failed to signup. Status code: ${signupResponse.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> loginUser(
//       String username, String password, String selectedRole) async {
//     final String loginUrl = '$baseUrl/$selectedRole/login';

//     try {
//       final response = await http.post(
//         Uri.parse(loginUrl),
//         body: json.encode({
//           'username': username,
//           'password': password,
//         }),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         print('Failed to log in. Status code: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> fetchCaptchaImageData() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/captcha'));

//       if (response.statusCode == 200) {
//         final imageData = response.bodyBytes;
//         final base64String = base64Encode(imageData);
//         return {'imageBase64': base64String};
//       } else {
//         print('Failed to load captcha image');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching captcha image: $e');
//       return null;
//     }
//   }
// }

//---------------------------------------------------------------------------------

import 'dart:convert';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  static const String baseUrl = 'http://localhost:5000';

  static Dio dio = Dio();
  static CookieJar cookieJar = CookieJar();

  static void setupCookieJar() {
    dio.interceptors.add(CookieManager(cookieJar));
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<Map<String, dynamic>?> registerUser(
      String username,
      String password,
      String phone,
      String? captcha,
      String? selectedRole) async {
    final String signupUrl = '$baseUrl/$selectedRole/signup';

    if (selectedRole == null || selectedRole.isEmpty) {
      print('No role selected');
      return null;
    }

    final Map<String, dynamic> requestData = {
      'username': username,
      'password': password,
      'phone': phone,
      'captcha': captcha,
      'roles': selectedRole,
    };

    try {
      final signupResponse = await http.post(
        Uri.parse(signupUrl),
        body: json.encode(requestData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (signupResponse.statusCode == 200) {
        return json.decode(signupResponse.body);
      } else {
        print('Failed to signup. Status code: ${signupResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> loginUser(
    String username,
    String password,
    String selectedRole,
  ) async {
    final String loginUrl = '$baseUrl/$selectedRole/login';

    try {
      Response response = await dio.post(
        loginUrl,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
          receiveDataWhenStatusError: true,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        print('Unauthorized. Check your credentials.');
      } else {
        print('Failed to log in. Status code: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}, ${e.response?.data}');
      } else {
        print('DioError: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }

  static Future<Map<String, dynamic>?> fetchCaptchaImageData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/captcha'));

      if (response.statusCode == 200) {
        final imageData = response.bodyBytes;
        final base64String = base64Encode(imageData);
        return {'imageBase64': base64String};
      } else {
        print('Failed to load captcha image');
        return null;
      }
    } catch (e) {
      print('Error fetching captcha image: $e');
      return null;
    }
  }
}

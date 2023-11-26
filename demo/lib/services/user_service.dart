import 'dart:convert';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/app_config.dart';

class APIService {
  static late final String baseUrl;
  static Dio dio = Dio();
  static CookieJar cookieJar = CookieJar();

  APIService(AppConfig config) {
    baseUrl = config.apiUrl;
  }

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

  static Future<Map<String, dynamic>?> submitStudentDetails({
    required String fname,
    required String lname,
    required String city,
    required String country,
    required String? selectedAcademy,
  }) async {
    final String studentDetailsUrl = '$baseUrl/student/details/post'; // Replace with your student details endpoint

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      print('No token found. Please log in.');
      return null;
    }

    final existingToken = token;
    final apiUrl = Uri.parse(studentDetailsUrl);

    final tokenValue = existingToken.toString();
    final jwtToken = tokenValue.split('=')[0];

    try {
      final response = await http.post(
        apiUrl,
        body: json.encode({
          'fname': fname,
          'lname': lname,
          'city': city,
          'country': country,
          'selectedAcademy': selectedAcademy,
          'formname': 'student_form', // Include formname
        }),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': jwtToken, // Set your token here
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to submit student details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
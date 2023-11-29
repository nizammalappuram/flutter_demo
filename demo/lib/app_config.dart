import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;

  AppConfig({required this.apiUrl});

  static Future<AppConfig> forEnvironment(String env) async {
    final contents = await rootBundle.loadString('assets/config/$env.json');
    final json = jsonDecode(contents);
    final apiUrl = json['apiUrl'] != null ? json['apiUrl'] : 'default_api_url';

    return AppConfig(apiUrl: apiUrl);
  }
}
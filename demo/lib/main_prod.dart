import 'package:demo/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:demo/app_config.dart';
// import 'package:demo/logging/logging_setup.dart'; // Import the logging setup file
// import 'package:path_provider/path_provider.dart';

import 'package:demo/main.dart'; // Import the common main file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setupLogging();

  final env = 'prod'; // Set the desired environment here
  final config = await AppConfig.forEnvironment(env.isNotEmpty ? env : 'prod');
  final apiService = APIService(config);

  runApp(MyApp(config: config, apiService: apiService));
}
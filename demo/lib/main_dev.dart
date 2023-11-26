import 'package:flutter/material.dart';
import 'package:demo/app_config.dart';

import 'package:demo/main.dart'; // Import the common main file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final env = 'dev'; // Set the desired environment here
  final config = await AppConfig.forEnvironment(env.isNotEmpty ? env : 'dev');

  runApp(MyApp(config: config));
}
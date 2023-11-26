import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demo/main.dart';
import 'package:demo/app_config.dart';
import 'package:demo/services/user_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a configuration instance
    final AppConfig config = AppConfig(apiUrl: 'dev'); // Replace with your actual AppConfig

    // Create an instance of APIService
    final APIService apiService = APIService(config);

    // Build our app and trigger a frame, passing the config and apiService
    await tester.pumpWidget(MyApp(config: config, apiService: apiService,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

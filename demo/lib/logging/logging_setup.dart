import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

Logger logger = Logger('MyApp');

Future<void> setupLogging() async {
  logger.level = Level.ALL;

  logger.onRecord.listen((LogRecord record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
    writeLogToFile('${record.level.name}: ${record.time}: ${record.message}');
  });
}

Future<void> writeLogToFile(String log) async {
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/app_logs.txt');

    final DateTime now = DateTime.now();
    final String timestamp = '${now.toUtc().toIso8601String()}';

    await file.writeAsString('[$timestamp] $log\n', mode: FileMode.append);
  } catch (e) {
    print('Error writing to log file: $e');
  }
}

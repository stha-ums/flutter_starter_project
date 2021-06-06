import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

initLogging() {
  Queue<String> logs = Queue();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final String log =
        '${record.level.name}: ${record.time}: ${record.message}';

    logs.addLast(log);

    if (logs.length > 100) {
      logs.removeFirst();
    }

    if (kDebugMode)
      printWrapped(
          '[${record.level.name}][${record.time}][${record.loggerName}] => [${record.message}]');
  });
}

/// this function is used to print long logs, print and debug print has word limit
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

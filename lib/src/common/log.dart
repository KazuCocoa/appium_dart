import 'package:webdriver/src/common/log.dart'; // ignore: implementation_imports

class AppiumLogEntry extends LogEntry {
  AppiumLogEntry(String? message, DateTime timestamp, String? level)
      : super(message, timestamp, level);

  AppiumLogEntry.fromMap(Map<String, dynamic> map)
      : this(
            map['message'],
            DateTime.fromMillisecondsSinceEpoch(map['timestamp'].toInt(),
                isUtc: true),
            map['level']);
}

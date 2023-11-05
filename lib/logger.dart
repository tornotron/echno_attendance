import 'package:logger/logger.dart';

final logger = (Type type, Level level) => Logger(
      printer: CustomPrinter(type.toString()),
      level: level,
    );

class CustomPrinter extends LogPrinter {
  final String className;

  CustomPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;

    return [color!('$emoji $className: $message')];
  }
}

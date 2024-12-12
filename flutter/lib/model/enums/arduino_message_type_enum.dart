import 'dart:ui';

class ArduinoMessage {
  late String type;

  ArduinoMessage(String message) {
    var splited = message.split(' ');
    type = splited[0];
  }

  factory ArduinoMessage.fromMessage(String message) {
    var splited = message.split(' ');
    // typeがCLRの場合はArduinoColorMessageを返す
    if (splited[0] == ArduinoMessageType.color) {
      return ArduinoColorMessage(message);
    }
    return ArduinoMessage(message);
  }
}

class ArduinoColorMessage extends ArduinoMessage {
  late Color color;

  ArduinoColorMessage(String message) : super(message) {
    var splited = message.split(' ');
    color = Color(int.parse(splited[1], radix: 16));
    type = splited[0];
  }

  String get colorString {
    return color.value.toRadixString(16);
  }
}

class ArduinoMessageType {
  static const String color = 'CLR';
  static const String ok = 'OK.';
  static const String invalid = 'INV';
  static const String waitAMoment = 'WAM';
}

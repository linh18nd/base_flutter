import 'package:flutter/foundation.dart';

class _LogColors {
  static const String reset = '\x1B[0m';
  static const String blue = '\x1B[34m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String red = '\x1B[31m';
}

class Logger {
  static void d(String message, [String? tag]) {
    if (kDebugMode) {
      print(
        '${_LogColors.blue}[${tag ?? 'DEBUG'}]${_LogColors.reset} $message',
      );
    }
  }

  static void e(String message, [String? tag, dynamic error]) { 
    if (kDebugMode) {
      print('${_LogColors.red}[${tag ?? 'ERROR'}]${_LogColors.reset} $message');
      if (error != null) {
        print('${_LogColors.red}Error:${_LogColors.reset} $error');
      }
    }
  }

  static void i(String message, [String? tag]) {
    if (kDebugMode) {
      print(
        '${_LogColors.green}[${tag ?? 'INFO'}]${_LogColors.reset} $message',
      );
    }
  }

  static void w(String message, [String? tag]) {
    if (kDebugMode) {
      print(
        '${_LogColors.yellow}[${tag ?? 'WARNING'}]${_LogColors.reset} $message',
      );
    }
  }
}

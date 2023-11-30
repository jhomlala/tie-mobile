import 'dart:developer';

import 'package:domain/domain.dart';

class Log {
  static bool logEnabled = true;

  // ignore: use_setters_to_change_properties
  static void configure(Flavor flavor) {
    logEnabled = flavor != Flavor.prod;
  }

  static void info(String message) {
    if (logEnabled) {
      log('[INFO][${DateTime.now()}] $message', level: 800);
    }
  }

  static void warn(String message) {
    if (logEnabled) {
      log('[WARN][${DateTime.now()}] $message', level: 900);
    }
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (logEnabled) {
      log(
        '[ERROR][${DateTime.now()}] $message',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

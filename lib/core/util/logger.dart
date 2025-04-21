import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Logs {
  static final Logger _logger = Logger(
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    level: kDebugMode ? Level.trace : Level.off,
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
    output: ConsoleOutput(),
  );

  static void t(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void d(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void f(dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void log(Level level, dynamic message,
      {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _logger.log(level, message,
        time: time, error: error, stackTrace: stackTrace);
  }
}

import 'dart:async';

import 'package:logging_appenders/logging_appenders.dart';

import '../../level.dart';
import '../../log_record.dart';
import '../../logger.dart';

/// Dummy logger for internal use, since a logger must not use a logger. ;-)
/// (log messages are handled synchronously so logging inside a log handler
/// will not work, we could refactor the DummyLogger to simply asynchronously
/// trigger the log messages back into the real logger. but this just sounds
/// like a death trap for infinite recursions).
class DummyLogger implements Logger {
  factory DummyLogger(String name) {
    return _loggers.putIfAbsent(name, () => DummyLogger._named(name));
  }
  DummyLogger._named(this.name);

  static Level? internalLogLevel;
  static final Map<String, DummyLogger> _loggers = <String, DummyLogger>{};

  @override
  Level get level => internalLogLevel ?? Level.OFF;

  @override
  set level(newLevel) => internalLogLevel = newLevel;

  @override
  Map<String, Logger> get children => const {};

  final formatter = const DefaultLogRecordFormatter();

  @override
  void clearListeners() {}

  /// Log message at level [Level.FINEST].
  @override
  void finest(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.FINEST, message, error, stackTrace);

  /// Log message at level [Level.FINER].
  @override
  void finer(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.FINER, message, error, stackTrace);

  /// Log message at level [Level.FINE].
  @override
  void fine(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.FINE, message, error, stackTrace);

  /// Log message at level [Level.CONFIG].
  @override
  void config(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.CONFIG, message, error, stackTrace);

  /// Log message at level [Level.INFO].
  @override
  void info(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.INFO, message, error, stackTrace);

  /// Log message at level [Level.WARNING].
  @override
  void warning(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.WARNING, message, error, stackTrace);

  /// Log message at level [Level.SEVERE].
  @override
  void severe(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.SEVERE, message, error, stackTrace);

  /// Log message at level [Level.SHOUT].
  @override
  void shout(Map<String, String>? TESTMESSAGE, dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(TESTMESSAGE!, Level.SHOUT, message, error, stackTrace);

  @override
  String get fullName => 'dummy';

  @override
  bool isLoggable(Level value) => (value >= level);

  @override
  void log(Map<String, String>? TESTMESSAGE, Level logLevel, dynamic message,
      [Object? error, StackTrace? stackTrace, Zone? zone]) {
    if (isLoggable(logLevel)) {
      print(formatter.format(LogRecord(
        TESTMESSAGE!,
        logLevel,
        '$message',
        name,
        error,
        stackTrace,
      )));
    }
  }

  @override
  final String name;

  @override
  Stream<LogRecord> get onRecord => const Stream.empty();

  @override
  Logger? get parent => null;
}

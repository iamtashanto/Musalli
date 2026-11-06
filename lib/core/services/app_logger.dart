import 'dart:collection';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Severity levels for [AppLogger].
enum LogLevel {
  /// Verbose debug trace.
  debug,

  /// Informational operational event.
  info,

  /// Recoverable warning or degraded performance notice.
  warning,

  /// Unhandled or caught error with optional stack trace.
  error,
}

/// Immutable log entry stored in the in-memory ring buffer for diagnostics.
@immutable
class LogEntry {
  /// Creates a [LogEntry].
  const LogEntry({
    required this.timestamp,
    required this.level,
    required this.tag,
    required this.message,
    this.error,
    this.stackTrace,
  });

  /// Timestamp when the log was recorded.
  final DateTime timestamp;

  /// Severity level.
  final LogLevel level;

  /// Subsystem or feature tag.
  final String tag;

  /// Human-readable log message.
  final String message;

  /// Associated error object, if any.
  final Object? error;

  /// Associated stack trace, if any.
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '[${timestamp.toIso8601String()}] [${level.name.toUpperCase()}] [$tag] $message'
      '${error != null ? ' | Error: $error' : ''}';
}

/// Privacy-first local logging wrapper.
///
/// Never transmits logs or user data over the network. Keeps a bounded
/// in-memory ring buffer of recent logs for local debugging.
class AppLogger {
  AppLogger._();

  static const int _maxBufferEntries = 150;
  static final ListQueue<LogEntry> _recentLogs = ListQueue<LogEntry>();

  /// Returns an unmodifiable view of recent log entries.
  static List<LogEntry> get recentLogs =>
      List<LogEntry>.unmodifiable(_recentLogs);

  /// Clears the in-memory log buffer.
  static void clear() => _recentLogs.clear();

  /// Logs a debug message.
  static void debug(String message, {String tag = 'Musalli'}) =>
      _record(LogLevel.debug, message, tag: tag);

  /// Logs an informational message.
  static void info(String message, {String tag = 'Musalli'}) =>
      _record(LogLevel.info, message, tag: tag);

  /// Logs a warning message.
  static void warning(
    String message, {
    String tag = 'Musalli',
    Object? error,
    StackTrace? stackTrace,
  }) => _record(
    LogLevel.warning,
    message,
    tag: tag,
    error: error,
    stackTrace: stackTrace,
  );

  /// Logs an error with optional [error] and [stackTrace].
  static void error(
    String message, {
    String tag = 'Musalli',
    Object? error,
    StackTrace? stackTrace,
  }) => _record(
    LogLevel.error,
    message,
    tag: tag,
    error: error,
    stackTrace: stackTrace,
  );

  static void _record(
    LogLevel level,
    String message, {
    required String tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      tag: tag,
      message: message,
      error: error,
      stackTrace: stackTrace,
    );

    if (_recentLogs.length >= _maxBufferEntries) {
      _recentLogs.removeFirst();
    }
    _recentLogs.addLast(entry);

    if (kDebugMode) {
      developer.log(
        message,
        time: entry.timestamp,
        name: tag,
        level: switch (level) {
          LogLevel.debug => 500,
          LogLevel.info => 800,
          LogLevel.warning => 900,
          LogLevel.error => 1000,
        },
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

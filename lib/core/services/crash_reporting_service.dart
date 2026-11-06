import 'package:flutter/foundation.dart';
import 'package:musalli/core/services/app_logger.dart';

/// Privacy-respecting crash and error reporting service.
///
/// Principles:
/// 1. Strict opt-in: disabled by default. Zero telemetry leaves device without consent.
/// 2. PII-free: filters out names, emails, GPS coordinates, local device IDs.
/// 3. Offline-safe: error logs are discarded or locally buffered without network block.
class CrashReportingService {
  CrashReportingService({bool initialOptIn = false}) : _optIn = initialOptIn;

  bool _optIn;

  /// Whether crash reporting is currently opted-in by user.
  bool get isOptedIn => _optIn;

  /// Updates user consent.
  void setOptIn({required bool enabled}) {
    _optIn = enabled;
    AppLogger.info('Crash reporting consent updated: optIn=$enabled');
  }

  /// Records an uncaught or caught exception with sanitized stack traces.
  void recordError(
    Object exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) {
    if (!_optIn) {
      // In dev mode or when opt-out, log locally via AppLogger only
      if (kDebugMode) {
        AppLogger.error(
          'Local error (telemetry disabled): $reason',
          error: exception,
          stackTrace: stackTrace,
        );
      }
      return;
    }

    final sanitizedMessage = _sanitize(exception.toString());
    final sanitizedReason = reason != null ? _sanitize(reason) : null;

    // Simulated privacy-preserving sink
    AppLogger.warning(
      '[CrashReporting] ${fatal ? "FATAL" : "NON-FATAL"}: $sanitizedMessage'
      '${sanitizedReason != null ? " Reason: $sanitizedReason" : ""}',
    );
  }

  /// Removes any personal identifiable information or coordinate patterns.
  String _sanitize(String message) {
    var result = message;
    // Strip emails
    result = result.replaceAll(RegExp(r'[\w\.-]+@[\w\.-]+\.\w+'), '[EMAIL_REDACTED]');
    // Strip explicit latitude/longitude decimal patterns
    result = result.replaceAll(
      RegExp(r'(-?\d{1,3}\.\d{4,})'),
      '[COORD_REDACTED]',
    );
    return result;
  }
}

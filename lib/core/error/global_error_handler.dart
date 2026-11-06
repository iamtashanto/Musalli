import 'package:flutter/material.dart';
import 'package:musalli/core/services/app_logger.dart';

/// Friendly Bangla & English fallback screen displayed when an unexpected
/// widget build error occurs.
class BanglaErrorScreen extends StatelessWidget {
  /// Creates a [BanglaErrorScreen].
  const BanglaErrorScreen({this.errorDetails, this.onRetry, super.key});

  /// Optional Flutter error details captured by [ErrorWidget.builder].
  final FlutterErrorDetails? errorDetails;

  /// Optional callback invoked when the user taps the retry button.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF042F2E),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF064E3B).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B)
                              .withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_moon_outlined,
                          size: 34,
                          color: Color(0xFFFBBF24),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'দুঃখিত, একটি অপ্রত্যাশিত ত্রুটি ঘটেছে',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HindSiliguri',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'চিন্তার কারণ নেই — আপনার সংরক্ষিত নামাজ ট্র্যাকার, বুকমার্ক ও মুখস্থ সূরার সব তথ্য নিরাপদ আছে।',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'HindSiliguri',
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFFD1FAE5),
                        ),
                      ),
                      if (onRetry != null) ...<Widget>[
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: onRetry,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: const Text(
                            'আবার চেষ্টা করুন',
                            style: TextStyle(
                              fontFamily: 'HindSiliguri',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Registers global [FlutterError.onError], platform dispatcher error,
/// and [ErrorWidget.builder] handlers.
class GlobalErrorHandler {
  const GlobalErrorHandler._();

  /// Installs the global error handlers.
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.error(
        'Flutter framework error: ${details.exceptionAsString()}',
        tag: 'FlutterError',
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    WidgetsBinding.instance.platformDispatcher.onError =
        (Object error, StackTrace stack) {
          AppLogger.error(
            'Uncaught platform error: $error',
            tag: 'PlatformDispatcher',
            error: error,
            stackTrace: stack,
          );
          return true;
        };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return BanglaErrorScreen(errorDetails: details);
    };
  }
}

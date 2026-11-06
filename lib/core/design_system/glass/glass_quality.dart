import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:musalli/core/services/app_logger.dart';

/// Rendering quality tiers for frosted glass surfaces (`GlassSurface`).
///
/// Automatically adapts at startup based on device RAM, Android SDK version,
/// and early frame timings, while allowing manual user override in settings.
enum GlassQuality {
  /// Full `BackdropFilter` blur (sigma 24), specular border, and soft shadow.
  high,

  /// Moderate `BackdropFilter` blur (sigma 12) for mid-range devices.
  medium,

  /// Zero `BackdropFilter` blur — uses a solid translucent surface with a
  /// crisp 1px border for 60fps scrolling on low-end 2–3 GB RAM Android phones.
  low;

  /// Blur sigma corresponding to this quality tier.
  double get defaultBlurSigma => switch (this) {
    GlassQuality.high => 24,
    GlassQuality.medium => 12,
    GlassQuality.low => 0,
  };

  /// Returns `true` if `BackdropFilter` should be skipped completely.
  bool get isBlurDisabled => this == GlassQuality.low;
}

/// Hardware and frame-rate detector that determines the optimal default
/// [GlassQuality] tier on device startup.
class GlassQualityDetector {
  const GlassQualityDetector._();

  /// Inspects Android SDK level and device hardware via [DeviceInfoPlugin]
  /// to pick a safe initial [GlassQuality].
  static Future<GlassQuality> detectHardwareTier({
    DeviceInfoPlugin? plugin,
  }) async {
    if (kIsWeb) {
      return GlassQuality.medium;
    }

    try {
      final deviceInfo = plugin ?? DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        final sdkInt = android.version.sdkInt;
        final isLowRamDevice = android.isLowRamDevice;

        if (isLowRamDevice || sdkInt <= 26) {
          AppLogger.info(
            'Detected low-RAM or older Android (SDK $sdkInt, lowRam=$isLowRamDevice) -> GlassQuality.low',
            tag: 'GlassQuality',
          );
          return GlassQuality.low;
        }
        if (sdkInt <= 29) {
          return GlassQuality.medium;
        }
        return GlassQuality.high;
      }

      if (Platform.isIOS || Platform.isMacOS) {
        return GlassQuality.high;
      }
    } on Object catch (e) {
      AppLogger.warning(
        'Device info detection fallback to medium: $e',
        tag: 'GlassQuality',
      );
    }

    return GlassQuality.high;
  }

  /// Evaluates a list of [FrameTiming] samples from the first seconds of app
  /// startup and downgrades [current] if average raster/total time exceeds
  /// 18ms (below ~55fps).
  static GlassQuality evaluateFrameTimings(
    List<FrameTiming> timings, {
    required GlassQuality current,
  }) {
    if (timings.length < 10 || current == GlassQuality.low) {
      return current;
    }

    var totalMicros = 0;
    for (final timing in timings) {
      totalMicros += timing.totalSpan.inMicroseconds;
    }
    final avgMillis = (totalMicros / timings.length) / 1000.0;

    if (avgMillis > 24.0) {
      return GlassQuality.low;
    }
    if (avgMillis > 18.0 && current == GlassQuality.high) {
      return GlassQuality.medium;
    }
    return current;
  }
}

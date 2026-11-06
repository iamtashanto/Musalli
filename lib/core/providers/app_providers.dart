import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

/// Provides the active [FlavorConfig] (overridden in `main_dev.dart` and
/// `main_prod.dart`).
@Riverpod(keepAlive: true)
FlavorConfig flavorConfig(Ref ref) {
  return FlavorConfig.dev();
}

/// Provides the singleton local SQLite [AppDatabase].
///
/// Can be overridden in tests with an in-memory `NativeDatabase.memory()`.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

/// Manages the active UI [Locale] (`bn` default, `en` supported) and persists
/// changes to the local settings table.
@Riverpod(keepAlive: true)
class AppLocaleNotifier extends _$AppLocaleNotifier {
  static const String _settingKey = 'app_locale';

  @override
  Locale build() {
    return const Locale('bn');
  }

  /// Switches the active [Locale] and persists it asynchronously.
  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;
    state = locale;
    try {
      await ref
          .read(appDatabaseProvider)
          .setSetting(_settingKey, locale.languageCode);
    } on Object {
      // Ignore DB write errors in stateless widget tests
    }
  }

  /// Toggles between Bangla (`bn`) and English (`en`).
  Future<void> toggleLocale() async {
    final next = state.languageCode == 'bn'
        ? const Locale('en')
        : const Locale('bn');
    await setLocale(next);
  }
}

/// Manages the active [ThemeMode] (`system`, `light`, `dark`).
@Riverpod(keepAlive: true)
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  static const String _settingKey = 'app_theme_mode';

  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  /// Updates the active [ThemeMode] and persists it.
  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    try {
      await ref.read(appDatabaseProvider).setSetting(_settingKey, mode.name);
    } on Object {
      // Ignore DB write errors in stateless widget tests
    }
  }

  /// Toggles between light and dark themes.
  Future<void> toggleLightDark() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(next);
  }
}

/// Manages the active [GlassQuality] tier with hardware auto-detection,
/// startup frame-timing guard, and manual override persistence.
@Riverpod(keepAlive: true)
class GlassQualityNotifier extends _$GlassQualityNotifier {
  static const String _settingKey = 'glass_quality_override';
  bool _hasManualOverride = false;

  @override
  GlassQuality build() {
    return GlassQuality.high;
  }

  /// Initializes auto-detection at startup unless the user has saved a manual
  /// override in settings.
  Future<void> initializeAutoDetection() async {
    try {
      final saved = await ref.read(appDatabaseProvider).getSetting(_settingKey);
      if (saved != null) {
        final match = GlassQuality.values
            .where((q) => q.name == saved)
            .firstOrNull;
        if (match != null) {
          _hasManualOverride = true;
          state = match;
          return;
        }
      }
    } on Object {
      // Proceed with hardware detection if DB is unavailable
    }

    final detected = await GlassQualityDetector.detectHardwareTier();
    if (!_hasManualOverride) {
      state = detected;
    }
  }

  /// Applies frame-timing samples collected during startup and downgrades
  /// blur quality if frame times indicate jank.
  void reportStartupFrameTimings(List<FrameTiming> timings) {
    if (_hasManualOverride) return;
    final adjusted = GlassQualityDetector.evaluateFrameTimings(
      timings,
      current: state,
    );
    if (adjusted != state) {
      state = adjusted;
    }
  }

  /// Manually overrides the [GlassQuality] tier and persists the choice.
  Future<void> setQuality(GlassQuality quality) async {
    _hasManualOverride = true;
    state = quality;
    try {
      await ref.read(appDatabaseProvider).setSetting(_settingKey, quality.name);
    } on Object {
      // Ignore DB write errors in widget tests
    }
  }
}

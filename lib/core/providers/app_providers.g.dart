// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the active [FlavorConfig] (overridden in `main_dev.dart` and
/// `main_prod.dart`).

@ProviderFor(flavorConfig)
final flavorConfigProvider = FlavorConfigProvider._();

/// Provides the active [FlavorConfig] (overridden in `main_dev.dart` and
/// `main_prod.dart`).

final class FlavorConfigProvider
    extends $FunctionalProvider<FlavorConfig, FlavorConfig, FlavorConfig>
    with $Provider<FlavorConfig> {
  /// Provides the active [FlavorConfig] (overridden in `main_dev.dart` and
  /// `main_prod.dart`).
  FlavorConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flavorConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flavorConfigHash();

  @$internal
  @override
  $ProviderElement<FlavorConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlavorConfig create(Ref ref) {
    return flavorConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlavorConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlavorConfig>(value),
    );
  }
}

String _$flavorConfigHash() => r'67cbe38899ad4d8224fa4b3131538b3ed0a21a97';

/// Provides the singleton local SQLite [AppDatabase].
///
/// Can be overridden in tests with an in-memory `NativeDatabase.memory()`.

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Provides the singleton local SQLite [AppDatabase].
///
/// Can be overridden in tests with an in-memory `NativeDatabase.memory()`.

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Provides the singleton local SQLite [AppDatabase].
  ///
  /// Can be overridden in tests with an in-memory `NativeDatabase.memory()`.
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';

/// Manages the active UI [Locale] (`bn` default, `en` supported) and persists
/// changes to the local settings table.

@ProviderFor(AppLocaleNotifier)
final appLocaleProvider = AppLocaleNotifierProvider._();

/// Manages the active UI [Locale] (`bn` default, `en` supported) and persists
/// changes to the local settings table.
final class AppLocaleNotifierProvider
    extends $NotifierProvider<AppLocaleNotifier, Locale> {
  /// Manages the active UI [Locale] (`bn` default, `en` supported) and persists
  /// changes to the local settings table.
  AppLocaleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleNotifierHash();

  @$internal
  @override
  AppLocaleNotifier create() => AppLocaleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleNotifierHash() => r'2401e8a2e795e20eeb38026ff8df1fa5d7d5626b';

/// Manages the active UI [Locale] (`bn` default, `en` supported) and persists
/// changes to the local settings table.

abstract class _$AppLocaleNotifier extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Manages the active [ThemeMode] (`system`, `light`, `dark`).

@ProviderFor(AppThemeModeNotifier)
final appThemeModeProvider = AppThemeModeNotifierProvider._();

/// Manages the active [ThemeMode] (`system`, `light`, `dark`).
final class AppThemeModeNotifierProvider
    extends $NotifierProvider<AppThemeModeNotifier, ThemeMode> {
  /// Manages the active [ThemeMode] (`system`, `light`, `dark`).
  AppThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeNotifierHash();

  @$internal
  @override
  AppThemeModeNotifier create() => AppThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeNotifierHash() =>
    r'180de8709abd20f1a9d2d31b2dc4643d55a8b25c';

/// Manages the active [ThemeMode] (`system`, `light`, `dark`).

abstract class _$AppThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Manages the active [GlassQuality] tier with hardware auto-detection,
/// startup frame-timing guard, and manual override persistence.

@ProviderFor(GlassQualityNotifier)
final glassQualityProvider = GlassQualityNotifierProvider._();

/// Manages the active [GlassQuality] tier with hardware auto-detection,
/// startup frame-timing guard, and manual override persistence.
final class GlassQualityNotifierProvider
    extends $NotifierProvider<GlassQualityNotifier, GlassQuality> {
  /// Manages the active [GlassQuality] tier with hardware auto-detection,
  /// startup frame-timing guard, and manual override persistence.
  GlassQualityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'glassQualityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$glassQualityNotifierHash();

  @$internal
  @override
  GlassQualityNotifier create() => GlassQualityNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GlassQuality value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GlassQuality>(value),
    );
  }
}

String _$glassQualityNotifierHash() =>
    r'dd4be0aec0063dd0ece0cc6bba2560343d9d61ea';

/// Manages the active [GlassQuality] tier with hardware auto-detection,
/// startup frame-timing guard, and manual override persistence.

abstract class _$GlassQualityNotifier extends $Notifier<GlassQuality> {
  GlassQuality build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GlassQuality, GlassQuality>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GlassQuality, GlassQuality>,
              GlassQuality,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

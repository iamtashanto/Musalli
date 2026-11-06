/// Runtime flavor environment for the Musalli application.
enum AppFlavor {
  /// Development flavor (`com.tashanto.musalli.dev`) with dev tools & showcase.
  dev,

  /// Production flavor (`com.tashanto.musalli`) for store release.
  prod,
}

/// Immutable flavor configuration provided at app startup.
class FlavorConfig {
  /// Creates a [FlavorConfig].
  const FlavorConfig({
    required this.flavor,
    required this.appNameBn,
    required this.appNameEn,
    required this.applicationId,
    required this.websiteBaseUrl,
  });

  /// Creates the development flavor configuration.
  factory FlavorConfig.dev() => const FlavorConfig(
    flavor: AppFlavor.dev,
    appNameBn: 'মুসল্লি (Dev)',
    appNameEn: 'Musalli (Dev)',
    applicationId: 'com.tashanto.musalli.dev',
    websiteBaseUrl: 'https://namajshikkha.tashanto.com',
  );

  /// Creates the production flavor configuration.
  factory FlavorConfig.prod() => const FlavorConfig(
    flavor: AppFlavor.prod,
    appNameBn: 'মুসল্লি',
    appNameEn: 'Musalli',
    applicationId: 'com.tashanto.musalli',
    websiteBaseUrl: 'https://namajshikkha.tashanto.com',
  );

  /// Active flavor enum value.
  final AppFlavor flavor;

  /// Bangla display name for the flavor.
  final String appNameBn;

  /// English display name for the flavor.
  final String appNameEn;

  /// Android applicationId / iOS bundle identifier.
  final String applicationId;

  /// Canonical companion website base URL for Universal / App Links.
  final String websiteBaseUrl;

  /// Returns `true` when running in the development flavor.
  bool get isDev => flavor == AppFlavor.dev;

  /// Returns `true` when running in the production flavor.
  bool get isProd => flavor == AppFlavor.prod;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the application's [GoRouter] configured with a 5-tab
/// [StatefulShellRoute] (`হোম`, `শিখুন`, `সিমুলেটর`, `সময়`, `আরও`), deep-link
/// redirect normalization, and custom page transitions.

@ProviderFor(appRouter)
final appRouterProvider = AppRouterProvider._();

/// Provides the application's [GoRouter] configured with a 5-tab
/// [StatefulShellRoute] (`হোম`, `শিখুন`, `সিমুলেটর`, `সময়`, `আরও`), deep-link
/// redirect normalization, and custom page transitions.

final class AppRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Provides the application's [GoRouter] configured with a 5-tab
  /// [StatefulShellRoute] (`হোম`, `শিখুন`, `সিমুলেটর`, `সময়`, `আরও`), deep-link
  /// redirect normalization, and custom page transitions.
  AppRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return appRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$appRouterHash() => r'3d681543b6c1cdd41662528bcf1b0f5e9dc46f9c';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/error/global_error_handler.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/router/app_router.dart';
import 'package:musalli/core/services/app_logger.dart';
import 'package:musalli/core/theme/musalli_theme.dart';

/// Root widget for the Musalli application.
class MusalliApp extends ConsumerStatefulWidget {
  /// Creates a [MusalliApp].
  const MusalliApp({super.key});

  @override
  ConsumerState<MusalliApp> createState() => _MusalliAppState();
}

class _MusalliAppState extends ConsumerState<MusalliApp> {
  final List<FrameTiming> _startupTimings = <FrameTiming>[];
  late final TimingsCallback _timingsCallback;
  bool _isMonitoringTimings = false;

  @override
  void initState() {
    super.initState();
    _timingsCallback = (List<FrameTiming> timings) {
      _startupTimings.addAll(timings);
      if (_startupTimings.length >= 25 && _isMonitoringTimings) {
        _isMonitoringTimings = false;
        SchedulerBinding.instance.removeTimingsCallback(_timingsCallback);
        if (mounted) {
          ref
              .read(glassQualityProvider.notifier)
              .reportStartupFrameTimings(_startupTimings);
        }
      }
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        ref.read(glassQualityProvider.notifier).initializeAutoDetection(),
      );
      _isMonitoringTimings = true;
      SchedulerBinding.instance.addTimingsCallback(_timingsCallback);
    });
  }

  @override
  void dispose() {
    if (_isMonitoringTimings) {
      SchedulerBinding.instance.removeTimingsCallback(_timingsCallback);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final flavor = ref.watch(flavorConfigProvider);

    return MaterialApp.router(
      title: locale.languageCode == 'bn' ? flavor.appNameBn : flavor.appNameEn,
      debugShowCheckedModeBanner: flavor.isDev,
      theme: MusalliTheme.light(),
      darkTheme: MusalliTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}

/// Bootstraps the Musalli application with the given [FlavorConfig],
/// global error handlers, and Riverpod [ProviderScope].
Future<void> bootstrapMusalliApp(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalErrorHandler.initialize();

  AppLogger.info(
    'Bootstrapping ${config.appNameEn} (${config.applicationId})',
    tag: 'Bootstrap',
  );

  runApp(
    ProviderScope(
      overrides: [
        flavorConfigProvider.overrideWithValue(config),
      ],
      child: const MusalliApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/motion/musalli_page_transitions.dart';
import 'package:musalli/core/design_system/showcase/design_system_showcase_screen.dart';
import 'package:musalli/core/router/main_shell_scaffold.dart';
import 'package:musalli/features/dua/presentation/dua_detail_screen.dart';
import 'package:musalli/features/extra/presentation/adhkar_screen.dart';
import 'package:musalli/features/extra/presentation/asmaul_husna_screen.dart';
import 'package:musalli/features/extra/presentation/calendar_screen.dart';
import 'package:musalli/features/extra/presentation/ramadan_screen.dart';
import 'package:musalli/features/extra/presentation/tasbih_screen.dart';
import 'package:musalli/features/extra/presentation/zakat_calculator_screen.dart';
import 'package:musalli/features/hadith/presentation/hadith_screen.dart';
import 'package:musalli/features/helpers/presentation/masbuq_calculator_screen.dart';
import 'package:musalli/features/helpers/presentation/qasr_calculator_screen.dart';
import 'package:musalli/features/helpers/presentation/sajda_sahu_helper_screen.dart';
import 'package:musalli/features/helpers/presentation/sick_prayer_helper_screen.dart';
import 'package:musalli/features/hifz/presentation/hifz_practice_screen.dart';
import 'package:musalli/features/history/presentation/history_screen.dart';
import 'package:musalli/features/home/presentation/home_screen.dart';
import 'package:musalli/features/kids/presentation/kids_hub_screen.dart';
import 'package:musalli/features/learn/presentation/learn_hub_screen.dart';
import 'package:musalli/features/masail/presentation/masail_detail_screen.dart';
import 'package:musalli/features/more/presentation/more_screen.dart';
import 'package:musalli/features/onboarding/presentation/onboarding_screen.dart';
import 'package:musalli/features/prayer_detail/presentation/prayer_detail_screen.dart';
import 'package:musalli/features/quran/presentation/quran_reader_screen.dart';
import 'package:musalli/features/settings/presentation/settings_screen.dart';
import 'package:musalli/features/simulator/presentation/dev_poses_screen.dart';
import 'package:musalli/features/simulator/presentation/practice/practice_screen.dart';
import 'package:musalli/features/simulator/presentation/simulator_screen.dart';
import 'package:musalli/features/taharat/presentation/taharat_detail_screen.dart';
import 'package:musalli/features/times/presentation/notification_settings_screen.dart';
import 'package:musalli/features/times/presentation/qibla_screen.dart';
import 'package:musalli/features/times/presentation/times_screen.dart';
import 'package:musalli/features/tracker/presentation/tracker_screen.dart';
import 'package:musalli/features/wudu/presentation/wudu_simulator_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigator',
);
final GlobalKey<NavigatorState> _homeBranchKey = GlobalKey<NavigatorState>(
  debugLabel: 'homeBranch',
);
final GlobalKey<NavigatorState> _learnBranchKey = GlobalKey<NavigatorState>(
  debugLabel: 'learnBranch',
);
final GlobalKey<NavigatorState> _simulatorBranchKey = GlobalKey<NavigatorState>(
  debugLabel: 'simulatorBranch',
);
final GlobalKey<NavigatorState> _timesBranchKey = GlobalKey<NavigatorState>(
  debugLabel: 'timesBranch',
);
final GlobalKey<NavigatorState> _moreBranchKey = GlobalKey<NavigatorState>(
  debugLabel: 'moreBranch',
);

/// Normalizes incoming custom-scheme (`musalli://...`) and HTTPS Universal /
/// App Link (`https://namajshikkha.tashanto.com/...`) URIs into canonical
/// internal route paths.
///
/// Examples:
/// - `musalli://namaj/fajr` -> `/namaj/fajr`
/// - `musalli://simulator?prayer=zuhr&unit=fard` -> `/simulator?prayer=zuhr&unit=fard`
/// - `https://namajshikkha.tashanto.com/namaj/fajr` -> `/namaj/fajr`
String? normalizeIncomingDeepLinkUri(Uri uri) {
  if (uri.scheme == 'musalli') {
    final hostSegment = uri.host.isNotEmpty ? '/${uri.host}' : '';
    final pathPart = '$hostSegment${uri.path}';
    final normalizedPath = pathPart.isEmpty ? '/' : pathPart;
    final queryPart = uri.hasQuery ? '?${uri.query}' : '';
    return '$normalizedPath$queryPart';
  }

  if ((uri.scheme == 'https' || uri.scheme == 'http') &&
      uri.host == 'namajshikkha.tashanto.com') {
    final normalizedPath = uri.path.isEmpty ? '/' : uri.path;
    final queryPart = uri.hasQuery ? '?${uri.query}' : '';
    return '$normalizedPath$queryPart';
  }

  return null;
}

/// Provides the application's [GoRouter] configured with a 5-tab
/// [StatefulShellRoute] (`হোম`, `শিখুন`, `সিমুলেটর`, `সময়`, `আরও`), deep-link
/// redirect normalization, and custom page transitions.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final normalized = normalizeIncomingDeepLinkUri(state.uri);
      if (normalized != null && normalized != state.uri.toString()) {
        return normalized;
      }
      return null;
    },
    routes: <RouteBase>[
      StatefulShellRoute(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return navigationShell;
            },
        navigatorContainerBuilder:
            (
              BuildContext context,
              StatefulNavigationShell navigationShell,
              List<Widget> children,
            ) {
              return MainShellScaffold(
                navigationShell: navigationShell,
                children: children,
              );
            },
        branches: <StatefulShellBranch>[
          // Branch 0: হোম (Home)
          StatefulShellBranch(
            navigatorKey: _homeBranchKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(),
              ),
            ],
          ),

          // Branch 1: শিখুন (Learn)
          StatefulShellBranch(
            navigatorKey: _learnBranchKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/learn',
                builder: (BuildContext context, GoRouterState state) =>
                    const LearnHubScreen(),
              ),
            ],
          ),

          // Branch 2: সিমুলেটর (Simulator)
          StatefulShellBranch(
            navigatorKey: _simulatorBranchKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/simulator',
                builder: (BuildContext context, GoRouterState state) {
                  return SimulatorScreen(
                    initialPrayerSlug: state.uri.queryParameters['prayer'],
                    initialUnitStatus: state.uri.queryParameters['unit'],
                    initialGenderStr: state.uri.queryParameters['gender'],
                    initialRoleStr: state.uri.queryParameters['role'],
                    initialPostureModeStr: state.uri.queryParameters['mode'],
                  );
                },
                routes: [
                  GoRoute(
                    path: 'practice',
                    builder: (BuildContext context, GoRouterState state) {
                      final prayer =
                          state.uri.queryParameters['prayer'] ?? 'fajr';
                      return PracticeScreen(prayerSlug: prayer);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Branch 3: সময় (Times)
          StatefulShellBranch(
            navigatorKey: _timesBranchKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/times',
                builder: (BuildContext context, GoRouterState state) =>
                    const TimesScreen(),
              ),
            ],
          ),

          // Branch 4: আরও (More)
          StatefulShellBranch(
            navigatorKey: _moreBranchKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/more',
                builder: (BuildContext context, GoRouterState state) =>
                    const MoreScreen(),
              ),
            ],
          ),
        ],
      ),

      // Top-level pushed route: /namaj/:slug (supports Hero card transform & deep links)
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/namaj/:slug',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final slug = state.pathParameters['slug'] ?? 'fajr';
          return MusalliPageTransitions.heroDetail(
            state: state,
            child: PrayerDetailScreen(slug: slug),
          );
        },
      ),

      // Masail detail route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/masail/:slug',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final slug = state.pathParameters['slug'] ?? '';
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: MasailDetailScreen(slug: slug),
          );
        },
      ),

      // Taharat detail route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/taharat/:slug',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final slug = state.pathParameters['slug'] ?? 'wudu';
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: TaharatDetailScreen(slug: slug),
          );
        },
      ),

      // Interactive Helper 1: Sajda Sahu Assistant
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/helpers/sajda-sahu',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const SajdaSahuHelperScreen(),
          );
        },
      ),

      // Interactive Helper 2: Sick Prayer Assistant
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/helpers/sick-prayer',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const SickPrayerHelperScreen(),
          );
        },
      ),

      // Interactive Helper 3: Masbuq Calculator
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/helpers/masbuq',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const MasbuqCalculatorScreen(),
          );
        },
      ),

      // Interactive Helper 4: Qasr Calculator
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/helpers/qasr',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const QasrCalculatorScreen(),
          );
        },
      ),

      // Dua detail route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/dua/:id',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters['id'] ?? '';
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: DuaDetailScreen(duaId: id),
          );
        },
      ),

      // Quran reader route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/quran/:number',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final numStr = state.pathParameters['number'] ?? '1';
          final number = int.tryParse(numStr) ?? 1;
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: QuranReaderScreen(surahNumber: number),
          );
        },
      ),

      // Hadith & FAQ full screen route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/hadith',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const HadithScreen(),
          );
        },
      ),

      // History full screen route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/history',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const HistoryScreen(),
          );
        },
      ),

      // Wudu Simulator route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/wudu/simulator',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const WuduSimulatorScreen(),
          );
        },
      ),

      // Gamified Kids Mode route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/kids',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const KidsHubScreen(),
          );
        },
      ),

      // Onboarding Screen route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/onboarding',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const OnboardingScreen(),
          );
        },
      ),

      // Private Tracker & Qaza route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/tracker',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const TrackerScreen(),
          );
        },
      ),

      // Qibla Compass route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/qibla',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const QiblaScreen(),
          );
        },
      ),

      // Prayer Notification Settings route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/notifications/settings',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const NotificationSettingsScreen(),
          );
        },
      ),

      // Hifz Memorization route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/hifz/:number',
        pageBuilder: (BuildContext context, GoRouterState state) {
          final number = int.tryParse(state.pathParameters['number'] ?? '1') ?? 1;
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: HifzPracticeScreen(surahNumber: number),
          );
        },
      ),

      // Digital Tasbih route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/tasbih',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const TasbihScreen(),
          );
        },
      ),

      // Morning & Evening Adhkar route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/adhkar',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const AdhkarScreen(),
          );
        },
      ),

      // Asmaul Husna (99 Names) route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/asmaul-husna',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const AsmaulHusnaScreen(),
          );
        },
      ),

      // Hijri Calendar route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/calendar',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const CalendarScreen(),
          );
        },
      ),

      // Ramadan Mode route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/ramadan',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const RamadanScreen(),
          );
        },
      ),

      // Zakat Calculator route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/zakat',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const ZakatCalculatorScreen(),
          );
        },
      ),

      // App Settings route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/settings',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const SettingsScreen(),
          );
        },
      ),

      // Dev-only Design System Showcase route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/dev/design-system',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const DesignSystemShowcaseScreen(),
          );
        },
      ),

      // Dev-only 2D Figure Poses Inspector route
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/dev/poses',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MusalliPageTransitions.sharedAxisHorizontal(
            state: state,
            child: const DevPosesScreen(),
          );
        },
      ),
    ],
  );
}

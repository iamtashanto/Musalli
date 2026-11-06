import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/motion/musalli_page_transitions.dart';
import 'package:musalli/core/design_system/showcase/design_system_showcase_screen.dart';
import 'package:musalli/core/router/main_shell_scaffold.dart';
import 'package:musalli/features/shell/presentation/placeholder_screens.dart';
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
                    const HomeTabScreen(),
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
                    const LearnTabScreen(),
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
                  return SimulatorTabScreen(
                    initialPrayerSlug: state.uri.queryParameters['prayer'],
                    initialUnitId: state.uri.queryParameters['unit'],
                  );
                },
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
                    const TimesTabScreen(),
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
                    const MoreTabScreen(),
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
            child: PrayerDetailPlaceholderScreen(slug: slug),
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
    ],
  );
}

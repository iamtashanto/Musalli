import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/backgrounds/animated_gradient_background.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';

/// Root `StatefulShellRoute` scaffold hosting the 5 bottom navigation tabs
/// (`হোম`, `শিখুন`, `সিমুলেটর`, `সময়`, `আরও`) with:
/// - Floating [GlassBottomNavBar] over scrolling content.
/// - Auto-hide on scroll down, auto-show on scroll up.
/// - Re-tapping the active tab smoothly scrolls its primary scrollable to the top
///   or pops to the root of that branch.
/// - Cross-fade + subtle vertical offset transition when switching tabs without
///   rebuilding inactive branches.
class MainShellScaffold extends StatefulWidget {
  /// Creates a [MainShellScaffold].
  const MainShellScaffold({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  /// GoRouter stateful navigation shell controller.
  final StatefulNavigationShell navigationShell;

  /// The 5 branch navigator widgets managed by `StatefulShellRoute`.
  final List<Widget> children;

  @override
  State<MainShellScaffold> createState() => _MainShellScaffoldState();
}

class _MainShellScaffoldState extends State<MainShellScaffold> {
  bool _isBottomNavVisible = true;

  bool _handleScrollNotification(UserScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }

    if (notification.direction == ScrollDirection.reverse &&
        notification.metrics.pixels > 48 &&
        _isBottomNavVisible) {
      setState(() => _isBottomNavVisible = false);
    } else if ((notification.direction == ScrollDirection.forward ||
            notification.metrics.pixels <= 16) &&
        !_isBottomNavVisible) {
      setState(() => _isBottomNavVisible = true);
    }
    return false;
  }

  void _onTapTab(int index) {
    final isReTap = index == widget.navigationShell.currentIndex;

    if (isReTap) {
      // Scroll primary controller to top if attached, and reset branch stack.
      final primaryController = PrimaryScrollController.maybeOf(context);
      if (primaryController != null && primaryController.hasClients) {
        primaryController.animateTo(
          0,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        );
      }
      widget.navigationShell.goBranch(index, initialLocation: true);
      if (!_isBottomNavVisible) {
        setState(() => _isBottomNavVisible = true);
      }
      return;
    }

    if (!_isBottomNavVisible) {
      setState(() => _isBottomNavVisible = true);
    }
    // Switch to the target branch via GoRouter
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentIndex = widget.navigationShell.currentIndex;

    final navItems = <GlassNavBarItem>[
      GlassNavBarItem(
        label: l10n.tabHome,
        icon: Icons.mosque_outlined,
        activeIcon: Icons.mosque_rounded,
      ),
      GlassNavBarItem(
        label: l10n.tabLearn,
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book_rounded,
      ),
      GlassNavBarItem(
        label: l10n.tabSimulator,
        icon: Icons.play_circle_outline_rounded,
        activeIcon: Icons.play_circle_fill_rounded,
      ),
      GlassNavBarItem(
        label: l10n.tabTimes,
        icon: Icons.schedule_outlined,
        activeIcon: Icons.schedule_rounded,
      ),
      GlassNavBarItem(
        label: l10n.tabMore,
        icon: Icons.grid_view_outlined,
        activeIcon: Icons.grid_view_rounded,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedGradientBackground(
        child: NotificationListener<UserScrollNotification>(
          onNotification: _handleScrollNotification,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Preserve state of all 5 branches without stacking transparent artifacts
              ...List<Widget>.generate(widget.children.length, (int i) {
                final isActive = i == currentIndex;
                return Offstage(
                  offstage: !isActive,
                  child: TickerMode(
                    enabled: isActive,
                    child: widget.children[i],
                  ),
                );
              }),

              // Floating GlassBottomNavBar
              Align(
                alignment: Alignment.bottomCenter,
                child: GlassBottomNavBar(
                  items: navItems,
                  currentIndex: currentIndex,
                  isVisible: _isBottomNavVisible,
                  onTap: _onTapTab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

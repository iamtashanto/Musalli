import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Custom page builders and staggered entrance wrappers for Musalli's
/// motion system.
///
/// Every transition checks `MediaQuery.disableAnimations` (`context.isReducedMotion`)
/// and falls back to a fast simple fade when reduced motion is enabled.
class MusalliPageTransitions {
  const MusalliPageTransitions._();

  /// Default horizontal shared-axis push transition:
  /// fade + slight horizontal slide + subtle scale (`0.96 -> 1.0`), 300ms
  /// emphasized curve.
  static CustomTransitionPage<T> sharedAxisHorizontal<T>({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        if (context.isReducedMotion) {
          return FadeTransition(opacity: animation, child: child);
        }

        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubicEmphasized,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.08, 0),
              end: Offset.zero,
            ).animate(curved),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.97, end: 1).animate(curved),
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Container transform / Hero detail transition (`Card -> Detail`) with a
  /// smooth 350ms emphasized curve so Hero shuttles land cleanly.
  static CustomTransitionPage<T> heroDetail<T>({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubicEmphasized,
        );
        return FadeTransition(opacity: curved, child: child);
      },
    );
  }

  /// Modal vertical slide transition with a frosted glass backdrop for
  /// simulator setup, settings, and dev showcase sheets.
  static CustomTransitionPage<T> glassModalSheet<T>({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      opaque: false,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 360),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      child: child,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        if (context.isReducedMotion) {
          return FadeTransition(opacity: animation, child: child);
        }

        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubicEmphasized,
        );

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8 * curved.value,
            sigmaY: 8 * curved.value,
          ),
          child: FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.14),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// Animates a list item with a staggered fade + vertical slide entrance **only
/// the first time** it mounts, preventing repeat entrance animations on
/// subsequent widget rebuilds or state updates.
class FirstMountStaggeredEntrance extends StatefulWidget {
  /// Creates a [FirstMountStaggeredEntrance].
  const FirstMountStaggeredEntrance({
    required this.index,
    required this.child,
    super.key,
  });

  /// Zero-based item index used to compute stagger delay (`index * 45ms`, capped).
  final int index;

  /// Child widget to animate on first mount.
  final Widget child;

  @override
  State<FirstMountStaggeredEntrance> createState() =>
      _FirstMountStaggeredEntranceState();
}

class _FirstMountStaggeredEntranceState
    extends State<FirstMountStaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;

    if (context.isReducedMotion) {
      _controller.value = 1.0;
      return;
    }

    final delayMs = (widget.index.clamp(0, 8)) * 40;
    if (delayMs == 0) {
      _controller.forward();
    } else {
      Future<void>.delayed(Duration(milliseconds: delayMs), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

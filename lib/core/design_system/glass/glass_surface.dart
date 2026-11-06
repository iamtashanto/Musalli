import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/providers/app_providers.dart';

/// Inherited marker used by [GlassSurface] to detect if an ancestor
/// [GlassSurface] has already applied a `BackdropFilter` in the current
/// subtree, strictly enforcing the "never nest blurs" performance rule.
class _GlassBlurScope extends InheritedWidget {
  const _GlassBlurScope({required this.hasActiveBlur, required super.child});

  final bool hasActiveBlur;

  static bool isInsideBlurredRegion(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_GlassBlurScope>();
    return scope?.hasActiveBlur ?? false;
  }

  @override
  bool updateShouldNotify(_GlassBlurScope oldWidget) =>
      oldWidget.hasActiveBlur != hasActiveBlur;
}

/// Core frosted glass surface primitive for the Musalli design system.
///
/// Features:
/// - `BackdropFilter` blur (sigma 20–30 in `GlassQuality.high`, 12 in `medium`,
///   disabled in `low`).
/// - Translucent surface fill + 1px directional gradient border (top-left
///   specular highlight) + optional soft shadow.
/// - Performance guard: wraps in a [RepaintBoundary], automatically skips
///   nested `BackdropFilter`s if already inside a blurred ancestor, and
///   degrades to a zero-blur translucent card when [GlassQuality.low] is active.
class GlassSurface extends ConsumerWidget {
  /// Creates a [GlassSurface].
  const GlassSurface({
    required this.child,
    this.blur,
    this.opacity,
    this.tint,
    this.radius,
    this.borderRadius,
    this.borderGlow = false,
    this.enableBlur = true,
    this.enableShadow = true,
    this.padding,
    this.margin,
    super.key,
  });

  /// Content rendered inside the glass surface.
  final Widget child;

  /// Optional override for blur sigma (defaults to 24 in high, 12 in medium, 0 in low).
  final double? blur;

  /// Optional translucent fill opacity (`0.0`–`1.0`).
  final double? opacity;

  /// Optional surface tint color override.
  final Color? tint;

  /// Corner radius scalar (defaults to `tokens.radii.md` = 20pt).
  final double? radius;

  /// Optional explicit [BorderRadius] override.
  final BorderRadius? borderRadius;

  /// When `true`, renders an emerald/gold specular glow on the 1px border.
  final bool borderGlow;

  /// Whether this surface should apply a `BackdropFilter` when quality permits.
  ///
  /// Set to `false` for high-density scrolling list items (`GlassCard`s inside
  /// a 50+ item list) so only floating bars/sheets/hero headers use real-time
  /// blur while cards render at a locked 60fps.
  final bool enableBlur;

  /// Whether to render the soft ambient drop shadow.
  final bool enableShadow;

  /// Inner padding inside the glass container.
  final EdgeInsetsGeometry? padding;

  /// Outer margin around the glass container.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final quality = ref.watch(glassQualityProvider);
    final isDark = colors.brightness == Brightness.dark;

    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(radius ?? tokens.radii.md);

    final isNestedBlur = _GlassBlurScope.isInsideBlurredRegion(context);
    final shouldApplyBackdropBlur =
        enableBlur && !quality.isBlurDisabled && !isNestedBlur;

    final sigma = shouldApplyBackdropBlur
        ? (blur ?? quality.defaultBlurSigma)
        : 0.0;

    final defaultOpacity = quality.isBlurDisabled
        ? (isDark ? 0.92 : 0.95)
        : (isDark ? 0.48 : 0.68);
    final effectiveOpacity = (opacity ?? defaultOpacity).clamp(0.0, 1.0);

    final baseTint =
        tint ??
        (quality.isBlurDisabled
            ? colors.surfaceLowRamFallback
            : colors.surfaceGlassTint);

    final topLeftBorderColor = borderGlow
        ? colors.goldAccent.withValues(alpha: isDark ? 0.75 : 0.65)
        : colors.borderHighlight;
    final bottomRightBorderColor = borderGlow
        ? colors.primaryEmerald.withValues(alpha: 0.45)
        : colors.borderSubtle;

    Widget content = Padding(padding: padding ?? EdgeInsets.zero, child: child);

    content = CustomPaint(
      foregroundPainter: _GradientBorderPainter(
        borderRadius: effectiveBorderRadius,
        topLeftColor: topLeftBorderColor,
        bottomRightColor: bottomRightBorderColor,
        strokeWidth: borderGlow ? 1.4 : 1.0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: effectiveBorderRadius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              baseTint.withValues(alpha: effectiveOpacity),
              baseTint.withValues(
                alpha: (effectiveOpacity * 0.82).clamp(0.0, 1.0),
              ),
            ],
          ),
        ),
        child: content,
      ),
    );

    if (shouldApplyBackdropBlur && sigma > 0) {
      content = _GlassBlurScope(
        hasActiveBlur: true,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: content,
        ),
      );
    }

    Widget clipped = ClipRRect(
      borderRadius: effectiveBorderRadius,
      child: content,
    );

    if (enableShadow && !quality.isBlurDisabled) {
      clipped = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: effectiveBorderRadius,
          boxShadow: tokens.glassShadows,
        ),
        child: clipped,
      );
    }

    if (margin != null) {
      clipped = Padding(padding: margin!, child: clipped);
    }

    return RepaintBoundary(child: clipped);
  }
}

class _GradientBorderPainter extends CustomPainter {
  const _GradientBorderPainter({
    required this.borderRadius,
    required this.topLeftColor,
    required this.bottomRightColor,
    required this.strokeWidth,
  });

  final BorderRadius borderRadius;
  final Color topLeftColor;
  final Color bottomRightColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect).deflate(strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[topLeftColor, bottomRightColor],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientBorderPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.topLeftColor != topLeftColor ||
        oldDelegate.bottomRightColor != bottomRightColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

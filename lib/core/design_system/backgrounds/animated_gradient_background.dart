import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Slow, subtle ambient gradient drift background with an optional low-opacity
/// Islamic geometric star pattern overlay.
///
/// Automatically pauses its animation when:
/// - `MediaQuery.disableAnimations` (reduced motion) is enabled, or
/// - the app lifecycle transitions to background/inactive.
class AnimatedGradientBackground extends StatefulWidget {
  /// Creates an [AnimatedGradientBackground].
  const AnimatedGradientBackground({
    required this.child,
    this.showPattern = true,
    this.patternOpacity = 0.035,
    super.key,
  });

  /// Foreground content placed over the ambient background.
  final Widget child;

  /// Whether to render the subtle Islamic geometric [PatternOverlay].
  final bool showPattern;

  /// Opacity of the geometric pattern (`0.0`–`1.0`).
  final double patternOpacity;

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimationState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncAnimationState();
    } else {
      _controller.stop();
    }
  }

  void _syncAnimationState() {
    final reducedMotion = context.isReducedMotion;
    if (reducedMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.tokens.colors;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? _) {
              final t = _controller.value;
              final beginAlign = Alignment(
                -0.8 + (0.4 * t),
                -1.0 + (0.3 * t),
              );
              final endAlign = Alignment(
                0.8 - (0.4 * t),
                1.0 - (0.3 * t),
              );

              return DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: beginAlign,
                    end: endAlign,
                    colors: <Color>[
                      colors.backgroundStart,
                      colors.backgroundMiddle,
                      colors.backgroundEnd,
                    ],
                    stops: const <double>[0.0, 0.52, 1.0],
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.showPattern)
          IgnorePointer(
            child: RepaintBoundary(
              child: PatternOverlay(
                opacity: widget.patternOpacity,
                color: colors.primaryEmerald,
              ),
            ),
          ),
        widget.child,
      ],
    );
  }
}

/// Renders a subtle 8-pointed Rub el Hizb Islamic geometric lattice pattern
/// via a cached [CustomPainter].
class PatternOverlay extends StatelessWidget {
  /// Creates a [PatternOverlay].
  const PatternOverlay({
    this.opacity = 0.035,
    this.color = const Color(0xFF10B981),
    this.tileSize = 96,
    super.key,
  });

  /// Stroke opacity (`0.0`–`1.0`).
  final double opacity;

  /// Base stroke color.
  final Color color;

  /// Repeating geometric tile size in logical pixels.
  final double tileSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _IslamicGeometricPatternPainter(
        color: color.withValues(alpha: opacity.clamp(0.0, 1.0)),
        tileSize: tileSize,
      ),
      size: Size.infinite,
    );
  }
}

class _IslamicGeometricPatternPainter extends CustomPainter {
  const _IslamicGeometricPatternPainter({
    required this.color,
    required this.tileSize,
  });

  final Color color;
  final double tileSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || tileSize <= 16) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final cols = (size.width / tileSize).ceil() + 1;
    final rows = (size.height / tileSize).ceil() + 1;
    final radius = tileSize * 0.34;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final cx = col * tileSize + (row.isOdd ? tileSize * 0.5 : 0);
        final cy = row * tileSize;
        _drawEightPointedStar(canvas, Offset(cx, cy), radius, paint);
      }
    }
  }

  void _drawEightPointedStar(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    final rect = Rect.fromCircle(center: center, radius: radius * 0.72);
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..drawRect(rect.shift(-center), paint)
      ..rotate(math.pi / 4)
      ..drawRect(rect.shift(-center), paint)
      ..restore()
      ..drawCircle(center, radius * 0.22, paint);
  }

  @override
  bool shouldRepaint(covariant _IslamicGeometricPatternPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.tileSize != tileSize;
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';

enum SkyTimePhase {
  dawn, // Fajr
  day, // Dhuhr / Asr
  sunset, // Maghrib
  night, // Isha / Tahajjud
}

/// Dynamic animated sky background that reflects current time of day:
/// - Dawn: soft indigo, rose gold, and peach morning light
/// - Day: bright daylight emerald-teal sky
/// - Sunset: crimson, vibrant orange, and purple twilight
/// - Night: midnight navy with twinkling stars
class SkyBackground extends StatefulWidget {
  const SkyBackground({
    required this.schedule,
    required this.now,
    required this.child,
    super.key,
  });

  final DailyScheduleTimes schedule;
  final DateTime now;
  final Widget child;

  @override
  State<SkyBackground> createState() => _SkyBackgroundState();
}

class _SkyBackgroundState extends State<SkyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!context.isReducedMotion) {
      _starController.repeat(reverse: true);
    } else {
      _starController.stop();
    }
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  SkyTimePhase _resolvePhase() {
    final now = widget.now;
    final sch = widget.schedule;

    if (now.isAfter(sch.fajr) &&
        now.isBefore(sch.sunrise.add(const Duration(minutes: 30)))) {
      return SkyTimePhase.dawn;
    }
    if (now.isAfter(sch.sunrise.add(const Duration(minutes: 30))) &&
        now.isBefore(sch.maghrib.subtract(const Duration(minutes: 30)))) {
      return SkyTimePhase.day;
    }
    if (now.isAfter(sch.maghrib.subtract(const Duration(minutes: 30))) &&
        now.isBefore(sch.maghrib.add(const Duration(minutes: 45)))) {
      return SkyTimePhase.sunset;
    }
    return SkyTimePhase.night;
  }

  @override
  Widget build(BuildContext context) {
    final phase = _resolvePhase();

    List<Color> colors;
    switch (phase) {
      case SkyTimePhase.dawn:
        colors = const [
          Color(0xFF1F1A3A),
          Color(0xFF3B2E58),
          Color(0xFF6B435F),
          Color(0xFFD67D65),
        ];
      case SkyTimePhase.day:
        colors = const [
          Color(0xFF0F3B36),
          Color(0xFF134E48),
          Color(0xFF0C2E2A),
          Color(0xFF071F1C),
        ];
      case SkyTimePhase.sunset:
        colors = const [
          Color(0xFF2E1A47),
          Color(0xFF5E2750),
          Color(0xFF9E3D46),
          Color(0xFFE26D44),
        ];
      case SkyTimePhase.night:
        colors = const [
          Color(0xFF050B14),
          Color(0xFF0A1322),
          Color(0xFF0D1B2A),
          Color(0xFF06101E),
        ];
    }

    return Stack(
      children: [
        // Sky Gradient
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
          ),
        ),

        // Night / Dawn Stars
        if (phase == SkyTimePhase.night || phase == SkyTimePhase.dawn)
          AnimatedBuilder(
            animation: _starController,
            builder: (context, _) {
              return CustomPaint(
                painter: _StarFieldPainter(twinkle: _starController.value),
                size: Size.infinite,
              );
            },
          ),

        // Content
        widget.child,
      ],
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  const _StarFieldPainter({required this.twinkle});
  final double twinkle;

  static const List<Offset> _fixedStars = [
    Offset(0.12, 0.08),
    Offset(0.25, 0.14),
    Offset(0.38, 0.06),
    Offset(0.55, 0.12),
    Offset(0.68, 0.07),
    Offset(0.82, 0.15),
    Offset(0.91, 0.09),
    Offset(0.18, 0.22),
    Offset(0.44, 0.26),
    Offset(0.62, 0.21),
    Offset(0.79, 0.28),
    Offset(0.32, 0.35),
    Offset(0.71, 0.38),
    Offset(0.88, 0.32),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _fixedStars.length; i++) {
      final norm = _fixedStars[i];
      final pos = Offset(norm.dx * size.width, norm.dy * size.height);
      final alphaFactor = (math.sin(twinkle * math.pi * 2 + i) + 1) / 2;
      final opacity = 0.25 + 0.65 * alphaFactor;

      final paint = Paint()
        ..color = Colors.white.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, (i % 3 == 0 ? 1.8 : 1.2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter oldDelegate) =>
      oldDelegate.twinkle != twinkle;
}

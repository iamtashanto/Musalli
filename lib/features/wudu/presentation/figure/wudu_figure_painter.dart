import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:musalli/features/wudu/domain/wudu_models.dart';

/// Articulated 2D custom painter illustrating Wudu steps with gentle water particle animations.
class WuduFigureWidget extends StatefulWidget {
  const WuduFigureWidget({super.key, required this.step, this.isMuted = false});

  final WuduStep step;
  final bool isMuted;

  @override
  State<WuduFigureWidget> createState() => _WuduFigureWidgetState();
}

class _WuduFigureWidgetState extends State<WuduFigureWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _WuduFigurePainter(
            step: widget.step,
            animProgress: reduceMotion ? 0.5 : _animController.value,
          ),
        );
      },
    );
  }
}

class _WuduFigurePainter extends CustomPainter {
  const _WuduFigurePainter({required this.step, required this.animProgress});

  final WuduStep step;
  final double animProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Palette
    const skinColor = Color(0xFFD4A373);
    const robeColor = Color(0xFFE2E8F0);
    const benchColor = Color(0xFF334155);
    const tapColor = Color(0xFF94A3B8);
    const waterColor = Color(0x9938BDF8);
    const dropletColor = Color(0xCC0EA5E9);

    final bgPaint = Paint()..color = const Color(0x08FFFFFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)),
      bgPaint,
    );

    // Baseline floor & stool/bench
    final floorY = h * 0.88;
    final stoolRect = Rect.fromLTWH(
      w * 0.28,
      floorY - h * 0.22,
      w * 0.22,
      h * 0.22,
    );
    final benchPaint = Paint()..color = benchColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(stoolRect, const Radius.circular(8)),
      benchPaint,
    );

    // Water Tap and Basin on Right
    final tapX = w * 0.72;
    final tapY = floorY - h * 0.38;
    final tapPaint = Paint()
      ..color = tapColor
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final tapPath = Path()
      ..moveTo(tapX + 25, tapY - 40)
      ..lineTo(tapX, tapY - 40)
      ..lineTo(tapX, tapY);
    canvas.drawPath(tapPath, tapPaint);

    // Basin
    final basinPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    final basinRect = Rect.fromLTWH(tapX - 25, floorY - h * 0.12, 60, h * 0.12);
    canvas.drawRRect(
      RRect.fromRectAndRadius(basinRect, const Radius.circular(6)),
      basinPaint,
    );

    // Head Center
    final headCenter = Offset(w * 0.42, floorY - h * 0.52);
    final headRadius = w * 0.09;

    // Body / Torso
    final torsoPaint = Paint()..color = robeColor;
    final torsoPath = Path()
      ..moveTo(headCenter.dx - 18, headCenter.dy + headRadius)
      ..lineTo(headCenter.dx + 26, headCenter.dy + headRadius + 10)
      ..lineTo(headCenter.dx + 35, floorY - h * 0.22)
      ..lineTo(headCenter.dx - 22, floorY - h * 0.22)
      ..close();
    canvas.drawPath(torsoPath, torsoPaint);

    // Thighs / Lap
    final lapPaint = Paint()..color = const Color(0xFFCBD5E1);
    final lapPath = Path()
      ..moveTo(headCenter.dx - 22, floorY - h * 0.22)
      ..lineTo(headCenter.dx + 48, floorY - h * 0.22)
      ..lineTo(headCenter.dx + 45, floorY - h * 0.08)
      ..lineTo(headCenter.dx + 20, floorY)
      ..lineTo(headCenter.dx - 15, floorY)
      ..close();
    canvas.drawPath(lapPath, lapPaint);

    // Head (blank, modest, respectful)
    final headPaint = Paint()..color = skinColor;
    canvas.drawCircle(headCenter, headRadius, headPaint);

    // White Prayer Cap (Tupi)
    final tupiPaint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: headCenter, radius: headRadius + 1),
      math.pi,
      math.pi,
      true,
      tupiPaint,
    );

    // Arm Poses based on Wudu Step
    final armPaint = Paint()
      ..color = skinColor
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final target = step.waterTargetArea;
    Offset streamTarget = Offset(tapX, tapY + 50);

    switch (target) {
      case WaterTargetArea.hands:
        // Both hands reaching forward under the faucet
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(tapX - 5, tapY + 45),
          armPaint,
        );
        streamTarget = Offset(tapX, tapY + 45);

      case WaterTargetArea.mouth:
      case WaterTargetArea.nose:
        // Right arm cupping water towards mouth/nose
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(headCenter.dx + headRadius - 2, headCenter.dy + 8),
          armPaint,
        );
        streamTarget = Offset(
          headCenter.dx + headRadius - 2,
          headCenter.dy + 8,
        );

      case WaterTargetArea.face:
        // Both hands cupped at cheeks
        canvas.drawLine(
          Offset(headCenter.dx + 10, headCenter.dy + headRadius + 25),
          Offset(headCenter.dx + headRadius - 4, headCenter.dy),
          armPaint,
        );
        canvas.drawLine(
          Offset(headCenter.dx - 10, headCenter.dy + headRadius + 25),
          Offset(headCenter.dx - headRadius + 4, headCenter.dy),
          armPaint,
        );
        streamTarget = Offset(headCenter.dx, headCenter.dy + 10);

      case WaterTargetArea.arms:
        // One hand rubbing the other forearm
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(tapX - 10, tapY + 35),
          armPaint,
        );
        streamTarget = Offset(tapX - 10, tapY + 35);

      case WaterTargetArea.head:
        // Hands placed atop head
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(headCenter.dx + 10, headCenter.dy - headRadius),
          armPaint,
        );

      case WaterTargetArea.ears:
      case WaterTargetArea.neck:
        // Hands at sides of head / neck
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(headCenter.dx + headRadius + 4, headCenter.dy + 5),
          armPaint,
        );

      case WaterTargetArea.feet:
        // Hand reaching down toward foot near basin
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(tapX - 12, floorY - 15),
          armPaint,
        );
        streamTarget = Offset(tapX - 12, floorY - 15);

      case WaterTargetArea.none:
        // Resting on lap
        canvas.drawLine(
          Offset(headCenter.dx + 15, headCenter.dy + headRadius + 20),
          Offset(headCenter.dx + 30, floorY - h * 0.20),
          armPaint,
        );
    }

    // Gentle Water Stream & Droplets Animation
    if (step.hasWaterAnimation) {
      final waterStreamPaint = Paint()
        ..color = waterColor
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Stream curving from tap to target
      final streamPath = Path()
        ..moveTo(tapX, tapY)
        ..quadraticBezierTo(
          tapX - 5,
          (tapY + streamTarget.dy) / 2,
          streamTarget.dx,
          streamTarget.dy,
        );
      canvas.drawPath(streamPath, waterStreamPaint);

      // Falling Droplets
      final dropPaint = Paint()..color = dropletColor;
      for (int i = 0; i < 4; i++) {
        final t = (animProgress + (i * 0.25)) % 1.0;
        final dropX = tapX + math.sin(t * math.pi) * (streamTarget.dx - tapX);
        final dropY = tapY + t * (streamTarget.dy - tapY);
        canvas.drawCircle(Offset(dropX, dropY), 2.5, dropPaint);
      }

      // Splash ripples at basin / target
      final rippleRadius = 4.0 + (animProgress * 10.0);
      final rippleAlpha = (1.0 - animProgress).clamp(0.0, 1.0);
      final ripplePaint = Paint()
        ..color = dropletColor.withValues(alpha: rippleAlpha * 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(streamTarget.dx, streamTarget.dy + 4),
          width: rippleRadius * 2,
          height: rippleRadius,
        ),
        ripplePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WuduFigurePainter oldDelegate) {
    return oldDelegate.animProgress != animProgress ||
        oldDelegate.step.id != step.id;
  }
}

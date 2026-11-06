import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Modest flat vector illustration widget for Taharat steps.
class TaharatStepIllustration extends StatelessWidget {
  const TaharatStepIllustration({
    required this.stepIndex,
    required this.type,
    this.size = 64,
    super.key,
  });

  /// Index of the step (0-indexed).
  final int stepIndex;

  /// Type of purification: 'wudu', 'ghusl', 'tayammum', 'masah', 'najasat'.
  final String type;

  /// Canvas size in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primaryEmerald.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(tokens.radii.md),
        border: Border.all(
          color: colors.primaryEmerald.withValues(alpha: 0.25),
        ),
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.65, size * 0.65),
          painter: _TaharatVectorPainter(
            stepIndex: stepIndex,
            type: type,
            primaryColor: colors.primaryEmerald,
            accentColor: colors.goldAccent,
            waterColor: const Color(0xFF38BDF8),
          ),
        ),
      ),
    );
  }
}

class _TaharatVectorPainter extends CustomPainter {
  const _TaharatVectorPainter({
    required this.stepIndex,
    required this.type,
    required this.primaryColor,
    required this.accentColor,
    required this.waterColor,
  });

  final int stepIndex;
  final String type;
  final Color primaryColor;
  final Color accentColor;
  final Color waterColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    if (type == 'wudu') {
      switch (stepIndex % 8) {
        case 0: // Hands washing to wrist
          paint.color = primaryColor;
          // Stylized hand contours
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(w * 0.2, h * 0.35, w * 0.6, h * 0.5),
              const Radius.circular(8),
            ),
            paint,
          );
          // Water drops
          fillPaint.color = waterColor;
          canvas.drawCircle(Offset(w * 0.35, h * 0.2), 3, fillPaint);
          canvas.drawCircle(Offset(w * 0.65, h * 0.22), 2.5, fillPaint);

        case 1: // Mouth rinsing (Madmadah)
          paint.color = primaryColor;
          canvas.drawArc(
            Rect.fromLTWH(w * 0.2, h * 0.3, w * 0.6, h * 0.4),
            0,
            3.14,
            false,
            paint,
          );
          fillPaint.color = waterColor;
          canvas.drawCircle(Offset(w * 0.5, h * 0.45), 4, fillPaint);

        case 2: // Nose cleansing (Istinshaq)
          paint.color = primaryColor;
          final path = Path()
            ..moveTo(w * 0.5, h * 0.2)
            ..lineTo(w * 0.4, h * 0.65)
            ..quadraticBezierTo(w * 0.5, h * 0.75, w * 0.6, h * 0.65)
            ..close();
          canvas.drawPath(path, paint);
          fillPaint.color = waterColor;
          canvas.drawCircle(Offset(w * 0.45, h * 0.55), 2.5, fillPaint);
          canvas.drawCircle(Offset(w * 0.55, h * 0.55), 2.5, fillPaint);

        case 3: // Face washing
          paint.color = primaryColor;
          canvas.drawOval(
            Rect.fromLTWH(w * 0.2, h * 0.15, w * 0.6, h * 0.7),
            paint,
          );
          fillPaint.color = waterColor;
          canvas.drawCircle(Offset(w * 0.3, h * 0.4), 3, fillPaint);
          canvas.drawCircle(Offset(w * 0.7, h * 0.4), 3, fillPaint);

        case 4: // Arms to elbows
          paint.color = primaryColor;
          canvas.drawLine(
            Offset(w * 0.3, h * 0.8),
            Offset(w * 0.3, h * 0.2),
            paint,
          );
          canvas.drawLine(
            Offset(w * 0.7, h * 0.8),
            Offset(w * 0.7, h * 0.2),
            paint,
          );
          paint.color = accentColor;
          canvas.drawLine(
            Offset(w * 0.2, h * 0.35),
            Offset(w * 0.8, h * 0.35),
            paint,
          );

        case 5: // Head Masah
          paint.color = primaryColor;
          canvas.drawArc(
            Rect.fromLTWH(w * 0.15, h * 0.2, w * 0.7, h * 0.6),
            3.14,
            3.14,
            false,
            paint,
          );
          paint.color = accentColor;
          canvas.drawLine(
            Offset(w * 0.25, h * 0.3),
            Offset(w * 0.75, h * 0.3),
            paint,
          );

        case 6: // Ears wiping
          paint.color = primaryColor;
          canvas.drawArc(
            Rect.fromLTWH(w * 0.15, h * 0.25, w * 0.3, h * 0.5),
            1.57,
            3.14,
            false,
            paint,
          );
          canvas.drawArc(
            Rect.fromLTWH(w * 0.55, h * 0.25, w * 0.3, h * 0.5),
            -1.57,
            3.14,
            false,
            paint,
          );

        case 7: // Feet washing
        default:
          paint.color = primaryColor;
          final footPath = Path()
            ..moveTo(w * 0.35, h * 0.2)
            ..lineTo(w * 0.35, h * 0.65)
            ..lineTo(w * 0.75, h * 0.65)
            ..quadraticBezierTo(w * 0.8, h * 0.8, w * 0.65, h * 0.8)
            ..lineTo(w * 0.2, h * 0.8)
            ..quadraticBezierTo(w * 0.15, h * 0.65, w * 0.2, h * 0.5)
            ..close();
          canvas.drawPath(footPath, paint);
          fillPaint.color = waterColor;
          canvas.drawCircle(Offset(w * 0.6, h * 0.5), 3, fillPaint);
      }
    } else if (type == 'tayammum') {
      // Clean earth / sand strike icon
      paint.color = accentColor;
      canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.35, paint);
      fillPaint.color = accentColor.withValues(alpha: 0.3);
      canvas.drawCircle(Offset(w * 0.4, h * 0.45), 3, fillPaint);
      canvas.drawCircle(Offset(w * 0.6, h * 0.45), 3, fillPaint);
      canvas.drawCircle(Offset(w * 0.5, h * 0.6), 3, fillPaint);
    } else {
      // Generic water purification symbol
      paint.color = primaryColor;
      final dropPath = Path()
        ..moveTo(w * 0.5, h * 0.15)
        ..quadraticBezierTo(w * 0.85, h * 0.55, w * 0.5, h * 0.85)
        ..quadraticBezierTo(w * 0.15, h * 0.55, w * 0.5, h * 0.15)
        ..close();
      canvas.drawPath(dropPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TaharatVectorPainter oldDelegate) {
    return oldDelegate.stepIndex != stepIndex || oldDelegate.type != type;
  }
}

// 2D Articulated Animated Figure CustomPainter for Namaj Simulator.
//
// Modest, respectful flat style with blank face, men's panjabi & tupi,
// women's modest abaya & hijab, prayer mat with Qibla indicator,
// 7-point sajda glow, raised index finger glow, and reduced-motion support.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/joint_pose.dart';
import 'package:musalli/features/simulator/presentation/figure/poses.dart';

/// Camera view mode for the figure.
enum FigureViewMode { side, front }

/// Widget that animates and renders the articulated figure between any two postures.
class SimulatorFigure extends StatefulWidget {
  const SimulatorFigure({
    required this.posture,
    required this.gender,
    this.postureMode = PostureMode.standing,
    this.viewMode = FigureViewMode.side,
    this.speed = 1.0,
    this.showHighlights = true,
    this.onViewModeToggled,
    super.key,
  });

  final Posture posture;
  final SimGender gender;
  final PostureMode postureMode;
  final FigureViewMode viewMode;
  final double speed;
  final bool showHighlights;
  final VoidCallback? onViewModeToggled;

  @override
  State<SimulatorFigure> createState() => _SimulatorFigureState();
}

class _SimulatorFigureState extends State<SimulatorFigure>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _curveAnimation;

  late JointPose _previousPose;
  late JointPose _targetPose;

  @override
  void initState() {
    super.initState();
    _targetPose = getJointPose(
      widget.posture,
      widget.gender,
      mode: widget.postureMode,
    );
    _previousPose = _targetPose;

    _animController = AnimationController(
      vsync: this,
      duration: _calculateDuration(),
    );
    _curveAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOutCubic,
    );
    _animController.value = 1.0;
  }

  @override
  void didUpdateWidget(SimulatorFigure oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.posture != widget.posture ||
        oldWidget.gender != widget.gender ||
        oldWidget.postureMode != widget.postureMode) {
      _previousPose = interpolatePose(
        _previousPose,
        _targetPose,
        _animController.value,
      );
      _targetPose = getJointPose(
        widget.posture,
        widget.gender,
        mode: widget.postureMode,
      );

      _animController.duration = _calculateDuration();
      _animController.forward(from: 0.0);
    }
  }

  Duration _calculateDuration() {
    // 550ms base scaled by playback speed (450ms–700ms)
    final ms = (550 / widget.speed).round().clamp(350, 750);
    return Duration(milliseconds: ms);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          final progress = reduceMotion ? 1.0 : _curveAnimation.value;
          final currentPose = interpolatePose(
            _previousPose,
            _targetPose,
            progress,
          );

          return CustomPaint(
            size: const Size(400, 320),
            painter: _FigurePainter(
              pose: currentPose,
              gender: widget.gender,
              postureMode: widget.postureMode,
              viewMode: widget.viewMode,
              posture: widget.posture,
              showHighlights: widget.showHighlights,
              colors: colors,
            ),
          );
        },
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  _FigurePainter({
    required this.pose,
    required this.gender,
    required this.postureMode,
    required this.viewMode,
    required this.posture,
    required this.showHighlights,
    required this.colors,
  });

  final JointPose pose;
  final SimGender gender;
  final PostureMode postureMode;
  final FigureViewMode viewMode;
  final Posture posture;
  final bool showHighlights;
  final MusalliColorTokens colors;

  static const double groundY = 270.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 400.0;
    final scaleY = size.height / 320.0;
    final scale = math.min(scaleX, scaleY);

    canvas.save();
    // Center in available canvas
    final dx = (size.width - 400.0 * scale) / 2;
    final dy = (size.height - 320.0 * scale) / 2;
    canvas.translate(dx, dy);
    canvas.scale(scale);

    // 1. Draw Prayer Mat (Jaanamaj) & Qibla Direction
    _drawPrayerMat(canvas);

    // 2. Draw Chair if in sittingChair mode
    if (postureMode == PostureMode.sittingChair) {
      _drawChair(canvas);
    }

    // 3. Draw Figure (Side or Front)
    if (viewMode == FigureViewMode.side) {
      _drawSideView(canvas);
    } else {
      _drawFrontView(canvas);
    }

    // 4. Draw Highlights (7 Sajda Points / Raised Index Finger)
    if (showHighlights) {
      _drawHighlights(canvas);
    }

    canvas.restore();
  }

  void _drawChair(Canvas canvas) {
    final chairWood = Paint()
      ..color = const Color(0xFF8D5B4C)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    final cushionPaint = Paint()
      ..color = colors.primaryEmerald.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    if (viewMode == FigureViewMode.side) {
      // Side view of the chair:
      // Seat cushion (X: 185 to 255, Y: 198 to 204)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTRB(182, 196, 252, 206),
          const Radius.circular(3),
        ),
        cushionPaint,
      );

      // Chair backrest (at the back of worshipper, X=248, from Y=125 down to Y=206)
      canvas.drawLine(const Offset(248, 120), const Offset(248, 204), chairWood);
      // Backrest slats
      canvas.drawLine(const Offset(248, 130), const Offset(242, 130), chairWood);
      canvas.drawLine(const Offset(248, 155), const Offset(242, 155), chairWood);

      // Chair legs to ground
      canvas.drawLine(const Offset(186, 206), const Offset(186, groundY), chairWood); // Front leg
      canvas.drawLine(const Offset(248, 206), const Offset(248, groundY), chairWood); // Rear leg
      // Stretcher between legs
      canvas.drawLine(const Offset(186, groundY - 25), const Offset(248, groundY - 25), chairWood..strokeWidth = 3.5);
    } else {
      // Front view of the chair
      const double cx = 200.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTRB(cx - 36, 196, cx + 36, 206),
          const Radius.circular(3),
        ),
        cushionPaint,
      );
      // Legs
      canvas.drawLine(const Offset(cx - 30, 206), const Offset(cx - 30, groundY), chairWood);
      canvas.drawLine(const Offset(cx + 30, 206), const Offset(cx + 30, groundY), chairWood);
      // Backrest frame
      canvas.drawLine(const Offset(cx - 32, 120), const Offset(cx - 32, 200), chairWood);
      canvas.drawLine(const Offset(cx + 32, 120), const Offset(cx + 32, 200), chairWood);
      canvas.drawLine(const Offset(cx - 32, 125), const Offset(cx + 32, 125), chairWood);
    }
  }

  void _drawPrayerMat(Canvas canvas) {
    final matPaint = Paint()
      ..color = colors.tealDeep.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = colors.primaryEmerald.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Mat trapezoid perspective
    final matPath = Path()
      ..moveTo(40, groundY + 12)
      ..lineTo(360, groundY + 12)
      ..lineTo(330, groundY - 22)
      ..lineTo(70, groundY - 22)
      ..close();

    canvas.drawPath(matPath, matPaint);
    canvas.drawPath(matPath, borderPaint);

    // Inner arch / mihrab pattern on the mat
    final archPath = Path()
      ..moveTo(90, groundY - 18)
      ..lineTo(90, groundY + 8)
      ..lineTo(140, groundY + 8)
      ..lineTo(140, groundY - 18)
      ..quadraticBezierTo(115, groundY - 26, 90, groundY - 18)
      ..close();

    final archPaint = Paint()
      ..color = colors.goldAccent.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(archPath, archPaint);

    // Subtle Qibla Marker Arrow (facing Left towards West/Qibla)
    final arrowPaint = Paint()
      ..color = colors.primaryEmerald.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    canvas.drawLine(
      const Offset(65, groundY + 28),
      const Offset(35, groundY + 28),
      arrowPaint,
    );
    canvas.drawLine(
      const Offset(43, groundY + 22),
      const Offset(35, groundY + 28),
      arrowPaint,
    );
    canvas.drawLine(
      const Offset(43, groundY + 34),
      const Offset(35, groundY + 28),
      arrowPaint,
    );

    final textSpan = TextSpan(
      text: 'কিবলা (Qibla)',
      style: TextStyle(
        color: colors.textSecondary.withValues(alpha: 0.75),
        fontSize: 10,
        fontWeight: FontWeight.w600,
        fontFamily: 'NotoSansBengali',
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, const Offset(74, groundY + 22));
  }

  void _drawSideView(Canvas canvas) {
    final hip = Offset(pose.hipX, pose.hipY);

    // Kinematic joint calculations (facing Left = negative X)
    // Angles in radians (0 = Up, -90 = Left towards Qibla, -180 = Down)
    final radThigh = _degToRad(pose.thighAngle);
    final radShin = _degToRad(pose.shinAngle);
    final radFoot = _degToRad(pose.footAngle);
    final radTorso = _degToRad(pose.torsoAngle);
    final radHead = _degToRad(pose.headAngle);
    final radUpperArm = _degToRad(pose.upperArmAngle);
    final radForearm = _degToRad(pose.forearmAngle);

    final knee = Offset(
      hip.dx + 55 * math.sin(radThigh),
      hip.dy - 55 * math.cos(radThigh),
    );
    final ankle = Offset(
      knee.dx + 55 * math.sin(radShin),
      knee.dy - 55 * math.cos(radShin),
    );
    final toe = Offset(
      ankle.dx + 30 * math.sin(radFoot),
      ankle.dy - 30 * math.cos(radFoot),
    );

    final shoulder = Offset(
      hip.dx + 68 * math.sin(radTorso),
      hip.dy - 68 * math.cos(radTorso),
    );
    final headCenter = Offset(
      shoulder.dx + 34 * math.sin(radHead),
      shoulder.dy - 34 * math.cos(radHead),
    );

    final elbow = Offset(
      shoulder.dx + 42 * math.sin(radUpperArm),
      shoulder.dy - 42 * math.cos(radUpperArm),
    );
    final hand = Offset(
      elbow.dx + 38 * math.sin(radForearm),
      elbow.dy - 38 * math.cos(radForearm),
    );

    // Paints
    final garmentPaint = Paint()
      ..color = colors.primaryEmerald
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = gender == SimGender.female ? 24.0 : 18.0;

    final limbPaint = Paint()
      ..color = colors.emeraldDark
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14.0;

    final skinPaint = Paint()
      ..color =
          const Color(0xFFF3C7A8) // Warm modest skin tone
      ..style = PaintingStyle.fill;

    // 1. Legs & Feet
    canvas.drawLine(hip, knee, limbPaint);
    canvas.drawLine(knee, ankle, limbPaint);

    final footPaint = Paint()
      ..color = const Color(0xFFF3C7A8)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    canvas.drawLine(ankle, toe, footPaint);

    // 2. Torso (Kurta / Abaya)
    canvas.drawLine(hip, shoulder, garmentPaint);

    // If female, draw loose abaya drape connecting hip to ground in sitting/sajda
    if (gender == SimGender.female) {
      final abayaPath = Path()
        ..moveTo(shoulder.dx - 8, shoulder.dy)
        ..lineTo(shoulder.dx + 8, shoulder.dy)
        ..lineTo(hip.dx + 16, hip.dy + 8)
        ..lineTo(knee.dx, knee.dy + 12)
        ..lineTo(hip.dx - 12, hip.dy + 6)
        ..close();

      final drapePaint = Paint()
        ..color = colors.emeraldDark.withValues(alpha: 0.9)
        ..style = PaintingStyle.fill;
      canvas.drawPath(abayaPath, drapePaint);
    }

    // 3. Head & Cap / Scarf
    canvas.drawCircle(headCenter, 16, skinPaint);

    if (gender == SimGender.male) {
      // White Prayer Cap (Tupi)
      final tupiPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      final tupiRect = Rect.fromCircle(
        center: Offset(headCenter.dx, headCenter.dy - 6),
        radius: 14,
      );
      canvas.drawArc(tupiRect, math.pi, math.pi, true, tupiPaint);
    } else {
      // Modest Hijab drape
      final hijabPaint = Paint()
        ..color = colors.emeraldDark
        ..style = PaintingStyle.fill;
      final hijabPath = Path()
        ..addArc(
          Rect.fromCircle(center: headCenter, radius: 19),
          -math.pi * 0.7,
          math.pi * 1.4,
        )
        ..lineTo(shoulder.dx - 4, shoulder.dy)
        ..lineTo(shoulder.dx + 12, shoulder.dy)
        ..close();
      canvas.drawPath(hijabPath, hijabPaint);
    }

    // 4. Arms & Hands
    final sleevePaint = Paint()
      ..color = colors.primaryEmerald
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = gender == SimGender.female ? 16.0 : 13.0;

    canvas.drawLine(shoulder, elbow, sleevePaint);
    canvas.drawLine(elbow, hand, sleevePaint);

    // Hand palm
    canvas.drawCircle(hand, 6.5, skinPaint);

    // Raised Index Finger in Tashahhud
    if (pose.fingerRaised) {
      final fingerPaint = Paint()
        ..color = const Color(0xFFF3C7A8)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 4.0;
      canvas.drawLine(hand, Offset(hand.dx - 12, hand.dy - 12), fingerPaint);
    }
  }

  void _drawFrontView(Canvas canvas) {
    const centerX = 200.0;
    final bodyY = 158.0 + pose.front.bodyDropY;

    final skinPaint = Paint()
      ..color = const Color(0xFFF3C7A8)
      ..style = PaintingStyle.fill;

    final garmentPaint = Paint()
      ..color = colors.primaryEmerald
      ..style = PaintingStyle.fill;

    // Torso in front view
    final torsoH = 70.0 * pose.front.torsoScaleY;
    final torsoRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, bodyY - torsoH / 2),
        width: gender == SimGender.female ? 64.0 : 56.0,
        height: torsoH,
      ),
      const Radius.circular(16),
    );
    canvas.drawRRect(torsoRect, garmentPaint);

    // Head
    final headY = bodyY - torsoH - 18;
    canvas.drawCircle(Offset(centerX, headY), 16, skinPaint);

    if (gender == SimGender.male) {
      final tupiPaint = Paint()..color = Colors.white;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, headY - 4), radius: 14),
        math.pi,
        math.pi,
        true,
        tupiPaint,
      );
    } else {
      final hijabPaint = Paint()..color = colors.emeraldDark;
      canvas.drawCircle(Offset(centerX, headY), 20, hijabPaint);
      canvas.drawCircle(Offset(centerX, headY + 2), 14, skinPaint);
    }

    // Arms based on handsMode
    final armPaint = Paint()
      ..color = colors.primaryEmerald
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14.0;

    final shoulderY = bodyY - torsoH + 6;
    final leftShoulder = Offset(centerX - 24, shoulderY);
    final rightShoulder = Offset(centerX + 24, shoulderY);

    switch (pose.front.handsMode) {
      case 'raised_ears':
      case 'raised_shoulders':
        final targetY = pose.front.handsMode == 'raised_ears'
            ? headY
            : headY + 14;
        canvas.drawLine(
          leftShoulder,
          Offset(centerX - 38, targetY + 12),
          armPaint,
        );
        canvas.drawLine(
          Offset(centerX - 38, targetY + 12),
          Offset(centerX - 34, targetY),
          armPaint,
        );
        canvas.drawCircle(Offset(centerX - 34, targetY), 6, skinPaint);

        canvas.drawLine(
          rightShoulder,
          Offset(centerX + 38, targetY + 12),
          armPaint,
        );
        canvas.drawLine(
          Offset(centerX + 38, targetY + 12),
          Offset(centerX + 34, targetY),
          armPaint,
        );
        canvas.drawCircle(Offset(centerX + 34, targetY), 6, skinPaint);

      case 'folded_navel':
      case 'folded_chest':
        final foldY = pose.front.handsMode == 'folded_navel'
            ? bodyY - 14
            : bodyY - 38;
        canvas.drawLine(leftShoulder, Offset(centerX - 18, foldY), armPaint);
        canvas.drawLine(rightShoulder, Offset(centerX + 18, foldY), armPaint);
        canvas.drawLine(
          Offset(centerX - 18, foldY),
          Offset(centerX + 18, foldY),
          armPaint,
        );
        canvas.drawCircle(Offset(centerX, foldY), 7, skinPaint);

      case 'knees':
        canvas.drawLine(
          leftShoulder,
          Offset(centerX - 22, bodyY + 12),
          armPaint,
        );
        canvas.drawLine(
          rightShoulder,
          Offset(centerX + 22, bodyY + 12),
          armPaint,
        );
        canvas.drawCircle(Offset(centerX - 22, bodyY + 12), 6, skinPaint);
        canvas.drawCircle(Offset(centerX + 22, bodyY + 12), 6, skinPaint);

      case 'ground_sajda':
        canvas.drawLine(
          leftShoulder,
          const Offset(centerX - 36, groundY - 6),
          armPaint,
        );
        canvas.drawLine(
          rightShoulder,
          const Offset(centerX + 36, groundY - 6),
          armPaint,
        );
        canvas.drawCircle(
          const Offset(centerX - 36, groundY - 6),
          7,
          skinPaint,
        );
        canvas.drawCircle(
          const Offset(centerX + 36, groundY - 6),
          7,
          skinPaint,
        );

      case 'thighs':
      default:
        canvas.drawLine(
          leftShoulder,
          Offset(centerX - 16, bodyY - 8),
          armPaint,
        );
        canvas.drawLine(
          rightShoulder,
          Offset(centerX + 16, bodyY - 8),
          armPaint,
        );
        canvas.drawCircle(Offset(centerX - 16, bodyY - 8), 6, skinPaint);
        canvas.drawCircle(Offset(centerX + 16, bodyY - 8), 6, skinPaint);
    }
  }

  void _drawHighlights(Canvas canvas) {
    if (posture == Posture.sajda) {
      // 7 Contact Points Glow in Sajda
      final glowPaint = Paint()
        ..color = colors.goldAccent.withValues(alpha: 0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final corePaint = Paint()
        ..color = colors.goldAccent
        ..style = PaintingStyle.fill;

      // Contact point locations
      final points = <Offset>[
        const Offset(132, groundY - 2), // 1. Forehead & Nose
        const Offset(164, groundY - 2), // 2. Hands (Palms)
        const Offset(256, groundY - 2), // 3. Knees
        const Offset(298, groundY - 2), // 4. Toes
      ];

      for (final pt in points) {
        canvas.drawCircle(pt, 10, glowPaint);
        canvas.drawCircle(pt, 4.5, corePaint);
      }
    } else if (posture == Posture.tashahhudFingerRaised && pose.fingerRaised) {
      // Raised Index Finger Glow in Tashahhud
      final fingerTip = Offset(pose.hipX - 28, pose.hipY + 8);
      final glowPaint = Paint()
        ..color = colors.goldAccent.withValues(alpha: 0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawCircle(fingerTip, 8, glowPaint);
      canvas.drawCircle(fingerTip, 4, Paint()..color = colors.goldAccent);
    }
  }

  double _degToRad(double deg) => deg * (math.pi / 180.0);

  @override
  bool shouldRepaint(covariant _FigurePainter oldDelegate) {
    return oldDelegate.pose != pose ||
        oldDelegate.viewMode != viewMode ||
        oldDelegate.postureMode != postureMode ||
        oldDelegate.showHighlights != showHighlights ||
        oldDelegate.posture != posture;
  }
}

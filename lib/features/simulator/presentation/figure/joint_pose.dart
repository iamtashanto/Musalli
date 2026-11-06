// Articulated 2D Joint Angle Definitions & Interpolation for the Figure.

import 'dart:ui' show lerpDouble;

/// Front view configuration parameters for the figure.
class FrontPoseParams {
  const FrontPoseParams({
    required this.bodyDropY,
    required this.torsoScaleY,
    required this.leftUpperArmAngle,
    required this.rightUpperArmAngle,
    required this.handsMode,
  });

  /// Vertical body drop from standing height (0 = standing, 68 = sitting, 95 = sajda).
  final double bodyDropY;

  /// Torso forward tilt compression factor (1 = upright, 0.35 = ruku/sajda foreshortened).
  final double torsoScaleY;

  /// Left and right upper arm angles in front view (degrees from straight down).
  final double leftUpperArmAngle;
  final double rightUpperArmAngle;

  /// Placement of hands in front view.
  final String handsMode;

  static const FrontPoseParams defaultFront = FrontPoseParams(
    bodyDropY: 0,
    torsoScaleY: 1,
    leftUpperArmAngle: 8,
    rightUpperArmAngle: -8,
    handsMode: 'sides',
  );
}

/// Joint angles and root coordinates for the articulated figure.
class JointPose {
  const JointPose({
    required this.hipX,
    required this.hipY,
    required this.torsoAngle,
    required this.headAngle,
    required this.upperArmAngle,
    required this.forearmAngle,
    required this.thighAngle,
    required this.shinAngle,
    required this.footAngle,
    required this.headTurn,
    required this.fingerRaised,
    required this.toesBent,
    required this.front,
  });

  /// Hip (root pelvis) X coordinate in 400x320 coordinate space.
  final double hipX;

  /// Hip (root pelvis) Y coordinate (ground mat is at Y=270).
  final double hipY;

  /// Torso angle from hip to shoulder (0 = upright, -90 = horizontal facing Qibla).
  final double torsoAngle;

  /// Head/neck angle from shoulder to head center.
  final double headAngle;

  /// Upper arm angle from shoulder to elbow.
  final double upperArmAngle;

  /// Forearm angle from elbow to hand.
  final double forearmAngle;

  /// Thigh angle from hip to knee.
  final double thighAngle;

  /// Shin angle from knee to ankle.
  final double shinAngle;

  /// Foot angle from ankle to toe (-90 = flat left, -180 = upright bent toes).
  final double footAngle;

  /// Head turn (-1 = looking right shoulder, 0 = forward, 1 = looking left shoulder).
  final double headTurn;

  /// Whether the right index (Shahadat) finger is raised.
  final bool fingerRaised;

  /// Whether toes are bent upright pressing into the prayer mat.
  final bool toesBent;

  /// Front view parameters.
  final FrontPoseParams front;
}

/// Interpolates angular difference along the shortest circular path in degrees.
double lerpAngle(double a, double b, double t) {
  var diff = (b - a) % 360;
  if (diff > 180) diff -= 360;
  if (diff < -180) diff += 360;
  return a + diff * t;
}

/// Smoothly interpolates between two [JointPose] configurations.
JointPose interpolatePose(JointPose a, JointPose b, double t) {
  final clampedT = t.clamp(0.0, 1.0);

  return JointPose(
    hipX: lerpDouble(a.hipX, b.hipX, clampedT) ?? a.hipX,
    hipY: lerpDouble(a.hipY, b.hipY, clampedT) ?? a.hipY,
    torsoAngle: lerpAngle(a.torsoAngle, b.torsoAngle, clampedT),
    headAngle: lerpAngle(a.headAngle, b.headAngle, clampedT),
    upperArmAngle: lerpAngle(a.upperArmAngle, b.upperArmAngle, clampedT),
    forearmAngle: lerpAngle(a.forearmAngle, b.forearmAngle, clampedT),
    thighAngle: lerpAngle(a.thighAngle, b.thighAngle, clampedT),
    shinAngle: lerpAngle(a.shinAngle, b.shinAngle, clampedT),
    footAngle: lerpAngle(a.footAngle, b.footAngle, clampedT),
    headTurn: lerpDouble(a.headTurn, b.headTurn, clampedT) ?? a.headTurn,
    fingerRaised: clampedT >= 0.5 ? b.fingerRaised : a.fingerRaised,
    toesBent: clampedT >= 0.5 ? b.toesBent : a.toesBent,
    front: FrontPoseParams(
      bodyDropY:
          lerpDouble(a.front.bodyDropY, b.front.bodyDropY, clampedT) ??
          a.front.bodyDropY,
      torsoScaleY:
          lerpDouble(a.front.torsoScaleY, b.front.torsoScaleY, clampedT) ??
          a.front.torsoScaleY,
      leftUpperArmAngle: lerpAngle(
        a.front.leftUpperArmAngle,
        b.front.leftUpperArmAngle,
        clampedT,
      ),
      rightUpperArmAngle: lerpAngle(
        a.front.rightUpperArmAngle,
        b.front.rightUpperArmAngle,
        clampedT,
      ),
      handsMode: clampedT >= 0.5 ? b.front.handsMode : a.front.handsMode,
    ),
  );
}

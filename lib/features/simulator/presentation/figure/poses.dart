// Pose Dictionary for all 16 Liturgical Postures for Male and Female.

import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/joint_pose.dart';

/// Shared poses between genders
const JointPose _kSharedStandingPose = JointPose(
  hipX: 230,
  hipY: 158,
  torsoAngle: 0,
  headAngle: -5,
  upperArmAngle: -178,
  forearmAngle: -172,
  thighAngle: -180,
  shinAngle: -180,
  footAngle: -90,
  headTurn: 0,
  fingerRaised: false,
  toesBent: false,
  front: FrontPoseParams.defaultFront,
);

const JointPose _kSharedQawmaPose = JointPose(
  hipX: 230,
  hipY: 158,
  torsoAngle: 0,
  headAngle: -6,
  upperArmAngle: -178,
  forearmAngle: -174,
  thighAngle: -180,
  shinAngle: -180,
  footAngle: -90,
  headTurn: 0,
  fingerRaised: false,
  toesBent: false,
  front: FrontPoseParams.defaultFront,
);

const JointPose _kSharedEidReleasedPose = JointPose(
  hipX: 230,
  hipY: 158,
  torsoAngle: 0,
  headAngle: -6,
  upperArmAngle: -178,
  forearmAngle: -172,
  thighAngle: -180,
  shinAngle: -180,
  footAngle: -90,
  headTurn: 0,
  fingerRaised: false,
  toesBent: false,
  front: FrontPoseParams.defaultFront,
);

/// Predefined joint angles and root coordinates for a male worshipper.
const Map<Posture, JointPose> kMalePoses = <Posture, JointPose>{
  Posture.standing: _kSharedStandingPose,

  Posture.takbirHandsRaised: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -125,
    forearmAngle: -28,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 55,
      rightUpperArmAngle: -55,
      handsMode: 'raised_ears',
    ),
  ),

  Posture.qiyamHandsFolded: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -12,
    upperArmAngle: -162,
    forearmAngle: -108,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 22,
      rightUpperArmAngle: -22,
      handsMode: 'folded_navel',
    ),
  ),

  Posture.ruku: JointPose(
    hipX: 252,
    hipY: 162,
    torsoAngle: -90, // Straight 90-degree horizontal back level with head
    headAngle: -90,
    upperArmAngle: -215,
    forearmAngle: -232,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 36,
      torsoScaleY: 0.42,
      leftUpperArmAngle: 15,
      rightUpperArmAngle: -15,
      handsMode: 'knees',
    ),
  ),

  Posture.qawma: _kSharedQawmaPose,

  Posture.sajda: JointPose(
    hipX: 236,
    hipY: 210, // Elevated hip: belly separated from thighs
    torsoAngle: -114,
    headAngle: -120, // Forehead & nose touch ground
    upperArmAngle: -188, // Elbows raised off mat
    forearmAngle: -116, // Palms flat on mat
    thighAngle: -202,
    shinAngle: -270,
    footAngle: -180, // Upright foot with toes bent facing Qibla
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 94,
      torsoScaleY: 0.35,
      leftUpperArmAngle: 38,
      rightUpperArmAngle: -38,
      handsMode: 'ground_sajda',
    ),
  ),

  Posture.jalsa: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.qada: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.tashahhudFingerRaised: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -116,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: true,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.salamRight: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: 0,
    headAngle: -6,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: -1, // Head turned right
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.salamLeft: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: 0,
    headAngle: -6,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 1, // Head turned left
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.qunutTakbir: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -125,
    forearmAngle: -28,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 55,
      rightUpperArmAngle: -55,
      handsMode: 'raised_ears',
    ),
  ),

  Posture.eidTakbirRaised: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -125,
    forearmAngle: -28,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 55,
      rightUpperArmAngle: -55,
      handsMode: 'raised_ears',
    ),
  ),

  Posture.eidTakbirReleased: _kSharedEidReleasedPose,

  Posture.janazaTakbir: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -162,
    forearmAngle: -108,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 22,
      rightUpperArmAngle: -22,
      handsMode: 'folded_navel',
    ),
  ),

  Posture.munajat: JointPose(
    hipX: 256,
    hipY: 228,
    torsoAngle: -4,
    headAngle: -18,
    upperArmAngle: -152,
    forearmAngle: -58,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 28,
      rightUpperArmAngle: -28,
      handsMode: 'munajat',
    ),
  ),
};

/// Predefined joint angles and root coordinates for a female worshipper.
const Map<Posture, JointPose> kFemalePoses = <Posture, JointPose>{
  Posture.standing: _kSharedStandingPose,

  Posture.takbirHandsRaised: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -145, // Raised to shoulders
    forearmAngle: -44,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 36,
      rightUpperArmAngle: -36,
      handsMode: 'raised_shoulders',
    ),
  ),

  Posture.qiyamHandsFolded: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -12,
    upperArmAngle: -154,
    forearmAngle: -68, // Folded on chest
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 26,
      rightUpperArmAngle: -26,
      handsMode: 'folded_chest',
    ),
  ),

  Posture.ruku: JointPose(
    hipX: 246,
    hipY: 164,
    torsoAngle: -64, // Slight bow
    headAngle: -68,
    upperArmAngle: -196,
    forearmAngle: -222,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 24,
      torsoScaleY: 0.62,
      leftUpperArmAngle: 10,
      rightUpperArmAngle: -10,
      handsMode: 'knees',
    ),
  ),

  Posture.qawma: _kSharedQawmaPose,

  Posture.sajda: JointPose(
    hipX: 242,
    hipY: 232, // Lower hip: belly rests near thighs
    torsoAngle: -102,
    headAngle: -112,
    upperArmAngle: -214, // Elbows resting on mat
    forearmAngle: -92, // Forearms flat on mat
    thighAngle: -195,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 98,
      torsoScaleY: 0.32,
      leftUpperArmAngle: 18,
      rightUpperArmAngle: -18,
      handsMode: 'ground_sajda',
    ),
  ),

  Posture.jalsa: JointPose(
    hipX: 256,
    hipY: 234, // Sits in tawarruk
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.qada: JointPose(
    hipX: 256,
    hipY: 234,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.tashahhudFingerRaised: JointPose(
    hipX: 256,
    hipY: 234,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -166,
    forearmAngle: -116,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: true,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.salamRight: JointPose(
    hipX: 256,
    hipY: 234,
    torsoAngle: 0,
    headAngle: -6,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: -1,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.salamLeft: JointPose(
    hipX: 256,
    hipY: 234,
    torsoAngle: 0,
    headAngle: -6,
    upperArmAngle: -166,
    forearmAngle: -122,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 1,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 16,
      rightUpperArmAngle: -16,
      handsMode: 'thighs',
    ),
  ),

  Posture.qunutTakbir: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -145,
    forearmAngle: -44,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 36,
      rightUpperArmAngle: -36,
      handsMode: 'raised_shoulders',
    ),
  ),

  Posture.eidTakbirRaised: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -4,
    upperArmAngle: -145,
    forearmAngle: -44,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 36,
      rightUpperArmAngle: -36,
      handsMode: 'raised_shoulders',
    ),
  ),

  Posture.eidTakbirReleased: _kSharedEidReleasedPose,

  Posture.janazaTakbir: JointPose(
    hipX: 230,
    hipY: 158,
    torsoAngle: 0,
    headAngle: -10,
    upperArmAngle: -154,
    forearmAngle: -68,
    thighAngle: -180,
    shinAngle: -180,
    footAngle: -90,
    headTurn: 0,
    fingerRaised: false,
    toesBent: false,
    front: FrontPoseParams(
      bodyDropY: 0,
      torsoScaleY: 1,
      leftUpperArmAngle: 26,
      rightUpperArmAngle: -26,
      handsMode: 'folded_chest',
    ),
  ),

  Posture.munajat: JointPose(
    hipX: 256,
    hipY: 234,
    torsoAngle: -4,
    headAngle: -18,
    upperArmAngle: -152,
    forearmAngle: -58,
    thighAngle: -128,
    shinAngle: -270,
    footAngle: -180,
    headTurn: 0,
    fingerRaised: false,
    toesBent: true,
    front: FrontPoseParams(
      bodyDropY: 68,
      torsoScaleY: 0.95,
      leftUpperArmAngle: 28,
      rightUpperArmAngle: -28,
      handsMode: 'munajat',
    ),
  ),
};

/// Poses when sitting on the floor throughout the entire prayer.
/// (Used for individuals who cannot stand due to weakness or medical conditions).
JointPose _buildSittingFloorPose(JointPose basePose, Posture posture, SimGender gender) {
  // If base posture was standing/qiyam/ruku, adapt it to sitting on floor
  switch (posture) {
    case Posture.standing:
    case Posture.qawma:
      return basePose.copyWith(
        hipX: 256,
        hipY: 228,
        torsoAngle: 0,
        headAngle: -10,
        upperArmAngle: -166,
        forearmAngle: -122,
        thighAngle: -128,
        shinAngle: -270,
        footAngle: -180,
        front: const FrontPoseParams(
          bodyDropY: 68,
          torsoScaleY: 1.0,
          leftUpperArmAngle: 12,
          rightUpperArmAngle: -12,
          handsMode: 'thighs',
        ),
      );

    case Posture.takbirHandsRaised:
    case Posture.qunutTakbir:
    case Posture.eidTakbirRaised:
      return basePose.copyWith(
        hipX: 256,
        hipY: 228,
        torsoAngle: 0,
        headAngle: -10,
        thighAngle: -128,
        shinAngle: -270,
        footAngle: -180,
        front: FrontPoseParams(
          bodyDropY: 68,
          torsoScaleY: 1.0,
          leftUpperArmAngle: gender == SimGender.female ? 36 : 42,
          rightUpperArmAngle: gender == SimGender.female ? -36 : -42,
          handsMode: gender == SimGender.female ? 'raised_shoulders' : 'raised_ears',
        ),
      );

    case Posture.qiyamHandsFolded:
    case Posture.janazaTakbir:
      return basePose.copyWith(
        hipX: 256,
        hipY: 228,
        torsoAngle: 0,
        headAngle: -10,
        thighAngle: -128,
        shinAngle: -270,
        footAngle: -180,
        front: FrontPoseParams(
          bodyDropY: 68,
          torsoScaleY: 1.0,
          leftUpperArmAngle: 24,
          rightUpperArmAngle: -24,
          handsMode: gender == SimGender.female ? 'folded_chest' : 'folded_navel',
        ),
      );

    case Posture.ruku:
      // Ruku gesture while sitting: bow head and upper torso forward (approx 35-40 deg)
      return basePose.copyWith(
        hipX: 256,
        hipY: 228,
        torsoAngle: -40,
        headAngle: -45,
        upperArmAngle: -165,
        forearmAngle: -135,
        thighAngle: -128,
        shinAngle: -270,
        footAngle: -180,
        front: const FrontPoseParams(
          bodyDropY: 68,
          torsoScaleY: 0.72,
          leftUpperArmAngle: 18,
          rightUpperArmAngle: -18,
          handsMode: 'knees',
        ),
      );

    case Posture.sajda:
    case Posture.jalsa:
    case Posture.qada:
    case Posture.tashahhudFingerRaised:
    case Posture.salamRight:
    case Posture.salamLeft:
    case Posture.eidTakbirReleased:
    case Posture.munajat:
      // Sajda, jalsa, tashahhud, salam, etc. are already natural sitting postures
      return basePose;
  }
}

/// Poses when sitting on a chair throughout the entire prayer.
/// (Chair height puts hip at Y=196, thighs horizontal -90, shins straight down -180, feet flat on mat).
JointPose _buildChairPose(JointPose basePose, Posture posture, SimGender gender) {
  const double chairHipX = 236.0;
  const double chairHipY = 194.0;
  const double chairThighAngle = -90.0;
  const double chairShinAngle = -180.0;
  const double chairFootAngle = -90.0;

  switch (posture) {
    case Posture.standing:
    case Posture.qawma:
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        torsoAngle: 0,
        headAngle: -8,
        upperArmAngle: -168,
        forearmAngle: -120,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: const FrontPoseParams(
          bodyDropY: 36,
          torsoScaleY: 1.0,
          leftUpperArmAngle: 12,
          rightUpperArmAngle: -12,
          handsMode: 'thighs',
        ),
      );

    case Posture.takbirHandsRaised:
    case Posture.qunutTakbir:
    case Posture.eidTakbirRaised:
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        torsoAngle: 0,
        headAngle: -8,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: FrontPoseParams(
          bodyDropY: 36,
          torsoScaleY: 1.0,
          leftUpperArmAngle: gender == SimGender.female ? 36 : 42,
          rightUpperArmAngle: gender == SimGender.female ? -36 : -42,
          handsMode: gender == SimGender.female ? 'raised_shoulders' : 'raised_ears',
        ),
      );

    case Posture.qiyamHandsFolded:
    case Posture.janazaTakbir:
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        torsoAngle: 0,
        headAngle: -8,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: FrontPoseParams(
          bodyDropY: 36,
          torsoScaleY: 1.0,
          leftUpperArmAngle: 24,
          rightUpperArmAngle: -24,
          handsMode: gender == SimGender.female ? 'folded_chest' : 'folded_navel',
        ),
      );

    case Posture.ruku:
      // Chair Ruku: Slight bow (around -32 degrees torso tilt), hands on knees
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        torsoAngle: -32,
        headAngle: -40,
        upperArmAngle: -160,
        forearmAngle: -125,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: const FrontPoseParams(
          bodyDropY: 36,
          torsoScaleY: 0.78,
          leftUpperArmAngle: 16,
          rightUpperArmAngle: -16,
          handsMode: 'knees',
        ),
      );

    case Posture.sajda:
      // Chair Sajda: Deeper bow than ruku (around -58 degrees torso tilt)
      // Per Hanafi fiqh: sajda gesture on chair must be visibly lower than ruku gesture
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        torsoAngle: -58,
        headAngle: -70,
        upperArmAngle: -150,
        forearmAngle: -115,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: const FrontPoseParams(
          bodyDropY: 36,
          torsoScaleY: 0.55,
          leftUpperArmAngle: 24,
          rightUpperArmAngle: -24,
          handsMode: 'knees',
        ),
      );

    case Posture.jalsa:
    case Posture.qada:
    case Posture.tashahhudFingerRaised:
    case Posture.salamRight:
    case Posture.salamLeft:
    case Posture.eidTakbirReleased:
    case Posture.munajat:
      return basePose.copyWith(
        hipX: chairHipX,
        hipY: chairHipY,
        thighAngle: chairThighAngle,
        shinAngle: chairShinAngle,
        footAngle: chairFootAngle,
        front: basePose.front,
      );
  }
}

/// Resolves the canonical pose for a given posture, gender, and posture execution mode.
JointPose getJointPose(
  Posture posture,
  SimGender gender, {
  PostureMode mode = PostureMode.standing,
}) {
  final basePose = gender == SimGender.female
      ? (kFemalePoses[posture] ?? kMalePoses[posture]!)
      : kMalePoses[posture]!;

  switch (mode) {
    case PostureMode.standing:
      return basePose;
    case PostureMode.sittingFloor:
      return _buildSittingFloorPose(basePose, posture, gender);
    case PostureMode.sittingChair:
      return _buildChairPose(basePose, posture, gender);
  }
}

// Namaj Simulator Domain Types (Pure Dart - No Flutter imports).

/// All 16 liturgical postures recognized by the Namaj Simulator figure and engine.
enum Posture {
  standing,
  takbirHandsRaised,
  qiyamHandsFolded,
  ruku,
  qawma,
  sajda,
  jalsa,
  qada,
  tashahhudFingerRaised,
  salamRight,
  salamLeft,
  qunutTakbir,
  eidTakbirRaised,
  eidTakbirReleased,
  janazaTakbir,
  munajat,
}

/// Biological gender for posture differences in Hanafi fiqh.
enum SimGender { male, female }

/// Congregational role in prayer.
enum SimRole { alone, imam, muqtadi }

/// Gender-specific posture parameters according to authentic Hanafi rulings.
class GenderVariantFlags {
  const GenderVariantFlags({
    required this.handRaiseHeight,
    required this.handFoldPosition,
    required this.rukuBackAngle,
    required this.sajdaPosture,
    required this.sittingPosture,
    required this.feetGapInStanding,
  });

  factory GenderVariantFlags.forGender(SimGender gender) {
    return gender == SimGender.female ? female : male;
  }

  /// Male raises to earlobes; female raises to shoulders/chest.
  final String handRaiseHeight;

  /// Male folds below navel; female folds on chest.
  final String handFoldPosition;

  /// Male bows straight 90 degrees; female bows slightly (hands just reaching knees).
  final String rukuBackAngle;

  /// Male: open elbows, belly raised above thighs; female: compact, belly on thighs, forearms flat.
  final String sajdaPosture;

  /// Male sits on left foot with right foot upright (Iftirash); female sits on left hip with feet to right (Tawarruk).
  final String sittingPosture;

  /// Male stands with 4 fingers gap between feet; female stands with feet joined.
  final String feetGapInStanding;

  /// Standard variants for a male worshipper.
  static const GenderVariantFlags male = GenderVariantFlags(
    handRaiseHeight: 'earlobes',
    handFoldPosition: 'below_navel',
    rukuBackAngle: 'flat_90',
    sajdaPosture: 'open_elbows_raised',
    sittingPosture: 'left_foot_under_right_upright',
    feetGapInStanding: 'four_fingers',
  );

  /// Standard variants for a female worshipper.
  static const GenderVariantFlags female = GenderVariantFlags(
    handRaiseHeight: 'shoulders',
    handFoldPosition: 'chest',
    rukuBackAngle: 'slight_bow',
    sajdaPosture: 'compact_elbows_tucked',
    sittingPosture: 'both_feet_right_side_tawarruk',
    feetGapInStanding: 'joined',
  );
}

/// Single step within a generated prayer timeline.
class SimStep {
  const SimStep({
    required this.id,
    required this.rakat,
    required this.posture,
    required this.recitationIds,
    required this.repeat,
    required this.spokenTakbir,
    required this.isLoud,
    required this.durationHintMs,
    required this.titleBn,
    required this.instructionBn,
    this.instructionEn,
    required this.genderVariants,
    this.tasbihCount,
  });

  final String id;
  final int? rakat;
  final Posture posture;
  final List<String> recitationIds;
  final int repeat;
  final String? spokenTakbir;
  final bool isLoud;
  final int durationHintMs;
  final String titleBn;
  final String instructionBn;
  final String? instructionEn;
  final GenderVariantFlags genderVariants;
  final int? tasbihCount;

  Duration get durationHint => Duration(milliseconds: durationHintMs);

  SimStep copyWith({
    String? id,
    int? rakat,
    Posture? posture,
    List<String>? recitationIds,
    int? repeat,
    String? spokenTakbir,
    bool? isLoud,
    int? durationHintMs,
    String? titleBn,
    String? instructionBn,
    String? instructionEn,
    GenderVariantFlags? genderVariants,
    int? tasbihCount,
  }) {
    return SimStep(
      id: id ?? this.id,
      rakat: rakat ?? this.rakat,
      posture: posture ?? this.posture,
      recitationIds: recitationIds ?? this.recitationIds,
      repeat: repeat ?? this.repeat,
      spokenTakbir: spokenTakbir ?? this.spokenTakbir,
      isLoud: isLoud ?? this.isLoud,
      durationHintMs: durationHintMs ?? this.durationHintMs,
      titleBn: titleBn ?? this.titleBn,
      instructionBn: instructionBn ?? this.instructionBn,
      instructionEn: instructionEn ?? this.instructionEn,
      genderVariants: genderVariants ?? this.genderVariants,
      tasbihCount: tasbihCount ?? this.tasbihCount,
    );
  }
}

/// Metadata summarizing a simulated prayer timeline.
class TimelineMetadata {
  const TimelineMetadata({
    required this.totalRakats,
    this.prayerSlug,
    this.unitLabel,
    required this.gender,
    required this.role,
    required this.totalSteps,
    required this.totalTasbihCount,
    required this.estimatedDurationMs,
    required this.isJanaza,
  });

  final int totalRakats;
  final String? prayerSlug;
  final String? unitLabel;
  final SimGender gender;
  final SimRole role;
  final int totalSteps;
  final int totalTasbihCount;
  final int estimatedDurationMs;
  final bool isJanaza;

  Duration get estimatedDuration => Duration(milliseconds: estimatedDurationMs);
}

/// Deterministic, ordered timeline of all steps in a salah.
class Timeline {
  const Timeline({required this.steps, required this.metadata});

  final List<SimStep> steps;
  final TimelineMetadata metadata;

  int get length => steps.length;
  bool get isEmpty => steps.isEmpty;
  bool get isNotEmpty => steps.isNotEmpty;
  SimStep operator [](int index) => steps[index];
}

/// Injected interface to query surahs the user has memorized (from Hifz feature).
abstract class MemorizedSurahsProvider {
  List<int> getMemorizedSurahNumbers();
}

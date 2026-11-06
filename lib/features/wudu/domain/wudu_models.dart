// Wudu Simulator Domain Models (Pure Dart - No Flutter imports).

/// Canonical step identifiers for complete Hanafi Wudu.
enum WuduStepId {
  niyyahAndBismillah,
  washHands,
  rinseMouth,
  sniffWaterNose,
  washFace,
  washRightArm,
  washLeftArm,
  masahHead,
  masahEars,
  masahNeck,
  washRightFoot,
  washLeftFoot,
  duaAfterWudu,
}

/// Fiqh classification of wudu actions.
enum WuduRuling {
  fard('ফরজ', 'অজুর ৪টি মূল ফরজ অঙ্গের একটি; বাদ পড়লে অজু হবে না'),
  sunnat('সুন্নত', 'রাসূলুল্লাহ (সা.)-এর নিয়মিত আমল; সওয়াব বৃদ্ধি করে'),
  mustahab('মুস্তাহাব', 'উত্তম ও প্রশংসনীয় আমল');

  WuduRuling(this.labelBn, this.detailBn);
  final String labelBn;
  final String detailBn;
}

/// Target area where water animation focuses.
enum WaterTargetArea {
  hands,
  mouth,
  nose,
  face,
  arms,
  head,
  ears,
  neck,
  feet,
  none,
}

/// Single step of the Wudu procedure.
class WuduStep {
  const WuduStep({
    required this.id,
    required this.order,
    required this.titleBn,
    required this.subtitleBn,
    required this.instructionBn,
    required this.ruling,
    required this.repeatCount,
    required this.waterTargetArea,
    this.arabicDua,
    this.pronunciationBn,
    this.meaningBn,
  });

  final WuduStepId id;
  final int order;
  final String titleBn;
  final String subtitleBn;
  final String instructionBn;
  final WuduRuling ruling;
  final int repeatCount;
  final WaterTargetArea waterTargetArea;
  final String? arabicDua;
  final String? pronunciationBn;
  final String? meaningBn;

  bool get isFard => ruling == WuduRuling.fard;
  bool get hasWaterAnimation => waterTargetArea != WaterTargetArea.none;
}

/// Configuration options for wudu simulation.
class WuduConfig {
  const WuduConfig({this.includeNeckMasah = true, this.includeDuas = true});

  final bool includeNeckMasah;
  final bool includeDuas;

  static const WuduConfig standard = WuduConfig();
}

/// Ordered sequence of all wudu steps.
class WuduTimeline {
  const WuduTimeline({
    required this.steps,
    required this.fardCount,
    required this.sunnatCount,
    required this.mustahabCount,
  });

  final List<WuduStep> steps;
  final int fardCount;
  final int sunnatCount;
  final int mustahabCount;

  int get length => steps.length;
  WuduStep operator [](int index) => steps[index];
}

/// Question for Wudu sequencing and fard practice mode.
class WuduPracticeQuestion {
  const WuduPracticeQuestion({
    required this.id,
    required this.promptBn,
    required this.options,
    required this.correctIndex,
    required this.explanationBn,
    required this.isFardQuestion,
  });

  final String id;
  final String promptBn;
  final List<String> options;
  final int correctIndex;
  final String explanationBn;
  final bool isFardQuestion;
}

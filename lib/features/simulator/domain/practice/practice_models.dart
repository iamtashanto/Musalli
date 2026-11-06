// Practice / Quiz Mode Domain Models (Pure Dart - No Flutter imports).

import 'package:musalli/features/simulator/domain/types.dart';

/// Practice difficulty levels.
enum PracticeDifficulty {
  learner('শিক্ষার্থী', 'ইঙ্গিত এবং সাহায্য প্রদর্শন করা হয়'),
  standard('সাধারণ', 'মানসম্মত অনুশীলন'),
  expert('দক্ষ', 'সময়সীমা নির্ধারিত, কোন ইঙ্গিত নেই');

  PracticeDifficulty(this.labelBn, this.descriptionBn);
  final String labelBn;
  final String descriptionBn;
}

/// Category of quiz questions during simulation.
enum PracticeQuestionType {
  nextPosture('পরবর্তী ভঙ্গি', 'ভঙ্গি নির্বাচন'),
  whatRecitation('কেরাত ও তাসবীহ', 'সঠিক দোয়া/সূরা'),
  howManyTimes('গণনা', 'কতবার পড়বেন'),
  surahMatching('সূরা মেলানো', 'সূরা ফাতেহার পর সূরা'),
  sitOrStand('বসা নাকি দাঁড়ানো', 'বসা বনাম দাঁড়ানো');

  PracticeQuestionType(this.labelBn, this.shortBn);
  final String labelBn;
  final String shortBn;
}

/// Single choice option in a practice question.
class PracticeOption {
  const PracticeOption({
    required this.id,
    required this.labelBn,
    this.arabicText,
    this.posture,
    required this.isCorrect,
  });

  final String id;
  final String labelBn;
  final String? arabicText;
  final Posture? posture;
  final bool isCorrect;
}

/// Impact of mistake according to Hanafi Masail.
enum MistakeFiqhImpact {
  invalidatesSalah(
    'নামাজ নষ্ট হয়ে যাবে',
    'এটি নামাজের রুকন বা ফরজ। এটি ছুটে গেলে নামাজ পুনরায় পড়তে হবে।',
  ),
  requiresSajdaSahu(
    'সেজদায়ে সাহু ওয়াজিব',
    'এটি নামাজের ওয়াজিব। ভুলে ছুটে গেলে শেষ বৈঠকে সেজদায়ে সাহু করতে হবে।',
  ),
  sunnahOrMustahab(
    'নামাজ আদায় হবে তবে সওয়াব কমবে',
    'এটি সুন্নাত বা মুস্তাহাব। নামাজ ভঙ্গ হবে না এবং সেজদায়ে সাহু লাগবে না।',
  );

  MistakeFiqhImpact(this.titleBn, this.rulingDetailBn);
  final String titleBn;
  final String rulingDetailBn;
}

/// Generated practice question paused before a step.
class PracticeQuestion {
  const PracticeQuestion({
    required this.id,
    required this.stepIndex,
    required this.type,
    required this.promptBn,
    required this.options,
    required this.correctExplanationBn,
    required this.fiqhImpact,
    this.hintBn,
    this.ruleSlug,
  });

  final String id;
  final int stepIndex;
  final PracticeQuestionType type;
  final String promptBn;
  final List<PracticeOption> options;
  final String correctExplanationBn;
  final MistakeFiqhImpact fiqhImpact;
  final String? hintBn;
  final String? ruleSlug;
}

/// Weak area identified during practice session.
class WeakAreaItem {
  const WeakAreaItem({
    required this.questionType,
    required this.topicBn,
    required this.adviceBn,
    this.ruleSlug,
  });

  final PracticeQuestionType questionType;
  final String topicBn;
  final String adviceBn;
  final String? ruleSlug;
}

/// Complete practice session result.
class PracticeResult {
  const PracticeResult({
    required this.prayerSlug,
    required this.prayerNameBn,
    required this.difficulty,
    required this.totalQuestions,
    required this.correctCount,
    required this.wrongCount,
    required this.timeTakenSeconds,
    required this.weakAreas,
    this.unlockedBadge,
  });

  final String prayerSlug;
  final String prayerNameBn;
  final PracticeDifficulty difficulty;
  final int totalQuestions;
  final int correctCount;
  final int wrongCount;
  final int timeTakenSeconds;
  final List<WeakAreaItem> weakAreas;
  final String? unlockedBadge;

  int get scorePercent =>
      totalQuestions > 0 ? ((correctCount / totalQuestions) * 100).round() : 0;
  bool get isPassed => scorePercent >= 70;
  bool get isPerfect => scorePercent == 100;
}

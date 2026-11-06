enum HifzHideMode {
  none('স্বাভাবিক দৃশ্যমান'),
  hideEveryOther('প্রতি দ্বিতীয় শব্দ লুকানো'),
  firstLettersOnly('শুধু প্রথম অক্ষর'),
  fullyHidden('সম্পূর্ণ লুকানো (আত্মপরীক্ষা)');

  HifzHideMode(this.labelBn);
  final String labelBn;
}

class HifzItemRecord {

  factory HifzItemRecord.fromJson(Map<String, dynamic> json) {
    return HifzItemRecord(
      surahNumber: (json['surah'] as num).toInt(),
      intervalDays: (json['interval'] as num).toInt(),
      lastReviewedAt: DateTime.parse(json['lastReviewed'] as String),
      nextReviewDue: DateTime.parse(json['nextDue'] as String),
      repetitionsCount: (json['reps'] as num).toInt(),
    );
  }
  const HifzItemRecord({
    required this.surahNumber,
    required this.intervalDays,
    required this.lastReviewedAt,
    required this.nextReviewDue,
    required this.repetitionsCount,
  });

  final int surahNumber;
  final int intervalDays;
  final DateTime lastReviewedAt;
  final DateTime nextReviewDue;
  final int repetitionsCount;

  bool get isDue => DateTime.now().isAfter(nextReviewDue);

  Map<String, dynamic> toJson() => {
    'surah': surahNumber,
    'interval': intervalDays,
    'lastReviewed': lastReviewedAt.toIso8601String(),
    'nextDue': nextReviewDue.toIso8601String(),
    'reps': repetitionsCount,
  };

  static HifzItemRecord createNew(int surahNumber) {
    final now = DateTime.now();
    return HifzItemRecord(
      surahNumber: surahNumber,
      intervalDays: 1,
      lastReviewedAt: now,
      nextReviewDue: now.add(const Duration(days: 1)),
      repetitionsCount: 0,
    );
  }

  HifzItemRecord markReviewed({required bool success}) {
    final now = DateTime.now();
    if (!success) {
      return HifzItemRecord(
        surahNumber: surahNumber,
        intervalDays: 1,
        lastReviewedAt: now,
        nextReviewDue: now.add(const Duration(days: 1)),
        repetitionsCount: repetitionsCount + 1,
      );
    }

    final nextInterval = switch (intervalDays) {
      1 => 3,
      3 => 7,
      7 => 14,
      14 => 30,
      _ => 60,
    };

    return HifzItemRecord(
      surahNumber: surahNumber,
      intervalDays: nextInterval,
      lastReviewedAt: now,
      nextReviewDue: now.add(Duration(days: nextInterval)),
      repetitionsCount: repetitionsCount + 1,
    );
  }
}


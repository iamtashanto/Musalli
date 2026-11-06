// Gamified Kids Mode Domain Models (Pure Dart - No Flutter imports).

/// The 6 progressive learning path lesson stages for children.
enum KidsLessonId {
  wudu('wudu', 'সহজে অজু শেখা', '💧'),
  takbir('takbir', 'তাকবীরে তাহরীমা', '🤲'),
  fatiha('fatiha', 'সূরা আল-ফাতিহা', '📖'),
  shortSurahs('shortSurahs', 'ছোট সূরা শেখা', '✨'),
  twoRakat('twoRakat', '২ রাকাত নামাজ (ফজর)', '🕌'),
  fourRakat('fourRakat', '৪ রাকাত নামাজ (যোহর)', '🌟');

  KidsLessonId(this.key, this.defaultTitleBn, this.emoji);
  final String key;
  final String defaultTitleBn;
  final String emoji;
}

/// A single lesson node on the kids learning path.
class KidsLesson {
  const KidsLesson({
    required this.id,
    required this.order,
    required this.titleBn,
    required this.subtitleBn,
    required this.iconEmoji,
    required this.targetRoute,
    required this.stickerName,
    required this.stickerEmoji,
    required this.descriptionBn,
  });

  final KidsLessonId id;
  final int order;
  final String titleBn;
  final String subtitleBn;
  final String iconEmoji;
  final String targetRoute;
  final String stickerName;
  final String stickerEmoji;
  final String descriptionBn;
}

/// Child's persistent learning progress and sticker collection.
class KidsProgress {
  const KidsProgress({
    required this.completedLessonIds,
    required this.lessonStars,
    required this.collectedStickers,
  });

  final Set<String> completedLessonIds;
  final Map<String, int> lessonStars;
  final List<String> collectedStickers;

  int get totalStars => lessonStars.values.fold(0, (acc, s) => acc + s);
  bool isCompleted(KidsLessonId id) => completedLessonIds.contains(id.key);
  int getStars(KidsLessonId id) => lessonStars[id.key] ?? 0;

  static const KidsProgress initial = KidsProgress(
    completedLessonIds: <String>{},
    lessonStars: <String, int>{},
    collectedStickers: <String>[],
  );
}

/// Mathematical challenge protecting adult settings or exit from Kids Mode.
class MathGateChallenge {
  const MathGateChallenge({
    required this.num1,
    required this.num2,
    required this.sum,
    required this.promptBn,
    required this.optionsBn,
    required this.correctIndex,
  });

  final int num1;
  final int num2;
  final int sum;
  final String promptBn;
  final List<String> optionsBn;
  final int correctIndex;
}

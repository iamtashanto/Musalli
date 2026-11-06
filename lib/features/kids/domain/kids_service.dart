// Kids Mode Service (Pure Dart - No Flutter imports).

import 'dart:math';

import 'package:musalli/features/kids/domain/kids_models.dart';

/// Pure Dart logic for managing kids learning path lessons and parent math lock.
class KidsService {
  const KidsService();

  /// Canonical 6-stage progressive learning path for children.
  List<KidsLesson> getLessons() {
    return const [
      KidsLesson(
        id: KidsLessonId.wudu,
        order: 1,
        titleBn: '১. সহজে অজু শেখা',
        subtitleBn: 'হাত-মুখ ধুয়ে সুন্দর পরিচ্ছন্ন হওয়া',
        iconEmoji: '💧',
        targetRoute: '/wudu/simulator',
        stickerName: 'পবিত্রতার তারা',
        stickerEmoji: '🌟',
        descriptionBn:
            'নামাজের আগে বিসমিল্লাহ বলে কীভাবে হাত, মুখ ও পা ধুতে হয় শিখব!',
      ),
      KidsLesson(
        id: KidsLessonId.takbir,
        order: 2,
        titleBn: '২. তাকবীরে তাহরীমা',
        subtitleBn: 'আল্লাহু আকবার বলে নামাজ শুরু',
        iconEmoji: '🤲',
        targetRoute: '/simulator?prayer=fajr',
        stickerName: 'নূরের চাঁদ',
        stickerEmoji: '🌙',
        descriptionBn:
            'দুই হাত কান পর্যন্ত উঠিয়ে আল্লাহু আকবার বলে হাত বাঁধার নিয়ম।',
      ),
      KidsLesson(
        id: KidsLessonId.fatiha,
        order: 3,
        titleBn: '৩. সূরা আল-ফাতিহা',
        subtitleBn: 'নামাজের সবচেয়ে গুরুত্বপূর্ণ সূরা',
        iconEmoji: '📖',
        targetRoute: '/quran/1',
        stickerName: 'কুরআনের ফুল',
        stickerEmoji: '🌸',
        descriptionBn:
            'প্রতি রাকাতে যে সুন্দর সূরাটি পড়তে হয় তার শুদ্ধ উচ্চারণ।',
      ),
      KidsLesson(
        id: KidsLessonId.shortSurahs,
        order: 4,
        titleBn: '৪. ছোট সূরা (ইখলাস ও কাওসার)',
        subtitleBn: 'সহজে মুখস্থ করার মত মিষ্টি দুটি সূরা',
        iconEmoji: '✨',
        targetRoute: '/quran/112',
        stickerName: 'ছোট হাফেজ',
        stickerEmoji: '🏆',
        descriptionBn: 'কুল হুওয়াল্লাহু আহাদ এবং ইন্না আতাইনা কাল কাওসার।',
      ),
      KidsLesson(
        id: KidsLessonId.twoRakat,
        order: 5,
        titleBn: '৫. ২ রাকাত নামাজ (ফজর)',
        subtitleBn: 'সকালের স্নিগ্ধ নামাজ',
        iconEmoji: '🕌',
        targetRoute: '/simulator?prayer=fajr',
        stickerName: 'ছোট মুসল্লি',
        stickerEmoji: '🎖️',
        descriptionBn:
            'রুকু, সেজদা ও সালাম ফিরিয়ে পুরো ২ রাকাত নামাজ সম্পূর্ণ করা।',
      ),
      KidsLesson(
        id: KidsLessonId.fourRakat,
        order: 6,
        titleBn: '৬. ৪ রাকাত নামাজ (যোহর)',
        subtitleBn: 'দুপুরের সুন্দর চার রাকাত নামাজ',
        iconEmoji: '🌟',
        targetRoute: '/simulator?prayer=dhuhr',
        stickerName: 'নামাজের হিরো',
        stickerEmoji: '👑',
        descriptionBn: 'প্রথম বৈঠক ও শেষ বৈঠকের সাথে ৪ রাকাত নামাজ শেখা।',
      ),
    ];
  }

  /// Determines if a lesson is unlocked. Stage 1 is always unlocked;
  /// each subsequent stage unlocks when the predecessor is completed.
  bool isLessonUnlocked(KidsLessonId id, Set<String> completedIds) {
    switch (id) {
      case KidsLessonId.wudu:
        return true;
      case KidsLessonId.takbir:
        return completedIds.contains(KidsLessonId.wudu.key);
      case KidsLessonId.fatiha:
        return completedIds.contains(KidsLessonId.takbir.key);
      case KidsLessonId.shortSurahs:
        return completedIds.contains(KidsLessonId.fatiha.key);
      case KidsLessonId.twoRakat:
        return completedIds.contains(KidsLessonId.shortSurahs.key);
      case KidsLessonId.fourRakat:
        return completedIds.contains(KidsLessonId.twoRakat.key);
    }
  }

  /// Generates a math addition challenge with Bengali numerals for the Parent Gate.
  MathGateChallenge generateMathChallenge([Random? random]) {
    final rng = random ?? Random();
    // Numbers between 4 and 14
    final n1 = rng.nextInt(9) + 4;
    final n2 = rng.nextInt(9) + 3;
    final sum = n1 + n2;

    String toBn(int n) {
      const bnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
      return n.toString().split('').map((c) => bnDigits[int.parse(c)]).join();
    }

    final correctBn = toBn(sum);
    final distractors = <String>{
      toBn(sum + (rng.nextBool() ? 2 : -2)),
      toBn(sum + (rng.nextBool() ? 3 : -3)),
    }..remove(correctBn);

    while (distractors.length < 2) {
      distractors.add(toBn(sum + distractors.length + 4));
    }

    final options = [correctBn, ...distractors]..shuffle(rng);
    final correctIndex = options.indexOf(correctBn);

    return MathGateChallenge(
      num1: n1,
      num2: n2,
      sum: sum,
      promptBn: '${toBn(n1)} + ${toBn(n2)} = কত?',
      optionsBn: options,
      correctIndex: correctIndex,
    );
  }
}

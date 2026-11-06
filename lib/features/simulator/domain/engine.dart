// Namaj Simulator Timeline Generator (Pure Dart - No Flutter imports).
//
// Algorithmic generator converting any [ContentSalahConfig] into a chronological
// [Timeline] of [SimStep] steps according to the authentic Hanafi school.

import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/content/salah_config.dart';

/// Default beginner-friendly short surahs for each rakat.
const Map<int, String> kDefaultSurahChoices = <int, String>{
  1: 'surah-108', // Al-Kawthar
  2: 'surah-112', // Al-Ikhlas
  3: 'surah-113', // Al-Falaq
  4: 'surah-114', // An-Nas
};

/// Obtains default surah for a given rakat, preferring memorized surahs if available.
String resolveSurahForRakat(
  int rakat, {
  Map<int, String>? surahChoice,
  MemorizedSurahsProvider? memorizedProvider,
}) {
  if (surahChoice != null && surahChoice.containsKey(rakat)) {
    return surahChoice[rakat]!;
  }

  final memorized = memorizedProvider?.getMemorizedSurahNumbers();
  if (memorized != null && memorized.isNotEmpty) {
    final surahNum = memorized[(rakat - 1) % memorized.length];
    return 'surah-$surahNum';
  }

  if (kDefaultSurahChoices.containsKey(rakat)) {
    return kDefaultSurahChoices[rakat]!;
  }

  const cycle = <String>['surah-108', 'surah-112', 'surah-113', 'surah-114'];
  return cycle[(rakat - 1) % cycle.length];
}

/// Builds an ordered, deterministic [Timeline] from a [ContentSalahConfig].
Timeline buildTimeline(
  ContentSalahConfig config, {
  required SimGender gender,
  required SimRole role,
  Map<int, String>? surahChoice,
  MemorizedSurahsProvider? memorizedSurahsProvider,
  String? prayerSlug,
  String? unitLabel,
  bool includeMunajat = true,
}) {
  final genderVariants = GenderVariantFlags.forGender(gender);
  final steps = <SimStep>[];

  // ============================================================================
  // SPECIAL CASE 1: SALATUL JANAZA (Standing only, 4 Takbirs, No Ruku/Sajda)
  // ============================================================================
  if (config.isJanaza) {
    // 1. Standing & Niyyat
    steps.add(
      SimStep(
        id: 'janaza-niyyat',
        rakat: null,
        posture: Posture.standing,
        recitationIds: const [],
        repeat: 1,
        spokenTakbir: null,
        isLoud: false,
        durationHintMs: 4000,
        titleBn: 'কিবলামুখী হয়ে দাঁড়ানো ও নিয়্যত',
        instructionBn: 'মাইয়্যিতকে সামনে রেখে কিবলামুখী হয়ে দাঁড়ান এবং ৪ তাকবীরের সাথে জানাজার নামাজের নিয়্যত করুন।',
        instructionEn: 'Stand facing Qibla and make intention for Janaza prayer with 4 takbirs.',
        genderVariants: genderVariants,
      ),
    );

    // 2. First Takbir + Sana
    steps.add(
      SimStep(
        id: 'janaza-takbir-1',
        rakat: null,
        posture: Posture.janazaTakbir,
        recitationIds: const ['dua-sana-janaza'],
        repeat: 1,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: role == SimRole.imam,
        durationHintMs: 8000,
        titleBn: '১ম তাকবীর ও ছানা পাঠ',
        instructionBn: gender == SimGender.male
            ? "'আল্লাহু আকবার' বলে কান পর্যন্ত হাত তুলে নাভির নিচে বাঁধুন এবং নীরবে জানাজার ছানা পাঠ করুন।"
            : "'আল্লাহু আকবার' বলে কাঁধ পর্যন্ত হাত তুলে বুকের ওপর বাঁধুন এবং নীরবে জানাজার ছানা পাঠ করুন।",
        instructionEn: 'Say Allahu Akbar raising hands, fold hands and recite Janaza Sana quietly.',
        genderVariants: genderVariants,
      ),
    );

    // 3. Second Takbir + Durood Ibrahim
    steps.add(
      SimStep(
        id: 'janaza-takbir-2',
        rakat: null,
        posture: Posture.janazaTakbir,
        recitationIds: const ['dua-3'],
        repeat: 1,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: role == SimRole.imam,
        durationHintMs: 12000,
        titleBn: '২য় তাকবীর ও দুরূদ শরীফ পাঠ',
        instructionBn: "হাত না উঠিয়ে (হাত বাঁধা অবস্থায়) 'আল্লাহু আকবার' বলুন এবং নীরবে দুরূদে ইব্রাহীম পাঠ করুন।",
        instructionEn: 'Say Allahu Akbar without raising hands and recite Durood Ibrahim quietly.',
        genderVariants: genderVariants,
      ),
    );

    // 4. Third Takbir + Janaza Dua
    steps.add(
      SimStep(
        id: 'janaza-takbir-3',
        rakat: null,
        posture: Posture.janazaTakbir,
        recitationIds: const ['dua-janaza'],
        repeat: 1,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: role == SimRole.imam,
        durationHintMs: 14000,
        titleBn: '৩য় তাকবীর ও মাগফিরাতের দোয়া',
        instructionBn: "হাত না উঠিয়ে 'আল্লাহু আকবার' বলুন এবং নীরবে মাইয়্যিতের মাগফিরাতের দোয়া পাঠ করুন।",
        instructionEn: 'Say Allahu Akbar without raising hands and recite Janaza Dua for the deceased.',
        genderVariants: genderVariants,
      ),
    );

    // 5. Fourth Takbir (Before Salam)
    steps.add(
      SimStep(
        id: 'janaza-takbir-4',
        rakat: null,
        posture: Posture.janazaTakbir,
        recitationIds: const [],
        repeat: 1,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: role == SimRole.imam,
        durationHintMs: 3000,
        titleBn: '৪র্থ তাকবীর',
        instructionBn: "হাত না উঠিয়ে চতুর্থ বার 'আল্লাহু আকবার' বলুন এবং এরপর উভয় হাত পাশে ছেড়ে দিয়ে সালাম ফিরান।",
        instructionEn: 'Say Allahu Akbar for the 4th time and release hands to sides before Salam.',
        genderVariants: genderVariants,
      ),
    );

    // 6. Salam Right & Left
    if (config.endsWithSalam) {
      steps.add(
        SimStep(
          id: 'salam-right',
          rakat: null,
          posture: Posture.salamRight,
          recitationIds: const ['dua-salam'],
          repeat: 1,
          spokenTakbir: 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ',
          isLoud: role == SimRole.imam,
          durationHintMs: 3000,
          titleBn: 'ডান দিকে সালাম',
          instructionBn: "ডান কাঁধের দিকে মুখ ফিরিয়ে 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ' বলুন।",
          instructionEn: 'Turn face to right shoulder and say Salam.',
          genderVariants: genderVariants,
        ),
      );

      steps.add(
        SimStep(
          id: 'salam-left',
          rakat: null,
          posture: Posture.salamLeft,
          recitationIds: const ['dua-salam'],
          repeat: 1,
          spokenTakbir: 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ',
          isLoud: role == SimRole.imam,
          durationHintMs: 3000,
          titleBn: 'বাম দিকে সালাম',
          instructionBn: "বাম কাঁধের দিকে মুখ ফিরিয়ে 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ' বলুন।",
          instructionEn: 'Turn face to left shoulder and say Salam.',
          genderVariants: genderVariants,
        ),
      );
    }

    final estimatedDurationMs = steps.fold<int>(
      0,
      (sum, s) => sum + s.durationHintMs,
    );

    return Timeline(
      steps: steps,
      metadata: TimelineMetadata(
        totalRakats: 0,
        prayerSlug: prayerSlug,
        unitLabel: unitLabel,
        gender: gender,
        role: role,
        totalSteps: steps.length,
        totalTasbihCount: 0,
        estimatedDurationMs: estimatedDurationMs,
        isJanaza: true,
      ),
    );
  }

  // ============================================================================
  // STANDARD & SPECIAL SALAH FLOW (2, 3, 4+ Rakats, Witr, Eid, Salatut Tasbih)
  // ============================================================================

  ContentTasbihDistribution? getTasbihForPosition(String pos) {
    if (config.tasbihDistribution == null) return null;
    for (final item in config.tasbihDistribution!) {
      if (item.position == pos) return item;
    }
    return null;
  }

  // 0. Standing & Niyyat (Before Rakat 1)
  steps.add(
    SimStep(
      id: 'step-niyyat',
      rakat: 1,
      posture: Posture.standing,
      recitationIds: const [],
      repeat: 1,
      spokenTakbir: null,
      isLoud: false,
      durationHintMs: 3500,
      titleBn: 'কিবলামুখী হয়ে দাঁড়ানো ও নিয়্যত',
      instructionBn: gender == SimGender.male
          ? 'কিবলামুখী হয়ে দুই পায়ের মাঝে চার আঙুল ফাঁকা রেখে সোজা হয়ে দাঁড়ান এবং অন্তরে নামাজের নিয়্যত করুন।'
          : 'কিবলামুখী হয়ে উভয় পা একসাথে মিলিয়ে সোজা হয়ে দাঁড়ান এবং অন্তরে নামাজের নিয়্যত করুন।',
      instructionEn:
          'Stand upright facing Qibla and formulate intention in heart.',
      genderVariants: genderVariants,
    ),
  );

  // 1. Takbire Tahrima (Opening Takbir in Rakat 1)
  steps.add(
    SimStep(
      id: 'r1-takbir-tahrima',
      rakat: 1,
      posture: Posture.takbirHandsRaised,
      recitationIds: const ['dua-8'],
      repeat: 1,
      spokenTakbir: 'আল্লাহু আকবার',
      isLoud: role == SimRole.imam,
      durationHintMs: 3000,
      titleBn: 'তাকবীরে তাহরীমা',
      instructionBn: gender == SimGender.male
          ? "দুই হাতের বৃদ্ধাঙ্গুলি কানের লতি পর্যন্ত উঠিয়ে 'আল্লাহু আকবার' বলুন।"
          : "দুই হাত কাঁধ বা বুক পর্যন্ত উঠিয়ে 'আল্লাহু আকবার' বলুন।",
      instructionEn: 'Raise hands and say Allahu Akbar to begin prayer.',
      genderVariants: genderVariants,
    ),
  );

  // Loop over each rakat
  for (var r = 1; r <= config.rakats; r++) {
    final isRakatLoud = role == SimRole.imam && config.jahr.contains(r);
    var pendingStandingTakbir = r > 1 ? 'আল্লাহু আকবার' : null;

    // 1A. Sana (Only in 1st Rakat)
    if (r == 1) {
      steps.add(
        SimStep(
          id: 'r1-sana',
          rakat: 1,
          posture: Posture.qiyamHandsFolded,
          recitationIds: const ['dua-1'],
          repeat: 1,
          spokenTakbir: null,
          isLoud: false,
          durationHintMs: 7000,
          titleBn: 'হাত বাঁধা ও ছানা পাঠ',
          instructionBn: gender == SimGender.male
              ? 'নাভির নিচে ডান হাত বাম হাতের কব্জির ওপর রেখে বাঁধুন এবং নীরবে ছানা পাঠ করুন।'
              : 'বুকের ওপর ডান হাত বাম হাতের পিঠের ওপর রেখে বাঁধুন এবং নীরবে ছানা পাঠ করুন।',
          instructionEn: 'Fold hands and recite Sana silently.',
          genderVariants: genderVariants,
        ),
      );
    }

    // 1B. Salatut Tasbih: after-sana (15 times before Fatiha in every rakat)
    final tasbihAfterSana = getTasbihForPosition('after-sana');
    if (tasbihAfterSana != null) {
      steps.add(
        SimStep(
          id: 'r$r-tasbih-after-sana',
          rakat: r,
          posture: Posture.qiyamHandsFolded,
          recitationIds: const ['dua-tasbih'],
          repeat: tasbihAfterSana.count,
          tasbihCount: tasbihAfterSana.count,
          spokenTakbir: pendingStandingTakbir,
          isLoud: false,
          durationHintMs: 14000,
          titleBn: 'সালাতুত তাসবীহ পাঠ (${tasbihAfterSana.count} বার)',
          instructionBn:
              '${tasbihAfterSana.labelBn}: সূরা ফাতিহা শুরুর পূর্বে হাত বাঁধা অবস্থায় ১৫ বার তাসবীহ পাঠ করুন।',
          instructionEn: 'Recite Tasbih 15 times before Surah Al-Fatihah.',
          genderVariants: genderVariants,
        ),
      );
      pendingStandingTakbir = null;
    }

    // 1C. Eid Extra Takbirs: after-sana (Typically 3 extra takbirs in Rakat 1)
    final extraTakbirsAfterSana =
        config.extraTakbirs?.where(
          (et) => et.rakat == r && et.position == 'after-sana',
        ) ??
        const [];

    for (final et in extraTakbirsAfterSana) {
      for (var t = 1; t <= et.count; t++) {
        steps.add(
          SimStep(
            id: 'r$r-eid-takbir-after-sana-$t-raise',
            rakat: r,
            posture: Posture.eidTakbirRaised,
            recitationIds: const ['dua-eid-takbir'],
            repeat: 1,
            spokenTakbir: 'আল্লাহু আকবার',
            isLoud: role == SimRole.imam,
            durationHintMs: 2500,
            titleBn: 'ঈদের অতিরিক্ত তাকবীর ($t) — হাত উত্তোলন',
            instructionBn:
                "'আল্লাহু আকবার' বলে দুই হাত ${gender == SimGender.male ? 'কান' : 'কাঁধ'} পর্যন্ত উঠান।",
            instructionEn:
                'Say Allahu Akbar raising hands for extra Eid takbir.',
            genderVariants: genderVariants,
          ),
        );

        if (t < et.count) {
          steps.add(
            SimStep(
              id: 'r$r-eid-takbir-after-sana-$t-down',
              rakat: r,
              posture: Posture.eidTakbirReleased,
              recitationIds: const [],
              repeat: 1,
              spokenTakbir: null,
              isLoud: false,
              durationHintMs: 2000,
              titleBn: 'হাত ছেড়ে দেওয়া ($t)',
              instructionBn: 'হাত না বেঁধে শরীরের দুই পাশে ছেড়ে দিন এবং ৩ তাসবীহ পরিমাণ নীরব থাকুন।',
              instructionEn: 'Release hands to sides and pause.',
              genderVariants: genderVariants,
            ),
          );
        }
      }
    }

    // 2. Qirat in Qiyam (Fatiha + Surah OR Silent Listening for Muqtadi)
    if (role == SimRole.muqtadi) {
      steps.add(
        SimStep(
          id: 'r$r-qiyam-muqtadi',
          rakat: r,
          posture: Posture.qiyamHandsFolded,
          recitationIds: const [],
          repeat: 1,
          spokenTakbir: pendingStandingTakbir,
          isLoud: false,
          durationHintMs: 15000,
          titleBn: '$rম রাকাত: নীরবে কিয়াম ও কেরাত শ্রবণ',
          instructionBn: 'হানাফি মাযহাব অনুযায়ী মুক্তাদী ইমামের পেছনে সূরা ফাতিহা বা সূরা পড়বেন না; নীরবে হাত বেঁধে দাঁড়িয়ে মনোযোগসহ ইমামের কেরাত শুনুন।',
          instructionEn:
              'Muqtadi stands silently listening to recitation behind Imam.',
          genderVariants: genderVariants,
        ),
      );
      pendingStandingTakbir = null;
    } else {
      // Alone or Imam: Recite Surah Al-Fatiha
      final fatihaRecitations = r == 1
          ? const ['dua-taawwuz', 'dua-tasmiyah', 'surah-1']
          : const ['dua-tasmiyah', 'surah-1'];

      steps.add(
        SimStep(
          id: 'r$r-fatiha',
          rakat: r,
          posture: Posture.qiyamHandsFolded,
          recitationIds: fatihaRecitations,
          repeat: 1,
          spokenTakbir: pendingStandingTakbir,
          isLoud: isRakatLoud,
          durationHintMs: 16000,
          titleBn: 'সূরা আল-ফাতিহা তিলাওয়াত',
          instructionBn: r == 1
              ? "নীরবে আউযুবিল্লাহ ও বিসমিল্লাহ পড়ে সূরা আল-ফাতিহা পাঠ করুন এবং শেষে নীরবে 'আমীন' বলুন।"
              : "নীরবে বিসমিল্লাহ পড়ে সূরা আল-ফাতিহা পাঠ করুন এবং শেষে নীরবে 'আমীন' বলুন।",
          instructionEn: 'Recite Surah Al-Fatihah and say Ameen silently.',
          genderVariants: genderVariants,
        ),
      );
      pendingStandingTakbir = null;

      // Recite Additional Surah if configured in qiratRakats
      if (config.qiratRakats.contains(r) || config.qiratRakats.isEmpty) {
        final selectedSurahId = resolveSurahForRakat(
          r,
          surahChoice: surahChoice,
          memorizedProvider: memorizedSurahsProvider,
        );

        steps.add(
          SimStep(
            id: 'r$r-surah',
            rakat: r,
            posture: Posture.qiyamHandsFolded,
            recitationIds: ['dua-tasmiyah', selectedSurahId],
            repeat: 1,
            spokenTakbir: null,
            isLoud: isRakatLoud,
            durationHintMs: 12000,
            titleBn: 'অতিরিক্ত সূরা মিলানো (কিরাত)',
            instructionBn: 'নীরবে বিসমিল্লাহ পড়ে পবিত্র কুরআন থেকে একটি সূরা বা অন্তত তিন আয়াত তিলাওয়াত করুন।',
            instructionEn:
                'Recite an additional surah or three verses from the Quran.',
            genderVariants: genderVariants,
          ),
        );
      }
    }

    // 2B. Salatut Tasbih: after-surah (10 times standing before ruku)
    final tasbihAfterSurah = getTasbihForPosition('after-surah');
    if (tasbihAfterSurah != null) {
      steps.add(
        SimStep(
          id: 'r$r-tasbih-after-surah',
          rakat: r,
          posture: Posture.qiyamHandsFolded,
          recitationIds: const ['dua-tasbih'],
          repeat: tasbihAfterSurah.count,
          tasbihCount: tasbihAfterSurah.count,
          spokenTakbir: null,
          isLoud: false,
          durationHintMs: 10000,
          titleBn: 'কেরাতের পর তাসবীহ পাঠ (${tasbihAfterSurah.count} বার)',
          instructionBn:
              '${tasbihAfterSurah.labelBn}: রুকুতে যাওয়ার পূর্বে দাঁড়ানো অবস্থায় ১০ বার তাসবীহ পাঠ করুন।',
          instructionEn: 'Recite Tasbih 10 times standing before Ruku.',
          genderVariants: genderVariants,
        ),
      );
    }

    // 2C. Witr Qunut (Before Ruku in 3rd Rakat)
    final isQunutBeforeRuku =
        config.hasQunut != null &&
        config.hasQunut!.enabled &&
        config.hasQunut!.rakat == r &&
        config.hasQunut!.position == 'before-ruku';

    if (isQunutBeforeRuku) {
      steps.add(
        SimStep(
          id: 'r$r-qunut-takbir',
          rakat: r,
          posture: Posture.qunutTakbir,
          recitationIds: const ['dua-8'],
          repeat: 1,
          spokenTakbir: 'আল্লাহু আকবার',
          isLoud: role == SimRole.imam,
          durationHintMs: 2500,
          titleBn: 'দোয়া কুনূতের তাকবীর',
          instructionBn:
              "'আল্লাহু আকবার' বলে দুই হাত ${gender == SimGender.male ? 'কানের লতি' : 'কাঁধ'} পর্যন্ত উঠান এবং পুনরায় হাত বাঁধুন।",
          instructionEn: 'Raise hands saying Allahu Akbar, then fold hands again for Dua Qunut.',
          genderVariants: genderVariants,
        ),
      );

      steps.add(
        SimStep(
          id: 'r$r-dua-qunut',
          rakat: r,
          posture: Posture.qiyamHandsFolded,
          recitationIds: const ['dua-5'],
          repeat: 1,
          spokenTakbir: null,
          isLoud: false,
          durationHintMs: 14000,
          titleBn: 'দোয়া কুনূত পাঠ',
          instructionBn: 'হাত বাঁধা অবস্থায় নীরবে দোয়া কুনূত পাঠ করুন।',
          instructionEn: 'Recite Dua Qunut silently with hands folded.',
          genderVariants: genderVariants,
        ),
      );
    }

    // 2D. Eid Extra Takbirs: before-ruku / after-qirat (Typically 3 extra takbirs in Rakat 2)
    final extraTakbirsBeforeRuku =
        config.extraTakbirs?.where(
          (et) =>
              et.rakat == r &&
              (et.position == 'before-ruku' || et.position == 'after-qirat'),
        ) ??
        const [];

    for (final et in extraTakbirsBeforeRuku) {
      for (var t = 1; t <= et.count; t++) {
        steps.add(
          SimStep(
            id: 'r$r-eid-takbir-before-ruku-$t-raise',
            rakat: r,
            posture: Posture.eidTakbirRaised,
            recitationIds: const ['dua-eid-takbir'],
            repeat: 1,
            spokenTakbir: 'আল্লাহু আকবার',
            isLoud: role == SimRole.imam,
            durationHintMs: 2500,
            titleBn: 'ঈদের অতিরিক্ত তাকবীর ($t) — হাত উত্তোলন',
            instructionBn:
                "'আল্লাহু আকবার' বলে দুই হাত ${gender == SimGender.male ? 'কান' : 'কাঁধ'} পর্যন্ত উঠান।",
            instructionEn:
                'Say Allahu Akbar raising hands for extra Eid takbir.',
            genderVariants: genderVariants,
          ),
        );

        steps.add(
          SimStep(
            id: 'r$r-eid-takbir-before-ruku-$t-down',
            rakat: r,
            posture: Posture.eidTakbirReleased,
            recitationIds: const [],
            repeat: 1,
            spokenTakbir: null,
            isLoud: false,
            durationHintMs: 2000,
            titleBn: 'হাত ছেড়ে দেওয়া ($t)',
            instructionBn: 'হাত না বেঁধে শরীরের দুই পাশে ছেড়ে দিন।',
            instructionEn: 'Release hands to sides.',
            genderVariants: genderVariants,
          ),
        );
      }
    }

    // 3. Ruku
    final tasbihRuku = getTasbihForPosition('ruku');
    steps.add(
      SimStep(
        id: 'r$r-ruku',
        rakat: r,
        posture: Posture.ruku,
        recitationIds: tasbihRuku != null
            ? const ['dua-6', 'dua-tasbih']
            : const ['dua-6'],
        repeat: tasbihRuku != null ? tasbihRuku.count : 3,
        tasbihCount: tasbihRuku?.count,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: role == SimRole.imam,
        durationHintMs: tasbihRuku != null ? 12000 : 6000,
        titleBn: 'রুকু',
        instructionBn: gender == SimGender.male
            ? "'আল্লাহু আকবার' বলে রুকুতে যান। পিঠ ও মাথা এক সমান্তরালে সোজা রাখুন, হাত দিয়ে হাঁটু আঁকড়ে ধরুন এবং রুকুর তাসবীহ পাঠ করুন।"
            : "'আল্লাহু আকবার' বলে সামান্য ঝুঁকে রুকুতে যান, হাঁটুর ওপর হাত রাখুন, কনুই পাঁজরের সাথে মিলিয়ে রাখুন এবং রুকুর তাসবীহ পাঠ করুন।",
        instructionEn: 'Bow into Ruku and recite Ruku tasbih.',
        genderVariants: genderVariants,
      ),
    );

    // 4. Qawma (Standing up after Ruku)
    final tasbihQawma = getTasbihForPosition('qawmah');
    final qawmaSpoken = role == SimRole.muqtadi
        ? 'রাব্বানা লাকাল হামদ'
        : 'সামিআল্লাহু লিমান হামিদাহ';

    steps.add(
      SimStep(
        id: 'r$r-qawma',
        rakat: r,
        posture: Posture.qawma,
        recitationIds: tasbihQawma != null
            ? const ['dua-qawmah', 'dua-tasbih']
            : const ['dua-qawmah'],
        repeat: tasbihQawma != null ? tasbihQawma.count : 1,
        tasbihCount: tasbihQawma?.count,
        spokenTakbir: qawmaSpoken,
        isLoud: role == SimRole.imam,
        durationHintMs: tasbihQawma != null ? 10000 : 4000,
        titleBn: 'কওমা (রুকু থেকে সোজা হয়ে দাঁড়ানো)',
        instructionBn: 'রুকু থেকে সম্পূর্ণ সোজা হয়ে স্থিরভাবে দাঁড়ান এবং তাসমি ও তাহমীদ পাঠ করুন।',
        instructionEn: 'Stand upright from Ruku reciting praise.',
        genderVariants: genderVariants,
      ),
    );

    // 5. Sajdas & Jalsa
    for (var s = 1; s <= config.sajdaCount; s++) {
      final tasbihSajda = getTasbihForPosition(s == 1 ? 'sajda-1' : 'sajda-2');

      steps.add(
        SimStep(
          id: 'r$r-sajda-$s',
          rakat: r,
          posture: Posture.sajda,
          recitationIds: tasbihSajda != null
              ? const ['dua-7', 'dua-tasbih']
              : const ['dua-7'],
          repeat: tasbihSajda != null ? tasbihSajda.count : 3,
          tasbihCount: tasbihSajda?.count,
          spokenTakbir: 'আল্লাহু আকবার',
          isLoud: role == SimRole.imam,
          durationHintMs: tasbihSajda != null ? 12000 : 6500,
          titleBn: s == 1 ? 'প্রথম সিজদা' : 'দ্বিতীয় সিজদা',
          instructionBn: gender == SimGender.male
              ? "'আল্লাহু আকবার' বলে সিজদায় যান। নাক ও কপাল মাটিতে রাখুন, কনুই জমিন ও পেট উরু থেকে আলাদা রাখুন এবং সিজদার তাসবীহ পাঠ করুন।"
              : "'আল্লাহু আকবার' বলে সিজদায় যান। উভয় হাত ও কনুই মাটির সাথে মিলিয়ে জড়সড় হয়ে সিজদা করুন এবং সিজদার তাসবীহ পাঠ করুন।",
          instructionEn: 'Prostrate into Sajda and recite Sajda tasbih.',
          genderVariants: genderVariants,
        ),
      );

      // Jalsa between Sajda 1 and Sajda 2
      if (s < config.sajdaCount) {
        final tasbihJalsa = getTasbihForPosition('jalsah');

        steps.add(
          SimStep(
            id: 'r$r-jalsa',
            rakat: r,
            posture: Posture.jalsa,
            recitationIds: tasbihJalsa != null
                ? const ['dua-jalsah', 'dua-tasbih']
                : const ['dua-jalsah'],
            repeat: tasbihJalsa != null ? tasbihJalsa.count : 1,
            tasbihCount: tasbihJalsa?.count,
            spokenTakbir: 'আল্লাহু আকবার',
            isLoud: role == SimRole.imam,
            durationHintMs: tasbihJalsa != null ? 10000 : 4000,
            titleBn: 'জলসা (দুই সিজদার মাঝের বৈঠক)',
            instructionBn: "'আল্লাহু আকবার' বলে সিজদা থেকে উঠে স্থির হয়ে বসুন এবং দুই সিজদার মাঝের দোয়া পাঠ করুন।",
            instructionEn: 'Sit between two prostrations reciting Jalsa dua.',
            genderVariants: genderVariants,
          ),
        );
      }
    }

    // 6. Sittings (First Sitting Qa'dah Ula OR Final Sitting Qa'dah Akhirah)
    final isFirstSitting =
        config.firstSittingAfter != null &&
        r == config.firstSittingAfter &&
        r < config.rakats;
    final isFinalSitting = r == config.rakats;

    if (isFirstSitting) {
      steps.add(
        SimStep(
          id: 'r$r-qada-first',
          rakat: r,
          posture: Posture.qada,
          recitationIds: const ['dua-2'],
          repeat: 1,
          spokenTakbir: 'আল্লাহু আকবার',
          isLoud: role == SimRole.imam,
          durationHintMs: 9000,
          titleBn: "প্রথম বৈঠক (কা'দায়ে উলা) ও তাশাহহুদ",
          instructionBn: gender == SimGender.male
              ? "'আল্লাহু আকবার' বলে বাম পা বিছিয়ে তার ওপর বসুন, ডান পা খাড়া রাখুন এবং আত্তাহিয়্যাতু পাঠ শুরু করুন।"
              : "'আল্লাহু আকবার' বলে উভয় পা ডান দিকে বের করে বাম নিতম্বের ওপর বসুন এবং আত্তাহিয়্যাতু পাঠ শুরু করুন।",
          instructionEn: "Sit in first Qa'dah and recite Tashahhud.",
          genderVariants: genderVariants,
        ),
      );

      steps.add(
        SimStep(
          id: 'r$r-tashahhud-finger-first',
          rakat: r,
          posture: Posture.tashahhudFingerRaised,
          recitationIds: const ['dua-2'],
          repeat: 1,
          spokenTakbir: null,
          isLoud: false,
          durationHintMs: 4000,
          titleBn: 'শাহাদাত আঙুল উত্তোলন (প্রথম বৈঠক)',
          instructionBn: "'আশহাদু আল্লা ইলাহা' বলার সময় ডান হাতের শাহাদাত আঙুল তুলুন এবং 'ইল্লাল্লাহু' বলার সময় নামিয়ে নিন। এরপর দুরূদ না পড়ে পরবর্তী রাকাতের জন্য দাঁড়িয়ে যান।",
          instructionEn: 'Raise index finger during Tashahhud testimony.',
          genderVariants: genderVariants,
        ),
      );
    } else if (isFinalSitting) {
      steps.add(
        SimStep(
          id: 'r$r-qada-final',
          rakat: r,
          posture: Posture.qada,
          recitationIds: const ['dua-2'],
          repeat: 1,
          spokenTakbir: 'আল্লাহু আকবার',
          isLoud: role == SimRole.imam,
          durationHintMs: 9000,
          titleBn: "শেষ বৈঠক (কা'দায়ে আখিরাহ) ও তাশাহহুদ",
          instructionBn: gender == SimGender.male
              ? "'আল্লাহু আকবার' বলে শেষ বৈঠকে বসুন এবং আত্তাহিয়্যাতু পাঠ করুন।"
              : "'আল্লাহু আকবার' বলে উভয় পা ডান দিকে বের করে শেষ বৈঠকে বসুন এবং আত্তাহিয়্যাতু পাঠ করুন।",
          instructionEn: 'Sit in final Qa\'dah and recite Tashahhud.',
          genderVariants: genderVariants,
        ),
      );

      steps.add(
        SimStep(
          id: 'r$r-tashahhud-finger-final',
          rakat: r,
          posture: Posture.tashahhudFingerRaised,
          recitationIds: const ['dua-3', 'dua-4'],
          repeat: 1,
          spokenTakbir: null,
          isLoud: false,
          durationHintMs: 16000,
          titleBn: 'শাহাদাত আঙুল ইশারা, দুরূদ শরীফ ও দোয়া মাসুরা',
          instructionBn: 'শাহাদাত আঙুল দ্বারা ইশারা করার পর পূর্ণ দুরূদে ইব্রাহীম এবং দোয়া মাসুরা পাঠ করুন।',
          instructionEn:
              'Raise index finger and complete Durood and Dua Masura.',
          genderVariants: genderVariants,
        ),
      );
    }
  }

  // 7. Concluding Salam Pair (Right then Left)
  if (config.endsWithSalam) {
    steps.add(
      SimStep(
        id: 'salam-right',
        rakat: null,
        posture: Posture.salamRight,
        recitationIds: const ['dua-salam'],
        repeat: 1,
        spokenTakbir: 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ',
        isLoud: role == SimRole.imam,
        durationHintMs: 3000,
        titleBn: 'ডান দিকে সালাম',
        instructionBn: "ডান কাঁধের দিকে মুখ ফিরিয়ে 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ' বলুন।",
        instructionEn: 'Turn face to right shoulder and say Salam.',
        genderVariants: genderVariants,
      ),
    );

    steps.add(
      SimStep(
        id: 'salam-left',
        rakat: null,
        posture: Posture.salamLeft,
        recitationIds: const ['dua-salam'],
        repeat: 1,
        spokenTakbir: 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ',
        isLoud: role == SimRole.imam,
        durationHintMs: 3000,
        titleBn: 'বাম দিকে সালাম',
        instructionBn: "বাম কাঁধের দিকে মুখ ফিরিয়ে 'আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ' বলুন।",
        instructionEn: 'Turn face to left shoulder and say Salam.',
        genderVariants: genderVariants,
      ),
    );
  }

  // 8. Optional Munajat (After Salam)
  if (includeMunajat) {
    steps.add(
      SimStep(
        id: 'step-munajat',
        rakat: null,
        posture: Posture.munajat,
        recitationIds: const ['dua-after-salah-astaghfirullah'],
        repeat: 1,
        spokenTakbir: null,
        isLoud: false,
        durationHintMs: 8000,
        titleBn: 'সালাম পর ইস্তিগফার ও মুনাজাত',
        instructionBn: 'সালাম ফিরানোর পর তিনবার আস্তাগফিরুল্লাহ ও মাসনূন জিকির পাঠ করে আল্লাহর দরবারে দোয়া করুন।',
        instructionEn: 'Supplication and Istighfar after Salam.',
        genderVariants: genderVariants,
      ),
    );
  }

  final totalTasbihCount = steps.fold<int>(
    0,
    (sum, step) => sum + (step.tasbihCount ?? 0),
  );
  final estimatedDurationMs = steps.fold<int>(
    0,
    (sum, step) => sum + step.durationHintMs,
  );

  return Timeline(
    steps: steps,
    metadata: TimelineMetadata(
      totalRakats: config.rakats,
      prayerSlug: prayerSlug,
      unitLabel: unitLabel,
      gender: gender,
      role: role,
      totalSteps: steps.length,
      totalTasbihCount: totalTasbihCount,
      estimatedDurationMs: estimatedDurationMs,
      isJanaza: false,
    ),
  );
}

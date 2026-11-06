// Practice Engine (Pure Dart - No Flutter imports).

import 'package:musalli/features/simulator/domain/practice/practice_models.dart';
import 'package:musalli/features/simulator/domain/types.dart';

/// Pure Dart engine to generate fiqh-grounded quiz questions for any prayer timeline.
class PracticeEngine {
  const PracticeEngine();

  /// Generates practice questions for the given prayer timeline based on difficulty.
  List<PracticeQuestion> generateQuestions(
    Timeline timeline, {
    required PracticeDifficulty difficulty,
  }) {
    final questions = <PracticeQuestion>[];
    final steps = timeline.steps;
    final totalRakats = timeline.metadata.totalRakats;

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final nextStep = i + 1 < steps.length ? steps[i + 1] : null;

      // 1. Initial Takbir Tahrima
      if (i == 0 && step.posture == Posture.standing) {
        questions.add(
          PracticeQuestion(
            id: 'q_tahrima_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.nextPosture,
            promptBn: 'নামাজ শুরু করার জন্য এখন কী করবেন?',
            options: const [
              PracticeOption(
                id: 'opt_takbir',
                labelBn: 'তাকবীরে তাহরিমা বলে হাত তোলা',
                posture: Posture.takbirHandsRaised,
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_ruku',
                labelBn: 'সরাসরি রুকুতে যাওয়া',
                posture: Posture.ruku,
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_sajda',
                labelBn: 'সেজদায় চলে যাওয়া',
                posture: Posture.sajda,
                isCorrect: false,
              ),
            ],
            correctExplanationBn: 'তাকবীরে তাহরিমা (আল্লাহু আকবার) বলে নামাজ শুরু করা ফরজ বা রুকন।',
            fiqhImpact: MistakeFiqhImpact.invalidatesSalah,
            hintBn: 'নামাজ শুরু করতে প্রথমে তাকবীর বলে হাত তুলতে হয়।',
            ruleSlug: 'shurut-arkan',
          ),
        );
      }

      // 2. Sana recitation in Rakat 1
      if (step.rakat == 1 &&
          step.posture == Posture.qiyamHandsFolded &&
          (step.id.contains('sana') || step.recitationIds.contains('dua-1'))) {
        questions.add(
          PracticeQuestion(
            id: 'q_sana_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.whatRecitation,
            promptBn: 'তাকবীরে তাহরিমার পর হাত বেঁধে প্রথমে কী পড়তে হয়?',
            options: const [
              PracticeOption(
                id: 'opt_sana',
                labelBn: 'সানা (সুবহানাকাল্লাহুম্মা...)',
                arabicText: 'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ',
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_tashahhud',
                labelBn: 'তাশাহহুদ (আত্তাহিয়্যাতু...)',
                arabicText: 'التَّحِيَّاتُ لِلَّهِ',
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_durood',
                labelBn: 'দুরুদ শরীফ (আল্লাহুম্মা সাল্লি...)',
                arabicText: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
                isCorrect: false,
              ),
            ],
            correctExplanationBn:
                'নামাজের শুরুতে সূরা ফাতিহার পূর্বে সানা পড়া সুন্নত।',
            fiqhImpact: MistakeFiqhImpact.sunnahOrMustahab,
            hintBn: 'আল্লাহ তায়ালার পবিত্রতা ঘোষণার দোয়াটি পড়তে হয়।',
            ruleSlug: 'sunnat-mustahab',
          ),
        );
      }

      // 3. Surah Matching question (Qirat)
      if (step.posture == Posture.qiyamHandsFolded && step.rakat != null) {
        final currentRakat = step.rakat!;
        final isSurahExpected =
            currentRakat <= 2 ||
            totalRakats == 3 && timeline.metadata.unitLabel == 'witr';

        // Ask on rakat 1 and rakat 3 (if 3 or 4 rakats)
        if (currentRakat == 1 || (totalRakats >= 3 && currentRakat == 3)) {
          questions.add(
            PracticeQuestion(
              id: 'q_surah_match_r$currentRakat',
              stepIndex: i,
              type: PracticeQuestionType.surahMatching,
              promptBn:
                  '$currentRakat নং রাকাতে সূরা ফাতিহার পর কি অন্য সূরা মেলাতে হবে?',
              options: [
                PracticeOption(
                  id: 'opt_yes',
                  labelBn: 'হ্যাঁ, অন্য সূরা মেলাতে হবে',
                  isCorrect: isSurahExpected,
                ),
                PracticeOption(
                  id: 'opt_no',
                  labelBn: 'না, শুধু সূরা ফাতিহাই যথেষ্ট',
                  isCorrect: !isSurahExpected,
                ),
              ],
              correctExplanationBn: isSurahExpected
                  ? 'ফরজ নামাজের প্রথম দুই রাকাতে এবং সুন্নাত/নফল/বিতরের সকল রাকাতে সূরা ফাতিহার পর অন্য সূরা বা ৩ আয়াত মেলানো ওয়াজিব।'
                  : 'ফরজ নামাজের ৩য় ও ৪র্থ রাকাতে শুধু সূরা ফাতিহা পড়া সুন্নত, অন্য সূরা মেলানো লাগে না।',
              fiqhImpact: isSurahExpected
                  ? MistakeFiqhImpact.requiresSajdaSahu
                  : MistakeFiqhImpact.sunnahOrMustahab,
              hintBn: isSurahExpected
                  ? 'প্রথম দুই রাকাতে কিরাত মেলানো ওয়াজিব।'
                  : 'ফরজের শেষ দুই রাকাতে কেবল সূরা ফাতিহাই পঠিত হয়।',
              ruleSlug: 'wajibat',
            ),
          );
        }
      }

      // 4. Ruku posture & tasbih
      if (step.posture == Posture.ruku) {
        questions.add(
          PracticeQuestion(
            id: 'q_ruku_tasbih_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.whatRecitation,
            promptBn: 'রুকুতে গিয়ে কোন তাসবীহটি পাঠ করতে হয়?',
            options: const [
              PracticeOption(
                id: 'opt_ruku_tasbih',
                labelBn: 'সুবহানা রাব্বিয়াল আজীম',
                arabicText: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_sajda_tasbih',
                labelBn: "সুবহানা রাব্বিয়াল আ'লা",
                arabicText: 'سُبْحَانَ رَبِّيَ الأَعْلَى',
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_rabbana',
                labelBn: 'রব্বানা লাকাল হামদ',
                arabicText: 'رَبَّنَا لَكَ الْحَمْدُ',
                isCorrect: false,
              ),
            ],
            correctExplanationBn:
                'রুকুতে "সুবহানা রাব্বিয়াল আজীম" পাঠ করা সুন্নত।',
            fiqhImpact: MistakeFiqhImpact.sunnahOrMustahab,
            hintBn: '"আজীম" শব্দের অর্থ মহান পরাক্রমশালী।',
            ruleSlug: 'sunnat-mustahab',
          ),
        );

        // Count in ruku (only once per prayer to avoid spam)
        if (step.rakat == 1) {
          questions.add(
            PracticeQuestion(
              id: 'q_ruku_count_${step.id}',
              stepIndex: i,
              type: PracticeQuestionType.howManyTimes,
              promptBn: 'রুকুতে তাসবীহটি সাধারণত কমপক্ষে কতবার পড়তে হয়?',
              options: const [
                PracticeOption(
                  id: 'c_3',
                  labelBn: '৩ বার (বা ৫, ৭ বার বিজোড় সংখ্যায়)',
                  isCorrect: true,
                ),
                PracticeOption(id: 'c_2', labelBn: '২ বার', isCorrect: false),
                PracticeOption(id: 'c_4', labelBn: '৪ বার', isCorrect: false),
              ],
              correctExplanationBn: 'রুকু ও সেজদায় কমপক্ষে ৩ বার তাসবীহ পড়া সুন্নত। ৫ বা ৭ বার পড়া আরও উত্তম।',
              fiqhImpact: MistakeFiqhImpact.sunnahOrMustahab,
              hintBn: 'বিজোড় সংখ্যায় ন্যূনতম ৩ বার।',
              ruleSlug: 'sunnat-mustahab',
            ),
          );
        }
      }

      // 5. Qawma posture
      if (step.posture == Posture.qawma && step.rakat == 1) {
        questions.add(
          PracticeQuestion(
            id: 'q_qawma_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.whatRecitation,
            promptBn: 'রুকু থেকে সোজা হয়ে দাঁড়ানোর সময় ইমাম বা একাকী মুসল্লি কী বলবেন?',
            options: const [
              PracticeOption(
                id: 'opt_sami',
                labelBn: "সামি'আল্লাহু লিমান হামিদাহ",
                arabicText: 'سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ',
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_akbar',
                labelBn: 'আল্লাহু আকবার',
                arabicText: 'اللَّهُ أَكْبَرُ',
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_bismillah',
                labelBn: 'বিসমিল্লাহির রহমানির রহিম',
                arabicText: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                isCorrect: false,
              ),
            ],
            correctExplanationBn: 'রুকু থেকে ওঠার সময় তাসমী\' ("সামি\'আল্লাহু লিমান হামিদাহ") বলা সুন্নত এবং সোজা হয়ে স্থির থাকা ওয়াজিব।',
            fiqhImpact: MistakeFiqhImpact.requiresSajdaSahu,
            hintBn: '"আল্লাহ শুনেছেন যিনি তাঁর প্রশংসা করেছেন"।',
            ruleSlug: 'wajibat',
          ),
        );
      }

      // 6. Sajda posture
      if (step.posture == Posture.sajda &&
          (step.id.endsWith('sajda-1') || step.id.contains('sajda-1')) &&
          step.rakat == 1) {
        questions.add(
          PracticeQuestion(
            id: 'q_sajda_tasbih_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.whatRecitation,
            promptBn: 'সেজদায় গিয়ে কোন তাসবীহ পাঠ করতে হয়?',
            options: const [
              PracticeOption(
                id: 'opt_sajda_tasbih',
                labelBn: "সুবহানা রাব্বিয়াল আ'লা",
                arabicText: 'سُبْحَانَ رَبِّيَ الأَعْلَى',
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_ruku_tasbih',
                labelBn: 'সুবহানা রাব্বিয়াল আজীম',
                arabicText: 'سُبْحَانَ رَبِّيَ الْعَظِيمِ',
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_tashahhud',
                labelBn: 'আত্তাহিয়্যাতু লিল্লাহি',
                arabicText: 'التَّحِيَّاتُ لِلَّهِ',
                isCorrect: false,
              ),
            ],
            correctExplanationBn: 'সেজদায় "সুবহানা রাব্বিয়াল আ\'লা" (আমার সর্বোচ্চ প্রতিপালকের পবিত্রতা ঘোষণা করছি) ৩ বার বলা সুন্নত।',
            fiqhImpact: MistakeFiqhImpact.sunnahOrMustahab,
            hintBn: '"আ\'লা" শব্দের অর্থ যিনি সর্বশ্রেষ্ঠ ও সর্বোচ্চ।',
            ruleSlug: 'sunnat-mustahab',
          ),
        );
      }

      // 7. Sit or Stand after 2nd Sajda
      if (step.posture == Posture.sajda &&
          (step.id.endsWith('sajda-2') || step.id.contains('sajda-2')) &&
          step.rakat != null) {
        final currentRakat = step.rakat!;
        final isEndOfPrayer = currentRakat == totalRakats;
        final isFirstSitting = currentRakat == 2 && totalRakats > 2;

        if (currentRakat == 1 && totalRakats > 1) {
          questions.add(
            PracticeQuestion(
              id: 'q_sit_stand_r1',
              stepIndex: i,
              type: PracticeQuestionType.sitOrStand,
              promptBn: '১ম রাকাতের ২য় সেজদা শেষ করে এখন কী করবেন?',
              options: const [
                PracticeOption(
                  id: 'opt_stand',
                  labelBn: 'সোজা দাঁড়িয়ে ২য় রাকাত শুরু করবেন',
                  posture: Posture.qiyamHandsFolded,
                  isCorrect: true,
                ),
                PracticeOption(
                  id: 'opt_sit',
                  labelBn: 'বসে তাশাহহুদ পড়বেন',
                  posture: Posture.qada,
                  isCorrect: false,
                ),
              ],
              correctExplanationBn: '১ম রাকাতের পর কোন বৈঠক নেই, সরাসরি দ্বিতীয় রাকাতের জন্য দাঁড়াতে হবে।',
              fiqhImpact: MistakeFiqhImpact.requiresSajdaSahu,
              hintBn: 'প্রথম রাকাতে বৈঠক করতে হয় না।',
              ruleSlug: 'wajibat',
            ),
          );
        } else if (isFirstSitting) {
          questions.add(
            PracticeQuestion(
              id: 'q_sit_stand_r2',
              stepIndex: i,
              type: PracticeQuestionType.sitOrStand,
              promptBn: '২য় রাকাতের ২য় সেজদা শেষ করে এখন কী করবেন?',
              options: const [
                PracticeOption(
                  id: 'opt_sit',
                  labelBn: 'বসে ১ম বৈঠক (তাশাহহুদ) করবেন',
                  posture: Posture.qada,
                  isCorrect: true,
                ),
                PracticeOption(
                  id: 'opt_stand',
                  labelBn: 'না বসে সরাসরি ৩য় রাকাতে দাঁড়িয়ে যাবেন',
                  posture: Posture.qiyamHandsFolded,
                  isCorrect: false,
                ),
              ],
              correctExplanationBn: '৩ বা ৪ রাকাতবিশিষ্ট নামাজে ২য় রাকাতের পর প্রথম বৈঠক (কায়দায়ে উলা) ওয়াজিব। ভুলে দাঁড়িয়ে গেলে সেজদায়ে সাহু ওয়াজিব হয়।',
              fiqhImpact: MistakeFiqhImpact.requiresSajdaSahu,
              hintBn: '২ রাকাতের পর তাশাহহুদ পাঠের জন্য বসতে হয়।',
              ruleSlug: 'wajibat',
            ),
          );
        } else if (isEndOfPrayer) {
          questions.add(
            PracticeQuestion(
              id: 'q_sit_stand_final',
              stepIndex: i,
              type: PracticeQuestionType.sitOrStand,
              promptBn: 'শেষ রাকাতের ২য় সেজদা সম্পন্ন করে এখন কী করবেন?',
              options: const [
                PracticeOption(
                  id: 'opt_sit',
                  labelBn:
                      'শেষ বৈঠকে বসে তাশাহহুদ, দুরুদ ও দোয়া মাসুরা পড়বেন',
                  posture: Posture.qada,
                  isCorrect: true,
                ),
                PracticeOption(
                  id: 'opt_stand',
                  labelBn: 'ভুলবশত আরও এক রাকাতের জন্য দাঁড়িয়ে যাবেন',
                  posture: Posture.qiyamHandsFolded,
                  isCorrect: false,
                ),
              ],
              correctExplanationBn: 'শেষ বৈঠক (কায়দায়ে আখিরাহ) নামাজের রুকন বা ফরজ। তাশাহহুদ পরিমাণ বসা ফরজ।',
              fiqhImpact: MistakeFiqhImpact.invalidatesSalah,
              hintBn: 'নামাজের সমাপ্তির জন্য শেষ বৈঠকে বসতে হয়।',
              ruleSlug: 'shurut-arkan',
            ),
          );
        }
      }

      // 8. Tashahhud Finger Raising
      if (step.posture == Posture.tashahhudFingerRaised) {
        questions.add(
          PracticeQuestion(
            id: 'q_finger_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.whatRecitation,
            promptBn:
                'তাশাহহুদে শাহাদাত আঙুল কখন উঠাতে হয় এবং কখন নামাতে হয়?',
            options: const [
              PracticeOption(
                id: 'opt_ashhadu',
                labelBn: '"আশহাদু আল্লা ইলাহা" বলার সময় আঙুল উঠানো এবং "ইল্লাল্লাহ" বলার সময় নামানো',
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_whole_time',
                labelBn: 'পুরো তাশাহহুদ চলাকালে সর্বদা আঙুল নাড়তে থাকা',
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_no_raise',
                labelBn: 'আঙুল একেবারেই না উঠানো',
                isCorrect: false,
              ),
            ],
            correctExplanationBn: 'হানাফী মাযহাব অনুযায়ী তাওহীদের সাক্ষ্য দেওয়ার সময় ("লা ইলাহা") শাহাদাত আঙুল উঠানো এবং স্বীকৃতি ("ইল্লাল্লাহ") দেওয়ার সময় নামানো সুন্নত।',
            fiqhImpact: MistakeFiqhImpact.sunnahOrMustahab,
            hintBn: 'তাওহীদ বা একত্ববাদের সাক্ষ্যের মুহূর্তে আঙুল উঠানো হয়।',
            ruleSlug: 'sunnat-mustahab',
          ),
        );
      }

      // 9. Salam at conclusion
      if (step.posture == Posture.salamRight && nextStep != null) {
        questions.add(
          PracticeQuestion(
            id: 'q_salam_${step.id}',
            stepIndex: i,
            type: PracticeQuestionType.nextPosture,
            promptBn: 'নামাজ সমাপ্তির জন্য প্রথমে কোন দিকে সালাম ফেরাতে হয়?',
            options: const [
              PracticeOption(
                id: 'opt_salam_right',
                labelBn: 'ডান দিকে "আসসালামু আলাইকুম ওয়া রাহমাতুল্লাহ"',
                posture: Posture.salamRight,
                isCorrect: true,
              ),
              PracticeOption(
                id: 'opt_salam_left',
                labelBn: 'প্রথমে বাম দিকে সালাম ফেরানো',
                posture: Posture.salamLeft,
                isCorrect: false,
              ),
              PracticeOption(
                id: 'opt_stand_up',
                labelBn: 'সালাম না ফিরিয়ে সরাসরি উঠে দাঁড়ানো',
                isCorrect: false,
              ),
            ],
            correctExplanationBn: 'প্রথমে ডান কাঁধের দিকে মুখ ঘুরিয়ে সালাম ফেরানো এবং তারপর বাম দিকে সালাম ফেরানো ওয়াজিব।',
            fiqhImpact: MistakeFiqhImpact.requiresSajdaSahu,
            hintBn: 'সকল ভালো কাজ ডান দিক থেকে শুরু করা সুন্নাত।',
            ruleSlug: 'wajibat',
          ),
        );
      }
    }

    return questions;
  }

  /// Calculates badge unlocked when user masters a prayer.
  String? evaluateBadge({
    required String prayerSlug,
    required int scorePercent,
    required PracticeDifficulty difficulty,
  }) {
    if (scorePercent < 90) return null;

    final prayerName = switch (prayerSlug) {
      'fajr' => 'ফজর আয়ত্ত',
      'dhuhr' => 'যোহর আয়ত্ত',
      'asr' => 'আসর আয়ত্ত',
      'maghrib' => 'মাগরিব আয়ত্ত',
      'isha' => 'ইশা আয়ত্ত',
      'witr' => 'বিতর আয়ত্ত',
      'tahajjud' => 'তাহাজ্জুদ আয়ত্ত',
      _ => 'নামাজ আয়ত্ত',
    };

    return difficulty == PracticeDifficulty.expert
        ? '🏆 $prayerName (দক্ষ)'
        : '⭐ $prayerName';
  }
}

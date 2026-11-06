// Wudu Simulator Engine (Pure Dart - No Flutter imports).

import 'package:musalli/features/wudu/domain/wudu_models.dart';

/// Pure Dart engine providing the authentic wudu timeline and sequencing practice.
class WuduEngine {
  const WuduEngine();

  /// Builds the full chronological timeline for Wudu according to the Hanafi school.
  WuduTimeline buildTimeline([WuduConfig config = WuduConfig.standard]) {
    final steps = <WuduStep>[];
    int order = 1;

    // 1. Niyyah & Bismillah
    steps.add(
      WuduStep(
        id: WuduStepId.niyyahAndBismillah,
        order: order++,
        titleBn: 'নিয়্যত ও বিসমিল্লাহ',
        subtitleBn: 'পবিত্রতা অর্জনের উদ্দেশ্যে নিয়ত করা ও বিসমিল্লাহ বলা',
        instructionBn: 'উঁচু ও পরিষ্কার স্থানে কিবলামুখী হয়ে বসুন। অন্তরে অপবিত্রতা দূর ও নামাজ আদায়ের নিয়ত করে "বিসমিল্লাহির রাহমানির রাহিম" বলে অজু শুরু করুন।',
        ruling: WuduRuling.sunnat,
        repeatCount: 1,
        waterTargetArea: WaterTargetArea.none,
        arabicDua: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
        pronunciationBn: 'বিসমিল্লাহির রাহমানির রাহীম',
        meaningBn: 'পরম করুণাময় অসীম দয়ালু আল্লাহর নামে শুরু করছি।',
      ),
    );

    // 2. Wash Hands
    steps.add(
      WuduStep(
        id: WuduStepId.washHands,
        order: order++,
        titleBn: 'দুই হাত কব্জি পর্যন্ত ধোয়া',
        subtitleBn: 'উভয় হাত আঙুলের ফাঁকসহ কব্জি পর্যন্ত ধৌত করা',
        instructionBn: 'প্রথমে ডান হাত কব্জি পর্যন্ত ৩ বার এবং তারপর বাম হাত কব্জি পর্যন্ত ৩ বার ভালো করে ধৌত করুন। আঙুলগুলো খিলাল করুন।',
        ruling: WuduRuling.sunnat,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.hands,
      ),
    );

    // 3. Rinse Mouth (Kulli)
    steps.add(
      WuduStep(
        id: WuduStepId.rinseMouth,
        order: order++,
        titleBn: 'কুলি করা ও মিসওয়াক',
        subtitleBn: 'ডান হাতে পানি নিয়ে ৩ বার ভালো করে কুলি করা',
        instructionBn: 'ডান হাতে পানি নিয়ে ৩ বার মুখে পানি দিন ও কুলি করুন। দাঁতে মিসওয়াক করুন। রোজা না থাকলে গড়গড়া করা সুন্নাত।',
        ruling: WuduRuling.sunnat,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.mouth,
      ),
    );

    // 4. Sniff Water in Nose
    steps.add(
      WuduStep(
        id: WuduStepId.sniffWaterNose,
        order: order++,
        titleBn: 'নাকে পানি দেওয়া',
        subtitleBn: 'ডান হাতে নাকে পানি টেনে বাম হাতে পরিষ্কার করা',
        instructionBn: 'ডান হাত দিয়ে ৩ বার নাকে পানি টানুন (নরম অংশ পর্যন্ত) এবং বাম হাত দিয়ে নাক ঝেড়ে পরিষ্কার করুন।',
        ruling: WuduRuling.sunnat,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.nose,
      ),
    );

    // 5. Wash Face (FARD 1)
    steps.add(
      WuduStep(
        id: WuduStepId.washFace,
        order: order++,
        titleBn: 'সমস্ত মুখমণ্ডল ধৌত করা',
        subtitleBn:
            'কপালের চুলের গোড়া থেকে থুতনির নিচ এবং এক কানের লতি থেকে অন্য কান',
        instructionBn: 'কপালের স্বাভাবিক চুলের স্থান থেকে থুতনির নিচ পর্যন্ত এবং এক কানের লতি থেকে অপর কানের লতি পর্যন্ত সম্পূর্ণ মুখ ৩ বার পানি দিয়ে ধৌত করুন। কোন অংশ যেন শুকনো না থাকে। (একবার ধোয়া ফরজ, ৩ বার সুন্নাত)',
        ruling: WuduRuling.fard,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.face,
      ),
    );

    // 6. Wash Right Arm (FARD 2)
    steps.add(
      WuduStep(
        id: WuduStepId.washRightArm,
        order: order++,
        titleBn: 'ডান হাত কনুইসহ ধোয়া',
        subtitleBn: 'আঙুলের ডগা থেকে কনুইয়ের ওপর পর্যন্ত সম্পূর্ণ ধৌত করা',
        instructionBn: 'ডান হাতের আঙুলের ডগা থেকে শুরু করে কনুই পর্যন্ত (কনুইয়ের সামান্য ওপরসহ) ৩ বার ভালো করে পানি ঢেলে ধৌত করুন।',
        ruling: WuduRuling.fard,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.arms,
      ),
    );

    // 7. Wash Left Arm (FARD 2)
    steps.add(
      WuduStep(
        id: WuduStepId.washLeftArm,
        order: order++,
        titleBn: 'বাম হাত কনুইসহ ধোয়া',
        subtitleBn: 'আঙুলের ডগা থেকে কনুইয়ের ওপর পর্যন্ত সম্পূর্ণ ধৌত করা',
        instructionBn: 'একইভাবে বাম হাতের আঙুলের ডগা থেকে কনুইসহ ৩ বার পানি ঢেলে ভালোভাবে ধৌত করুন।',
        ruling: WuduRuling.fard,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.arms,
      ),
    );

    // 8. Masah Head (FARD 3)
    steps.add(
      WuduStep(
        id: WuduStepId.masahHead,
        order: order++,
        titleBn: 'মাথা মাসেহ করা',
        subtitleBn: 'উভয় হাত ভিজিয়ে মাথার সামনের দিক থেকে পেছনে টেনে নেওয়া',
        instructionBn: 'উভয় হাত নতুন পানি দিয়ে ভিজিয়ে মাথার সম্মুখ থেকে পেছনের দিক পর্যন্ত সম্পূর্ণ মাথা একবার মাসেহ করুন। (মাথার চার ভাগের এক ভাগ মাসেহ করা ফরজ, পুরো মাথা মাসেহ সুন্নাত)',
        ruling: WuduRuling.fard,
        repeatCount: 1,
        waterTargetArea: WaterTargetArea.head,
      ),
    );

    // 9. Masah Ears
    steps.add(
      WuduStep(
        id: WuduStepId.masahEars,
        order: order++,
        titleBn: 'কান মাসেহ করা',
        subtitleBn:
            'শাহাদাত আঙুল দিয়ে কানের ভেতর ও বৃদ্ধাঙ্গুলি দিয়ে পেছনের অংশ',
        instructionBn: 'মাথা মাসেহ করার অবশিষ্ট ভেজা হাতে তর্জনী আঙুল দিয়ে কানের ভেতর এবং বৃদ্ধাঙ্গুলি দিয়ে কানের পিঠ (পেছন) মাসেহ করুন।',
        ruling: WuduRuling.sunnat,
        repeatCount: 1,
        waterTargetArea: WaterTargetArea.ears,
      ),
    );

    // 10. Masah Neck (Mustahab)
    if (config.includeNeckMasah) {
      steps.add(
        WuduStep(
          id: WuduStepId.masahNeck,
          order: order++,
          titleBn: 'গর্দান (ঘাড়) মাসেহ করা',
          subtitleBn: 'হাতের তালুর উল্টো পিঠ দিয়ে ঘাড়ের পেছনের অংশ মাসেহ করা',
          instructionBn: 'উভয় হাতের আঙুলের উল্টো পিঠ দিয়ে ঘাড়ের পেছনের অংশ মাসেহ করুন। গলা বা কণ্ঠনালী মাসেহ করা নিষেধ।',
          ruling: WuduRuling.mustahab,
          repeatCount: 1,
          waterTargetArea: WaterTargetArea.neck,
        ),
      );
    }

    // 11. Wash Right Foot (FARD 4)
    steps.add(
      WuduStep(
        id: WuduStepId.washRightFoot,
        order: order++,
        titleBn: 'ডান পা টাখনুসহ ধোয়া',
        subtitleBn: 'আঙুলের ফাঁক খিলাল করে টাখনু ও গোড়ালিসহ ধৌত করা',
        instructionBn: 'বাম হাতের কনিষ্ঠা আঙুল দিয়ে ডান পায়ের আঙুলের ভেতর খিলাল করে টাখনুর ওপর পর্যন্ত ৩ বার ভালোভাবে ধৌত করুন। গোড়ালি যেন শুকনো না থাকে।',
        ruling: WuduRuling.fard,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.feet,
      ),
    );

    // 12. Wash Left Foot (FARD 4)
    steps.add(
      WuduStep(
        id: WuduStepId.washLeftFoot,
        order: order++,
        titleBn: 'বাম পা টাখনুসহ ধোয়া',
        subtitleBn: 'আঙুলের ফাঁক খিলাল করে টাখনু ও গোড়ালিসহ ধৌত করা',
        instructionBn: 'একইভাবে বাম পায়ের আঙুলগুলো খিলাল করে টাখনুর ওপর পর্যন্ত ৩ বার ভালোভাবে পানি দিয়ে ধৌত করুন।',
        ruling: WuduRuling.fard,
        repeatCount: 3,
        waterTargetArea: WaterTargetArea.feet,
      ),
    );

    // 13. Dua After Wudu
    if (config.includeDuas) {
      steps.add(
        WuduStep(
          id: WuduStepId.duaAfterWudu,
          order: order++,
          titleBn: 'অজুর সমাপ্তি ও দোয়া',
          subtitleBn: 'কিবলামুখী হয়ে কালিমায়ে শাহাদাত ও তওবার দোয়া পাঠ',
          instructionBn: 'অজু সমাপ্তির পর কিবলামুখী হয়ে দাঁড়িয়ে বা বসে আকাশ পানে চেয়ে কালিমায়ে শাহাদাত পাঠ করুন। জান্নাতের ৮টি দরজা উন্মুক্ত হওয়ার সুসংবাদ রয়েছে।',
          ruling: WuduRuling.sunnat,
          repeatCount: 1,
          waterTargetArea: WaterTargetArea.none,
          arabicDua: 'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ. اللَّهُمَّ اجْعَلْنِي مِنَ التَّوَّابِينَ وَاجْعَلْنِي مِنَ الْمُتَطَهِّرِينَ',
          pronunciationBn: "আশহাদু আল্লা ইলাহা ইল্লাল্লাহু ওয়াহদাহু লা শারীকা লাহু, ওয়া আশহাদু আন্না মুহাম্মাদান আবদুহু ওয়া রাসূলুহু। আল্লাহুম্মাজ'আলনী মিনাত তাওওয়াবীনা ওয়াজ'আলনী মিনাল মুতাত্বাহহিরীন।",
          meaningBn: 'আমি সাক্ষ্য দিচ্ছি আল্লাহ ছাড়া কোনো ইলাহ নেই, তিনি এক ও তাঁর কোনো শরিক নেই। আরও সাক্ষ্য দিচ্ছি মুহাম্মদ (সা.) তাঁর বান্দা ও রাসূল। হে আল্লাহ! আমাকে তওবাকারীদের অন্তর্ভুক্ত করুন এবং আমাকে পবিত্রতা অর্জনকারীদের অন্তর্ভুক্ত করুন।',
        ),
      );
    }

    final fardCount = steps.where((s) => s.ruling == WuduRuling.fard).length;
    final sunnatCount = steps
        .where((s) => s.ruling == WuduRuling.sunnat)
        .length;
    final mustahabCount = steps
        .where((s) => s.ruling == WuduRuling.mustahab)
        .length;

    return WuduTimeline(
      steps: steps,
      fardCount: fardCount,
      sunnatCount: sunnatCount,
      mustahabCount: mustahabCount,
    );
  }

  /// Generates interactive practice questions to test wudu sequencing and knowledge of the 4 Fards.
  List<WuduPracticeQuestion> generatePracticeQuestions() {
    return const [
      WuduPracticeQuestion(
        id: 'wudu_fard_count',
        promptBn:
            'কুরআনুল কারীম (সূরা মায়িদা: ৬) অনুযায়ী অজুর মূল ফরজ কয়টি?',
        options: ['৪টি', '৩টি', '৫টি', '৭টি'],
        correctIndex: 0,
        explanationBn: 'অজুর ফরজ মোট ৪টি: ১. মুখমণ্ডল ধোয়া, ২. কনুইসহ উভয় হাত ধোয়া, ৩. মাথার এক-চতুর্থাংশ মাসেহ করা, ৪. টাখনুসহ উভয় পা ধোয়া।',
        isFardQuestion: true,
      ),
      WuduPracticeQuestion(
        id: 'wudu_seq_after_hands',
        promptBn:
            'দুই হাত কব্জি পর্যন্ত ৩ বার ধৌত করার পর পরবর্তী সুন্নত ধাপ কোনটি?',
        options: [
          'কুলি করা ও মিসওয়াক করা',
          'মুখে পানি দেওয়া',
          'নাকে পানি দেওয়া',
        ],
        correctIndex: 0,
        explanationBn: 'হাত ধোয়ার পর ৩ বার ডান হাতে পানি নিয়ে কুলি করা ও মিসওয়াক করা সুন্নাত।',
        isFardQuestion: false,
      ),
      WuduPracticeQuestion(
        id: 'wudu_seq_after_face',
        promptBn: 'সম্পূর্ণ মুখমণ্ডল ধৌত করার পর কোন অঙ্গটি ধৌত করতে হয়?',
        options: ['হাত কনুই পর্যন্ত ধোয়া', 'মাথা মাসেহ করা', 'পা ধোয়া'],
        correctIndex: 0,
        explanationBn: 'মুখ ধোয়ার পর প্রথমে ডান হাত কনুইসহ এবং তারপর বাম হাত কনুইসহ ধোয়া ফরজ।',
        isFardQuestion: true,
      ),
      WuduPracticeQuestion(
        id: 'wudu_masah_limit',
        promptBn: 'অজুতে মাথার কতটুকু অংশ মাসেহ করা ফরজ?',
        options: [
          'অন্তত চার ভাগের এক ভাগ (১/৪)',
          'পুরো মাথা',
          'কেবল পেছনের অংশ',
        ],
        correctIndex: 0,
        explanationBn: 'হানাফী মাযহাব অনুযায়ী মাথার চার ভাগের এক ভাগ মাসেহ করা ফরজ এবং পুরো মাথা একবার মাসেহ করা সুন্নাত।',
        isFardQuestion: true,
      ),
      WuduPracticeQuestion(
        id: 'wudu_fard_identify',
        promptBn: 'নিচের কোনটি অজুর ৪টি ফরজের একটি?',
        options: [
          'টাখনুসহ দুই পা ধোয়া',
          'কুলি করা',
          'ঘাড় মাসেহ করা',
          'বিসমিল্লাহ বলা',
        ],
        correctIndex: 0,
        explanationBn:
            'টাখনুসহ পা ধোয়া অজুর ফরজ। বাকিগুলো সুন্নাত বা মুস্তাহাব।',
        isFardQuestion: true,
      ),
    ];
  }
}

/// Step-by-step instruction for a masbuq make-up rakat.
class MasbuqStep {
  const MasbuqStep({
    required this.rakatNumber,
    required this.title,
    required this.recitations,
    required this.actions,
    required this.mustSitAfterSajda,
    required this.sittingType,
    required this.fiqhNote,
  });

  /// The make-up rakat sequence number (১ম কাযা রাকাত, ২য় কাযা রাকাত, ইত্যাদি).
  final int rakatNumber;

  /// Title of this make-up rakat.
  final String title;

  /// Recitation checklist for this rakat.
  final List<String> recitations;

  /// Physical movement instructions.
  final List<String> actions;

  /// Whether the masbuq must sit for Qa'dah after completing the sajdas.
  final bool mustSitAfterSajda;

  /// 'first' (তাশাহহুদ পর্যন্ত), 'final' (তাশাহহুদ, দরূদ ও দু'আ মাসূরা সহ), or 'none'.
  final String sittingType;

  /// Special Hanafi fiqh explanation for this rakat.
  final String fiqhNote;
}

/// Complete plan generated for a Masbuq worshipper.
class MasbuqPlan {
  const MasbuqPlan({
    required this.prayerNameBn,
    required this.totalRakats,
    required this.joinedRakat,
    required this.missedRakatsCount,
    required this.initialAction,
    required this.steps,
    required this.generalRuleBn,
    required this.reference,
  });

  final String prayerNameBn;
  final int totalRakats;
  final int joinedRakat;
  final int missedRakatsCount;
  final String initialAction;
  final List<MasbuqStep> steps;
  final String generalRuleBn;
  final String reference;
}

/// Pure domain calculator for Masbuq (ইমামের সাথে দেরিতে শরিক হওয়া মুসল্লি).
class MasbuqEngine {
  const MasbuqEngine._();

  /// Calculates the exact step-by-step make-up routine for a masbuq.
  static MasbuqPlan calculate({
    required String prayerSlug,
    required int joinedRakat,
    bool joinedBeforeRuku = true,
  }) {
    final (String nameBn, int totalRakats) = switch (prayerSlug) {
      'fajr' => ('ফজর', 2),
      'maghrib' => ('মাগরিব', 3),
      'jumuah' => ('জুমআ', 2),
      _ => ('যোহর / আসর / ইশা', 4),
    };

    // If joined in rakat N after ruku, the masbuq missed rakat N as well.
    final effectiveJoinedRakat = joinedBeforeRuku
        ? joinedRakat
        : joinedRakat + 1;
    final missedCount = (effectiveJoinedRakat - 1).clamp(0, totalRakats);

    if (missedCount <= 0) {
      return MasbuqPlan(
        prayerNameBn: nameBn,
        totalRakats: totalRakats,
        joinedRakat: joinedRakat,
        missedRakatsCount: 0,
        initialAction: 'আপনি প্রথম রাকাতের রুকু পাওয়ার কারণে কোনো রাকাত কাযা নেই। ইমামের সাথে সাধারণ নিয়মে সালাম ফিরিয়ে নামাজ সম্পন্ন করুন।',
        steps: const [],
        generalRuleBn: 'রুকু পেয়ে গেলে সেই রাকাত পাওয়া গণ্য হয়।',
        reference: 'সহীহ বুখারী ৭৯০; ফাতাওয়া শামী ১/৫৯৫',
      );
    }

    const initialAction =
        'ইমাম সাহেব শেষ বৈঠকে উভয় দিকে সালাম সম্পন্ন করার পর আপনি সালাম না ফিরিয়ে "আল্লাহু আকবার" বলে দাঁড়িয়ে যাবেন।';

    final steps = <MasbuqStep>[];

    // CASE 1: 2-Rakat Prayers (Fajr / Jumu'ah)
    if (totalRakats == 2 && missedCount == 1) {
      steps.add(
        const MasbuqStep(
          rakatNumber: 1,
          title: 'ছুটে যাওয়া ১ম রাকাত আদায়',
          recitations: [
            'ছানা (সুবহানাকাল্লাহুম্মা...) পড়া ওয়াজিব/সুন্নাত',
            "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
            'সূরা আল-ফাতিহা',
            'যেকোনো একটি সূরা বা কমপক্ষে ৩টি ছোট আয়াত মিলানো',
          ],
          actions: [
            'ইমামের সালামের পর সোজা দাঁড়িয়ে হাত বাঁধুন।',
            'ছানা, তাউজ, তাসমিয়াহ পড়ে সূরা ফাতিহা ও অন্য একটি সূরা পাঠ করুন।',
            'স্বাভাবিকভাবে রুকু ও দুটি সিজদা সম্পন্ন করুন।',
            'দ্বিতীয় সিজদার পর শেষ বৈঠকে বসুন।',
          ],
          mustSitAfterSajda: true,
          sittingType: 'final',
          fiqhNote: "এটি আপনার ২য় ও শেষ রাকাত। তাই এতে তাশাহহুদ, দরূদ ও দু'আ মাসূরা পড়ে ডানে-বামে সালাম ফিরিয়ে নামাজ শেষ করবেন।",
        ),
      );
    }
    // CASE 2: 3-Rakat Prayer (Maghrib)
    else if (totalRakats == 3) {
      if (missedCount == 1) {
        // Missed Rakat 1 only (Joined in Rakat 2)
        steps.add(
          const MasbuqStep(
            rakatNumber: 1,
            title: 'ছুটে যাওয়া ১ম রাকাত আদায়',
            recitations: [
              'ছানা (সুবহানাকাল্লাহুম্মা...)',
              "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
            ],
            actions: [
              'ইমামের সালামের পর দাঁড়িয়ে হাত বাঁধুন।',
              'ছানা পড়ে সূরা ফাতিহা ও অন্য সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা শেষ করে শেষ বৈঠকে বসুন।',
            ],
            mustSitAfterSajda: true,
            sittingType: 'final',
            fiqhNote: 'ইমামের সাথে ২ রাকাত এবং নিজে ১ রাকাত মিলিয়ে মোট ৩ রাকাত পূর্ণ হলো। শেষ বৈঠকে সালাম ফিরিয়ে নামাজ সম্পন্ন করুন।',
          ),
        );
      } else if (missedCount == 2) {
        // Missed Rakat 1 and 2 (Joined in Rakat 3)
        steps.add(
          const MasbuqStep(
            rakatNumber: 1,
            title: 'কাযা ১ম রাকাত (মোট নামাজের ২য় রাকাত)',
            recitations: [
              'ছানা',
              "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
              'তাশাহহুদ (আত্তাহিয়্যাতু)',
            ],
            actions: [
              'ইমামের সালামের পর সোজা দাঁড়িয়ে হাত বাঁধুন।',
              'ছানা পড়ে সূরা ফাতিহা ও অন্য একটি সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা করুন।',
              'সিজদা শেষে অবশ্যই প্রথম বৈঠকে বসুন এবং তাশাহহুদ পড়ুন।',
            ],
            mustSitAfterSajda: true,
            sittingType: 'first',
            fiqhNote: 'ফিকহি নিয়ম: ইমামের সাথে ৩য় রাকাত পেয়েছিলেন এবং নিজে ১টি পড়লেন, ফলে মোট ২ রাকাত পূর্ণ হলো। তাই এই রাকাতের পর বৈঠক করা ওয়াজিব!',
          ),
        );
        steps.add(
          const MasbuqStep(
            rakatNumber: 2,
            title: 'কাযা ২য় রাকাত (মোট নামাজের ৩য় রাকাত)',
            recitations: [
              'বিসমিল্লাহ',
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
              "তাশাহহুদ, দরূদ ও দু'আ মাসূরা",
            ],
            actions: [
              'তাশাহহুদ শেষে "আল্লাহু আকবার" বলে দাঁড়িয়ে হাত বাঁধুন।',
              'বিসমিল্লাহ পড়ে সূরা ফাতিহা এবং সাথে অন্য একটি সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা সম্পন্ন করুন।',
              "শেষ বৈঠকে বসে তাশাহহুদ, দরূদ ও দু'আ মাসূরা পড়ে সালাম ফিরান।",
            ],
            mustSitAfterSajda: true,
            sittingType: 'final',
            fiqhNote: 'কিরাতের দিক থেকে এটি আপনার দ্বিতীয় রাকাত, তাই এতে সূরা ফাতিহার সাথে অন্য সূরা মিলানো ওয়াজিব!',
          ),
        );
      }
    }
    // CASE 3: 4-Rakat Prayers (Zuhr, Asr, Isha)
    else if (totalRakats == 4) {
      if (missedCount == 1) {
        // Missed Rakat 1 (Joined in Rakat 2)
        steps.add(
          const MasbuqStep(
            rakatNumber: 1,
            title: 'ছুটে যাওয়া ১ম রাকাত আদায়',
            recitations: [
              'ছানা',
              "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
            ],
            actions: [
              'ইমামের সালামের পর দাঁড়িয়ে হাত বাঁধুন।',
              'ছানা পড়ে সূরা ফাতিহা ও সূরা মিলান।',
              'রুকু ও দুটি সিজদা সম্পন্ন করুন।',
              'শেষ বৈঠকে বসে সালাম ফিরান।',
            ],
            mustSitAfterSajda: true,
            sittingType: 'final',
            fiqhNote: 'ইমামের সাথে ৩টি এবং নিজে ১টি মিলিয়ে ৪ রাকাত পূর্ণ হলো।',
          ),
        );
      } else if (missedCount == 2) {
        // Missed Rakat 1 & 2 (Joined in Rakat 3)
        steps.add(
          const MasbuqStep(
            rakatNumber: 1,
            title: 'কাযা ১ম রাকাত (মোট নামাজের ৩য় রাকাত)',
            recitations: [
              'ছানা',
              "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
            ],
            actions: [
              'ইমামের সালামের পর দাঁড়িয়ে হাত বাঁধুন।',
              'ছানা পড়ে সূরা ফাতিহা ও অন্য সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা করুন।',
              'সিজদা শেষে বসবেন না, সরাসরি পরবর্তী রাকাতের জন্য দাঁড়িয়ে যাবেন।',
            ],
            mustSitAfterSajda: false,
            sittingType: 'none',
            fiqhNote: 'ইমামের সাথে ২ রাকাত + নিজে ১ রাকাত = ৩ রাকাত। ৩য় রাকাতে কোনো বৈঠক নেই, তাই সরাসরি দাঁড়িয়ে যাবেন।',
          ),
        );
        steps.add(
          const MasbuqStep(
            rakatNumber: 2,
            title: 'কাযা ২য় রাকাত (মোট নামাজের ৪র্থ রাকাত)',
            recitations: [
              'বিসমিল্লাহ',
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
              "তাশাহহুদ, দরূদ ও দু'আ মাসূরা",
            ],
            actions: [
              'দাঁড়িয়ে বিসমিল্লাহ সহ সূরা ফাতিহা ও অন্য সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা শেষ করুন।',
              "শেষ বৈঠকে বসে তাশাহহুদ, দরূদ ও দু'আ মাসূরা পড়ে সালাম ফিরিয়ে নামাজ শেষ করুন।",
            ],
            mustSitAfterSajda: true,
            sittingType: 'final',
            fiqhNote: 'কিরাতের ক্ষেত্রে এটি আপনার দ্বিতীয় রাকাত হওয়ায় এতেও সূরা মেলাতে হবে।',
          ),
        );
      } else if (missedCount == 3) {
        // Missed Rakat 1, 2 & 3 (Joined in Rakat 4)
        steps.add(
          const MasbuqStep(
            rakatNumber: 1,
            title: 'কাযা ১ম রাকাত (মোট নামাজের ২য় রাকাত)',
            recitations: [
              'ছানা',
              "আ'উযুবিল্লাহ ও বিসমিল্লাহ",
              'সূরা আল-ফাতিহা',
              'অন্য সূরা মিলানো',
              'তাশাহহুদ',
            ],
            actions: [
              'দাঁড়িয়ে ছানা সহ সূরা ফাতিহা ও অন্য সূরা পড়ুন।',
              'রুকু ও দুটি সিজদা করুন।',
              'সিজদা শেষে অবশ্যই প্রথম বৈঠকে বসুন এবং তাশাহহুদ পড়ুন।',
            ],
            mustSitAfterSajda: true,
            sittingType: 'first',
            fiqhNote: 'ইমামের সাথে ১ রাকাত + নিজে ১ রাকাত = মোট ২ রাকাত পূর্ণ হওয়ায় প্রথম বৈঠক ওয়াজিব।',
          ),
        );
        steps.add(
          const MasbuqStep(
            rakatNumber: 2,
            title: 'কাযা ২য় রাকাত (মোট নামাজের ৩য় রাকাত)',
            recitations: ['বিসমিল্লাহ', 'সূরা আল-ফাতিহা', 'অন্য সূরা মিলানো'],
            actions: [
              'তাশাহহুদ শেষে দাঁড়িয়ে বিসমিল্লাহ সহ ফাতিহা ও অন্য সূরা পড়ুন।',
              'রুকু ও সিজদা সম্পন্ন করুন।',
              'সিজদা শেষে বসবেন না, সরাসরি ৪র্থ রাকাতের জন্য উঠবেন।',
            ],
            mustSitAfterSajda: false,
            sittingType: 'none',
            fiqhNote: 'কিরাতের দিক থেকে এটি আপনার ২য় রাকাত হওয়ায় এতে সূরা মেলাতে হবে, কিন্তু বসা নেই।',
          ),
        );
        steps.add(
          const MasbuqStep(
            rakatNumber: 3,
            title: 'কাযা ৩য় রাকাত (মোট নামাজের ৪র্থ রাকাত)',
            recitations: [
              'বিসমিল্লাহ',
              'সূরা আল-ফাতিহা (অন্য সূরা মিলানো লাগবে না)',
              "তাশাহহুদ, দরূদ ও দু'আ মাসূরা",
            ],
            actions: [
              'দাঁড়িয়ে শুধু বিসমিল্লাহ ও সূরা ফাতিহা পড়ুন (অন্য সূরা নেই)।',
              'রুকু ও দুটি সিজদা করুন।',
              "শেষ বৈঠকে বসে তাশাহহুদ, দরূদ ও দু'আ মাসূরা পড়ে সালাম ফিরান।",
            ],
            mustSitAfterSajda: true,
            sittingType: 'final',
            fiqhNote: 'কিরাতের দিক থেকে এটি আপনার ৩য় বা শেষ রাকাত, তাই এতে সূরা মিলানো ছাড়া শুধু ফাতিহা পড়তে হবে।',
          ),
        );
      }
    }

    return MasbuqPlan(
      prayerNameBn: nameBn,
      totalRakats: totalRakats,
      joinedRakat: joinedRakat,
      missedRakatsCount: missedCount,
      initialAction: initialAction,
      steps: steps,
      generalRuleBn: 'হানাফি মূলনীতি: কিরাতের ক্ষেত্রে মুসল্লি যেন তার নামাজের শুরুতে আছে (সূরা মেলাবে), আর বৈঠকের ক্ষেত্রে সে যেন নামাজের শেষে আছে (মোট রাকাত গণনা করে বসবে)।',
      reference:
          'আল-হিদায়া ১/৭৩; রদ্দুল মুহতার ১/৫৯৬; ফাতাওয়া দারুল উলুম ৪/২২১',
    );
  }
}

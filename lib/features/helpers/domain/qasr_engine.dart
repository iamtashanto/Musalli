/// Outcome result of a Qasr travel assessment.
class QasrResult {
  const QasrResult({
    required this.isMusafir,
    required this.verdictTitle,
    required this.verdictSummary,
    required this.distanceKm,
    required this.stayDays,
    required this.rules,
    required this.prayerAdjustments,
    required this.reference,
  });

  /// Whether the traveler has the shar'i status of a Musafir.
  final bool isMusafir;

  /// Headline title (e.g. "আপনার জন্য কসর পড়া ওয়াজিব").
  final String verdictTitle;

  /// Summary explanation in Bangla.
  final String verdictSummary;

  /// Input distance in kilometers.
  final double distanceKm;

  /// Input intended stay in days.
  final int stayDays;

  /// Crucial fiqh points.
  final List<String> rules;

  /// Prayer-by-prayer breakdown (Zuhr, Asr, Maghrib, Isha, Fajr).
  final Map<String, String> prayerAdjustments;

  /// Canonical reference.
  final String reference;
}

/// Pure domain calculator for Qasr (মুসাফিরের কসর নামাজ).
class QasrEngine {
  const QasrEngine._();

  /// Canonical minimum travel distance in kilometers (৪৮ মাইল ≈ ৭৭.২৫ কিমি).
  static const double minimumDistanceKm = 77.25;

  /// Maximum staying duration in days to remain a Musafir (১৫ দিন).
  static const int maxStayDaysForQasr = 14;

  /// Evaluates whether Qasr applies based on distance, days, and condition.
  static QasrResult calculate({
    required double distanceKm,
    required int stayDays,
    bool isUncertainStay = false,
  }) {
    final distanceSufficient = distanceKm >= minimumDistanceKm;
    final stayIsMusafir = isUncertainStay || (stayDays <= maxStayDaysForQasr);

    if (!distanceSufficient) {
      return QasrResult(
        isMusafir: false,
        verdictTitle: 'কসর নয়, পূর্ণ নামাজ (ইতমাম) পড়তে হবে',
        verdictSummary:
            'আপনার গন্তব্যের দূরত্ব ${distanceKm.toStringAsFixed(1)} কিমি, যা শরীয়তের নির্ধারিত সর্বনিম্ন সফর দূরত্ব (৭৭.২৫ কিমি বা ৪৮ মাইল) থেকে কম। তাই আপনি মুসাফির নন; আপনাকে পূর্ণ ৪ রাকাত নামাজ আদায় করতে হবে।',
        distanceKm: distanceKm,
        stayDays: stayDays,
        rules: const [
          'দূরত্ব ৭৭.২৫ কিমি এর কম হলে শরীয়তে তাকে সফর গণ্য করা হয় না।',
          'যোহর, আসর ও ইশার ৪ রাকাত ফরজ পূর্ণ ৪ রাকাতই পড়তে হবে।',
          'সকল সুন্নাত ও নফল যথারীতি আদায় করবেন।',
        ],
        prayerAdjustments: const {
          'ফজর': '২ রাকাত ফরজ (অপরিবর্তিত)',
          'যোহর': '৪ রাকাত ফরজ (পূর্ণ পড়তে হবে)',
          'আসর': '৪ রাকাত ফরজ (পূর্ণ পড়তে হবে)',
          'মাগরিব': '৩ রাকাত ফরজ (অপরিবর্তিত)',
          'ইশা': '৪ রাকাত ফরজ + ৩ রাকাত বিতর (পূর্ণ পড়তে হবে)',
        },
        reference: 'ফাতাওয়া শামী ২/৫৯৯; বাদায়েউস সানায়ে ১/৯৩',
      );
    }

    if (!stayIsMusafir) {
      return QasrResult(
        isMusafir: false,
        verdictTitle: 'পূর্ণ নামাজ (ইতমাম) পড়তে হবে (মুকীম)',
        verdictSummary: 'দূরত্ব ৭৭.২৫ কিমি এর বেশি হলেও আপনি সেখানে একাধারে ১৫ দিন বা তার বেশি সময় থাকার নিয়্যত করেছেন। হানাফি ফিকহ অনুযায়ী গন্তব্যে পৌঁছামাত্রই আপনি "মুকীম" হয়ে গেছেন; সুতরাং পূর্ণ নামাজ পড়তে হবে।',
        distanceKm: distanceKm,
        stayDays: stayDays,
        rules: const [
          'কোনো শহরে বা গ্রামে একাধারে ১৫ দিন বা তদূর্ধ্ব থাকার দৃঢ় সংকল্প করলে সে মুকীম হয়ে যায়।',
          'তবে যাত্রাপথে যাতায়াতের সময় কসর করবেন; গন্তব্যে পৌঁছে পূর্ণ নামাজ পড়বেন।',
          'যোহর, আসর ও ইশায় পূর্ণ ৪ রাকাত আদায় আবশ্যক।',
        ],
        prayerAdjustments: const {
          'ফজর': '২ রাকাত ফরজ (অপরিবর্তিত)',
          'যোহর': '৪ রাকাত ফরজ (পূর্ণ পড়তে হবে)',
          'আসর': '৪ রাকাত ফরজ (পূর্ণ পড়তে হবে)',
          'মাগরিব': '৩ রাকাত ফরজ (অপরিবর্তিত)',
          'ইশা': '৪ রাকাত ফরজ + ৩ রাকাত বিতর (পূর্ণ পড়তে হবে)',
        },
        reference: 'সহীহ বুখারী ১০৮০; আল-হিদায়া ১/৭৯',
      );
    }

    return QasrResult(
      isMusafir: true,
      verdictTitle: 'আপনার জন্য কসর নামাজ পড়া ওয়াজিব',
      verdictSummary: 'দূরত্ব ৭৭.২৫ কিমি বা তদূর্ধ্ব এবং অবস্থানের নিয়্যত ১৫ দিনের কম হওয়ায় আপনি শরীয়তের দৃষ্টিতে মুসাফির। হানাফি মাযহাবে ৪ রাকাতবিশিষ্ট ফরজ নামাজ সংক্ষিপ্ত করে ২ রাকাত পড়া ওয়াজিব (বাধ্যতামূলক)। ইচ্ছা করে ৪ রাকাত পড়া মাকরূহ তাহরীমী।',
      distanceKm: distanceKm,
      stayDays: stayDays,
      rules: const [
        'যোহর, আসর ও ইশার ৪ রাকাত ফরজ সংক্ষেপ করে ২ রাকাত আদায় করতে হবে।',
        'ফজর (২ রাকাত), মাগরিব (৩ রাকাত) এবং বিতর (৩ রাকাত)-এ কোনো কসর নেই, এগুলো সম্পূর্ণ পড়তে হবে।',
        'চলন্ত অবস্থায় বা তাড়াহুড়ায় সুন্নাত ছেড়ে দেওয়া জায়েয; তবে নিরাপদে কোথাও অবস্থানকালে সুন্নাত পড়ে নেওয়া উত্তম।',
        'মুসাফির যদি স্থানীয় মুকীম ইমামের পেছনে জামাতে শরিক হয়, তবে ইমামের সাথে পূর্ণ ৪ রাকাতই আদায় করবে।',
      ],
      prayerAdjustments: const {
        'ফজর': '২ রাকাত ফরজ (অপরিবর্তিত)',
        'যোহর': '২ রাকাত কসর (৪ রাকাতের স্থলে)',
        'আসর': '২ রাকাত কসর (৪ রাকাতের স্থলে)',
        'মাগরিব': '৩ রাকাত ফরজ (অপরিবর্তিত)',
        'ইশা': '২ রাকাত কসর + ৩ রাকাত বিতর পূর্ণ',
      },
      reference: 'সহীহ মুসলিম ৬৮৬; ফাতাওয়া আলমগীরী ১/১৩৯; রদ্দুল মুহতার ২/১২৩',
    );
  }
}

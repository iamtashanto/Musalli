// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'মুসল্লি — নামাজ শিক্ষা';

  @override
  String get appSubtitle =>
      'সহীহ কুরআন, হাদিস ও হানাফি ফিকহ ভিত্তিক অফলাইন নামাজ গাইড';

  @override
  String get tabHome => 'হোম';

  @override
  String get tabLearn => 'শিখুন';

  @override
  String get tabSimulator => 'সিমুলেটর';

  @override
  String get tabTimes => 'সময়';

  @override
  String get tabMore => 'আরও';

  @override
  String get hanafiBadge => 'হানাফি ফিকহ • বাংলাদেশ';

  @override
  String get designSystemShowcaseTitle => 'ডিজাইন সিস্টেম শোকেস (Dev)';

  @override
  String get errorScreenTitle => 'দুঃখিত, একটি অপ্রত্যাশিত ত্রুটি ঘটেছে';

  @override
  String get errorScreenMessage =>
      'চিন্তার কারণ নেই, আপনার সংরক্ষিত নামাজ ট্র্যাকার ও মুখস্থ সূরার তথ্য নিরাপদ আছে। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get retryButton => 'আবার চেষ্টা করুন';

  @override
  String get prayerDetailTitle => 'নামাজের বিস্তারিত গাইড';

  @override
  String get simulatorQuickStart => 'সিমুলেটর চালু করুন';

  @override
  String get glassQualityLabel => 'গ্লাস ইফেক্ট মান (Glass Quality)';

  @override
  String get glassQualityHigh => 'উচ্চ (High Blur)';

  @override
  String get glassQualityMedium => 'মাঝারি (Medium Blur)';

  @override
  String get glassQualityLow => 'কম র‍্যাম মোড (No Blur)';

  @override
  String get themeModeLabel => 'থিম মোড';

  @override
  String get languageLabel => 'ভাষা (Language)';

  @override
  String get searchPlaceholder => 'নামাজ, সূরা, দোয়া বা মাসআলা খুঁজুন...';
}

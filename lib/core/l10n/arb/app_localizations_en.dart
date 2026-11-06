// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Musalli — Salah Learning';

  @override
  String get appSubtitle =>
      'Offline Salah guide based on Quran, Sahih Hadith & Hanafi Fiqh';

  @override
  String get tabHome => 'Home';

  @override
  String get tabLearn => 'Learn';

  @override
  String get tabSimulator => 'Simulator';

  @override
  String get tabTimes => 'Times';

  @override
  String get tabMore => 'More';

  @override
  String get hanafiBadge => 'Hanafi Fiqh • Bangladesh';

  @override
  String get designSystemShowcaseTitle => 'Design System Showcase (Dev)';

  @override
  String get errorScreenTitle => 'Something went wrong';

  @override
  String get errorScreenMessage =>
      'Don\'t worry, your saved prayer tracker and hifz progress are safe on your device. Please try again.';

  @override
  String get retryButton => 'Try Again';

  @override
  String get prayerDetailTitle => 'Prayer Detail Guide';

  @override
  String get simulatorQuickStart => 'Start Simulator';

  @override
  String get glassQualityLabel => 'Glass Effect Quality';

  @override
  String get glassQualityHigh => 'High (Full Blur)';

  @override
  String get glassQualityMedium => 'Medium (Balanced Blur)';

  @override
  String get glassQualityLow => 'Low RAM Mode (No Blur)';

  @override
  String get themeModeLabel => 'Theme Mode';

  @override
  String get languageLabel => 'Language (ভাষা)';

  @override
  String get searchPlaceholder => 'Search prayers, surahs, duas or masail...';
}

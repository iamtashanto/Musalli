import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In bn, this message translates to:
  /// **'মুসল্লি — নামাজ শিক্ষা'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In bn, this message translates to:
  /// **'সহীহ কুরআন, হাদিস ও হানাফি ফিকহ ভিত্তিক অফলাইন নামাজ গাইড'**
  String get appSubtitle;

  /// No description provided for @tabHome.
  ///
  /// In bn, this message translates to:
  /// **'হোম'**
  String get tabHome;

  /// No description provided for @tabLearn.
  ///
  /// In bn, this message translates to:
  /// **'শিখুন'**
  String get tabLearn;

  /// No description provided for @tabSimulator.
  ///
  /// In bn, this message translates to:
  /// **'সিমুলেটর'**
  String get tabSimulator;

  /// No description provided for @tabTimes.
  ///
  /// In bn, this message translates to:
  /// **'সময়'**
  String get tabTimes;

  /// No description provided for @tabMore.
  ///
  /// In bn, this message translates to:
  /// **'আরও'**
  String get tabMore;

  /// No description provided for @hanafiBadge.
  ///
  /// In bn, this message translates to:
  /// **'হানাফি ফিকহ • বাংলাদেশ'**
  String get hanafiBadge;

  /// No description provided for @designSystemShowcaseTitle.
  ///
  /// In bn, this message translates to:
  /// **'ডিজাইন সিস্টেম শোকেস (Dev)'**
  String get designSystemShowcaseTitle;

  /// No description provided for @errorScreenTitle.
  ///
  /// In bn, this message translates to:
  /// **'দুঃখিত, একটি অপ্রত্যাশিত ত্রুটি ঘটেছে'**
  String get errorScreenTitle;

  /// No description provided for @errorScreenMessage.
  ///
  /// In bn, this message translates to:
  /// **'চিন্তার কারণ নেই, আপনার সংরক্ষিত নামাজ ট্র্যাকার ও মুখস্থ সূরার তথ্য নিরাপদ আছে। অনুগ্রহ করে আবার চেষ্টা করুন।'**
  String get errorScreenMessage;

  /// No description provided for @retryButton.
  ///
  /// In bn, this message translates to:
  /// **'আবার চেষ্টা করুন'**
  String get retryButton;

  /// No description provided for @prayerDetailTitle.
  ///
  /// In bn, this message translates to:
  /// **'নামাজের বিস্তারিত গাইড'**
  String get prayerDetailTitle;

  /// No description provided for @simulatorQuickStart.
  ///
  /// In bn, this message translates to:
  /// **'সিমুলেটর চালু করুন'**
  String get simulatorQuickStart;

  /// No description provided for @glassQualityLabel.
  ///
  /// In bn, this message translates to:
  /// **'গ্লাস ইফেক্ট মান (Glass Quality)'**
  String get glassQualityLabel;

  /// No description provided for @glassQualityHigh.
  ///
  /// In bn, this message translates to:
  /// **'উচ্চ (High Blur)'**
  String get glassQualityHigh;

  /// No description provided for @glassQualityMedium.
  ///
  /// In bn, this message translates to:
  /// **'মাঝারি (Medium Blur)'**
  String get glassQualityMedium;

  /// No description provided for @glassQualityLow.
  ///
  /// In bn, this message translates to:
  /// **'কম র‍্যাম মোড (No Blur)'**
  String get glassQualityLow;

  /// No description provided for @themeModeLabel.
  ///
  /// In bn, this message translates to:
  /// **'থিম মোড'**
  String get themeModeLabel;

  /// No description provided for @languageLabel.
  ///
  /// In bn, this message translates to:
  /// **'ভাষা (Language)'**
  String get languageLabel;

  /// No description provided for @searchPlaceholder.
  ///
  /// In bn, this message translates to:
  /// **'নামাজ, সূরা, দোয়া বা মাসআলা খুঁজুন...'**
  String get searchPlaceholder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

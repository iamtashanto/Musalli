import 'package:musalli/core/utils/bengali_numbers.dart';

/// Formatter for Bengali Calendar, Hijri (Islamic), and Bengali 12h time strings.
class BanglaIslamicDateFormatter {
  const BanglaIslamicDateFormatter._();

  static const List<String> _banglaDays = [
    'সোমবার',
    'মঙ্গলবার',
    'বুধবার',
    'বৃহস্পতিবার',
    'শুক্রবার',
    'শনিবার',
    'রবিবার',
  ];

  static const List<String> _banglaGregorianMonths = [
    'জানুয়ারি',
    'ফেব্রুয়ারি',
    'মার্চ',
    'এপ্রিল',
    'মে',
    'জুন',
    'জুলাই',
    'আগস্ট',
    'সেপ্টেম্বর',
    'অক্টোবর',
    'নভেম্বর',
    'ডিসেম্বর',
  ];

  static const List<String> _hijriMonthsBn = [
    'মুহাররম',
    'সফর',
    'রবিউল আউয়াল',
    'রবিউস সানি',
    'জমাদিউল আউয়াল',
    'জমাদিউস সানি',
    'রজব',
    'শাবান',
    'রমজান',
    'শাওয়াল',
    'জিলকদ',
    'জিলহজ',
  ];

  /// Formats [date] into 12-hour Bangla time string with period:
  /// "সকাল/দুপুর/বিকাল/সন্ধ্যা/রাত".
  /// Examples:
  /// - 05:15 -> "ভোর ৫:১৫"
  /// - 09:30 -> "সকাল ৯:৩০"
  /// - 13:15 -> "দুপুর ১:১৫"
  /// - 16:20 -> "বিকাল ৪:২০"
  /// - 18:05 -> "সন্ধ্যা ৬:০৫"
  /// - 20:30 -> "রাত ৮:৩০"
  static String formatBanglaTime(DateTime date, {bool includeSeconds = false}) {
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;

    String period;
    if (hour >= 4 && hour < 6) {
      period = 'ভোর';
    } else if (hour >= 6 && hour < 12) {
      period = 'সকাল';
    } else if (hour >= 12 && hour < 15) {
      period = 'দুপুর';
    } else if (hour >= 15 && hour < 17) {
      period = 'বিকাল';
    } else if (hour >= 17 && hour < 19) {
      period = 'সন্ধ্যা';
    } else {
      period = 'রাত';
    }

    final h12 = hour % 12 == 0 ? 12 : hour % 12;
    final mStr = minute < 10 ? '০$minute' : BengaliNumbers.toBengali(minute);
    final hStr = BengaliNumbers.toBengali(h12);

    if (includeSeconds) {
      final sStr = second < 10 ? '০$second' : BengaliNumbers.toBengali(second);
      return '$period $hStr:$mStr:$sStr';
    }

    return '$period $hStr:$mStr';
  }

  /// Formats [date] into readable Gregorian-Bangla date, e.g.:
  /// "শুক্রবার, ৬ নভেম্বর ২০২৬"
  static String formatGregorianBangla(DateTime date) {
    final dayName = _banglaDays[date.weekday - 1];
    final dayNum = BengaliNumbers.toBengali(date.day);
    final monthName = _banglaGregorianMonths[date.month - 1];
    final yearNum = BengaliNumbers.toBengali(date.year);

    return '$dayName, $dayNum $monthName $yearNum';
  }

  /// Calculates and formats Hijri date based on astronomical algorithm with
  /// manual [offsetDays] adjustment (+/- 1-2 days).
  ///
  /// Example: "২৩ জমাদিউল আউয়াল ১৪৪৮ হিজরি"
  static String formatHijriDate(DateTime date, {int offsetDays = 0}) {
    final adjusted = date.add(Duration(days: offsetDays));
    final hijri = _gregorianToHijri(adjusted);
    final monthName = _hijriMonthsBn[hijri.month - 1];
    final dayBn = BengaliNumbers.toBengali(hijri.day);
    final yearBn = BengaliNumbers.toBengali(hijri.year);

    return '$dayBn $monthName $yearBn হিজরি';
  }

  /// Approximate astronomical conversion from Gregorian to Islamic (Hijri).
  static ({int year, int month, int day}) _gregorianToHijri(DateTime date) {
    int m = date.month;
    int y = date.year;
    final d = date.day;

    if (m < 3) {
      y -= 1;
      m += 12;
    }

    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    final jd =
        (365.25 * (y + 4716)).floor() +
        (30.6001 * (m + 1)).floor() +
        d +
        b -
        1524.5;

    // Standard epoch offset for Umm al-Qura
    final l = (jd - 1948439.5).round();
    final n = (l / 10631).floor();
    final lPrime = l - 10631 * n + 354;
    final j =
        ((10985 - lPrime) / 5316).floor() *
            ((50 * lPrime + 17719) / 1770).floor() +
        (lPrime / 5670).floor() * ((43 * lPrime + 15238) / 1524).floor();
    final lDoublePrime =
        lPrime -
        ((30 - j) / 15).floor() * ((17719 * j) / 50).floor() -
        (j / 16).floor() * ((15238 * j) / 43).floor() +
        29;
    final hijriMonth = ((24 * lDoublePrime) / 709).floor();
    final hijriDay = lDoublePrime - ((709 * hijriMonth) / 24).floor();
    final hijriYear = 30 * n + j - 30;

    return (
      year: hijriYear.clamp(1400, 1500),
      month: hijriMonth.clamp(1, 12),
      day: hijriDay.clamp(1, 30),
    );
  }

  /// Calculates Bengali solar calendar date (Bangla Academy revised standard).
  static String formatBengaliSolarDate(DateTime date) {
    // Gregorian Pohela Boishakh is April 14
    // Month durations: Boishakh to Bhadro = 31 days (5 months)
    // Ashwin to Falgun = 30 days (6 months)
    // Chaitra = 30 days (31 on leap year)
    final d = date.day;
    final m = date.month;
    final y = date.year;

    int banglaYear = y - 593;
    if (m < 4 || (m == 4 && d < 14)) {
      banglaYear -= 1;
    }

    String banglaMonth = '';
    int banglaDay = 1;

    // Approximate solar calculation
    if (m == 4 && d >= 14) {
      banglaMonth = 'বৈশাখ';
      banglaDay = d - 13;
    } else if (m == 5 && d <= 14) {
      banglaMonth = 'বৈশাখ';
      banglaDay = d + 17;
    } else if (m == 5 && d >= 15) {
      banglaMonth = 'জ্যৈষ্ঠ';
      banglaDay = d - 14;
    } else if (m == 6 && d <= 15) {
      banglaMonth = 'জ্যৈষ্ঠ';
      banglaDay = d + 17;
    } else if (m == 6 && d >= 16) {
      banglaMonth = 'আষাঢ়';
      banglaDay = d - 15;
    } else if (m == 7 && d <= 16) {
      banglaMonth = 'আষাঢ়';
      banglaDay = d + 15;
    } else if (m == 7 && d >= 17) {
      banglaMonth = 'শ্রাবণ';
      banglaDay = d - 16;
    } else if (m == 8 && d <= 16) {
      banglaMonth = 'শ্রাবণ';
      banglaDay = d + 15;
    } else if (m == 8 && d >= 17) {
      banglaMonth = 'ভাদ্র';
      banglaDay = d - 16;
    } else if (m == 9 && d <= 16) {
      banglaMonth = 'ভাদ্র';
      banglaDay = d + 15;
    } else if (m == 9 && d >= 17) {
      banglaMonth = 'আশ্বিন';
      banglaDay = d - 16;
    } else if (m == 10 && d <= 16) {
      banglaMonth = 'আশ্বিন';
      banglaDay = d + 14;
    } else if (m == 10 && d >= 17) {
      banglaMonth = 'কার্তিক';
      banglaDay = d - 16;
    } else if (m == 11 && d <= 15) {
      banglaMonth = 'কার্তিক';
      banglaDay = d + 15;
    } else if (m == 11 && d >= 16) {
      banglaMonth = 'অগ্রহায়ণ';
      banglaDay = d - 15;
    } else if (m == 12 && d <= 15) {
      banglaMonth = 'অগ্রহায়ণ';
      banglaDay = d + 15;
    } else if (m == 12 && d >= 16) {
      banglaMonth = 'পৌষ';
      banglaDay = d - 15;
    } else if (m == 1 && d <= 14) {
      banglaMonth = 'পৌষ';
      banglaDay = d + 16;
    } else if (m == 1 && d >= 15) {
      banglaMonth = 'মাঘ';
      banglaDay = d - 14;
    } else if (m == 2 && d <= 13) {
      banglaMonth = 'মাঘ';
      banglaDay = d + 17;
    } else if (m == 2 && d >= 14) {
      banglaMonth = 'ফাল্গুন';
      banglaDay = d - 13;
    } else if (m == 3 && d <= 14) {
      banglaMonth = 'ফাল্গুন';
      banglaDay = d + 16;
    } else if (m == 3 && d >= 15) {
      banglaMonth = 'চৈত্র';
      banglaDay = d - 14;
    } else {
      banglaMonth = 'চৈত্র';
      banglaDay = d + 17;
    }

    final dayBn = BengaliNumbers.toBengali(banglaDay);
    final yearBn = BengaliNumbers.toBengali(banglaYear);

    return '$dayBn $banglaMonth $yearBn বঙ্গাব্দ';
  }
}

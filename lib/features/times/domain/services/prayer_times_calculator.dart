import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';

/// Pure Dart offline Prayer Times and Islamic Schedule Calculator powered by `adhan_dart`.
class PrayerTimesCalculator {
  const PrayerTimesCalculator._();

  /// Converts our [CalculationMethodOption] into `adhan_dart` [adhan.CalculationParameters].
  static adhan.CalculationParameters getParameters(
    CalculationMethodOption method,
    AsrMadhabOption madhab,
    HighLatitudeRuleOption highLatitudeRule,
  ) {
    adhan.CalculationParameters params;

    switch (method) {
      case CalculationMethodOption.karachi:
        params = adhan.CalculationMethodParameters.karachi();
      case CalculationMethodOption.muslimWorldLeague:
        params = adhan.CalculationMethodParameters.muslimWorldLeague();
      case CalculationMethodOption.egyptian:
        params = adhan.CalculationMethodParameters.egyptian();
      case CalculationMethodOption.ummAlQura:
        params = adhan.CalculationMethodParameters.ummAlQura();
      case CalculationMethodOption.dubai:
        params = adhan.CalculationMethodParameters.dubai();
      case CalculationMethodOption.moonsightingCommittee:
        params = adhan.CalculationMethodParameters.moonsightingCommittee();
      case CalculationMethodOption.northAmerica:
        params = adhan.CalculationMethodParameters.northAmerica();
      case CalculationMethodOption.kuwait:
        params = adhan.CalculationMethodParameters.kuwait();
      case CalculationMethodOption.qatar:
        params = adhan.CalculationMethodParameters.qatar();
      case CalculationMethodOption.singapore:
        params = adhan.CalculationMethodParameters.singapore();
      case CalculationMethodOption.tehran:
        params = adhan.CalculationMethodParameters.tehran();
      case CalculationMethodOption.turkey:
        params = adhan.CalculationMethodParameters.turkiye();
    }

    params.madhab = madhab == AsrMadhabOption.hanafi
        ? adhan.Madhab.hanafi
        : adhan.Madhab.shafi;

    switch (highLatitudeRule) {
      case HighLatitudeRuleOption.seventhOfTheNight:
        params.highLatitudeRule = adhan.HighLatitudeRule.seventhOfTheNight;
      case HighLatitudeRuleOption.twilightAngle:
        params.highLatitudeRule = adhan.HighLatitudeRule.twilightAngle;
      case HighLatitudeRuleOption.middleOfTheNight:
        params.highLatitudeRule = adhan.HighLatitudeRule.middleOfTheNight;
    }

    return params;
  }

  /// Calculates complete daily schedule for a specified [date] and [settings].
  static DailyScheduleTimes calculateDailySchedule(
    DateTime date,
    PrayerTimesSettings settings,
  ) {
    final coords = adhan.Coordinates(
      settings.location.lat,
      settings.location.lng,
    );
    final params = getParameters(
      settings.method,
      settings.madhab,
      settings.highLatitudeRule,
    );

    final pt = adhan.PrayerTimes(
      date: date,
      coordinates: coords,
      calculationParameters: params,
    );
    final sunnah = adhan.SunnahTimes(pt);

    final adj = settings.adjustments;
    final fajr = pt.fajr.add(Duration(minutes: adj.fajr));
    final sunrise = pt.sunrise.add(Duration(minutes: adj.sunrise));
    final dhuhr = pt.dhuhr.add(Duration(minutes: adj.dhuhr));
    final asr = pt.asr.add(Duration(minutes: adj.asr));
    final maghrib = pt.maghrib.add(Duration(minutes: adj.maghrib));
    final isha = pt.isha.add(Duration(minutes: adj.isha));

    // Extra Islamic Times
    // Ishraq: 15 minutes after sunrise
    final ishraq = sunrise.add(const Duration(minutes: 15));

    // Chasht (Duha): ~1/3 interval between sunrise and dhuhr
    final chashtMs =
        sunrise.millisecondsSinceEpoch +
        ((dhuhr.millisecondsSinceEpoch - sunrise.millisecondsSinceEpoch) ~/ 3);
    final chasht = DateTime.fromMillisecondsSinceEpoch(chashtMs);

    // Zawal: 15 minutes before Dhuhr until Dhuhr
    final zawalStart = dhuhr.subtract(const Duration(minutes: 15));
    final zawalEnd = dhuhr;

    // 3 Forbidden Times (হারাম/মাকরূহে তাহরীমী ওয়াক্ত)
    final forbiddenSunrise = ForbiddenTimeSpan(
      start: sunrise,
      end: ishraq,
      nameBn: 'সূর্যোদয়ের নিষিদ্ধ সময়',
      descriptionBn: 'সূর্যোদয়ের সময় — সূর্য দিগন্ত থেকে পুরোপুরি উপরে ওঠার আগ পর্যন্ত (প্রায় ১৫ মিনিট) যেকোনো সালাত আদায় মাকরূহে তাহরীমী।',
    );

    final forbiddenZawal = ForbiddenTimeSpan(
      start: zawalStart,
      end: zawalEnd,
      nameBn: 'দ্বিপ্রহরের নিষিদ্ধ সময় (ইস্তিওয়া)',
      descriptionBn: 'নিস্তব্ধ দ্বিপ্রহর (ইস্তিওয়া) — সূর্য মধ্যাকাশে স্থির থাকার সময় যোহরের ওয়াক্ত শুরুর আগ পর্যন্ত সালাত পড়া নিষিদ্ধ।',
    );

    final forbiddenSunset = ForbiddenTimeSpan(
      start: maghrib.subtract(const Duration(minutes: 15)),
      end: maghrib,
      nameBn: 'সূর্যাস্তের নিষিদ্ধ সময়',
      descriptionBn: 'সূর্যাস্তের সময় — সূর্য হলুদ বর্ণ ধারণ করা থেকে ডোবা পর্যন্ত। তবে ওই দিনের আসর আদায় না থাকলে তা মাকরূহ হলেও পড়ে নিতে হবে।',
    );

    final yyyy = date.year.toString().padLeft(4, '0');
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    final dateKey = '$yyyy-$mm-$dd';

    return DailyScheduleTimes(
      date: date,
      dateKey: dateKey,
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
      tahajjudStart: sunnah.lastThirdOfTheNight,
      ishraq: ishraq,
      chasht: chasht,
      zawalStart: zawalStart,
      zawalEnd: zawalEnd,
      forbiddenSunrise: forbiddenSunrise,
      forbiddenZawal: forbiddenZawal,
      forbiddenSunset: forbiddenSunset,
      sehriEnd: fajr,
      iftar: maghrib,
    );
  }

  /// Evaluates current waqt, countdown to next waqt, and whether currently
  /// in forbidden time.
  static CurrentWaqtStatus getCurrentWaqtStatus(
    DateTime now,
    DailyScheduleTimes today, [
    DailyScheduleTimes? tomorrow,
  ]) {
    // Check 3 forbidden times first
    if (today.forbiddenSunrise.contains(now)) {
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.sunrise,
        currentWaqtNameBn: 'সূর্যোদয় (মাকরূহ সময়)',
        nextWaqt: WaqtType.dhuhr,
        nextWaqtNameBn: 'যোহর',
        nextWaqtTime: today.dhuhr,
        timeRemaining: today.dhuhr.difference(now),
        isForbiddenTime: true,
        forbiddenReasonBn: today.forbiddenSunrise.descriptionBn,
        forbiddenSpan: today.forbiddenSunrise,
      );
    }

    if (today.forbiddenZawal.contains(now)) {
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.dhuhr,
        currentWaqtNameBn: 'ইস্তিওয়া (মাকরূহ সময়)',
        nextWaqt: WaqtType.dhuhr,
        nextWaqtNameBn: 'যোহর',
        nextWaqtTime: today.dhuhr,
        timeRemaining: today.dhuhr.difference(now),
        isForbiddenTime: true,
        forbiddenReasonBn: today.forbiddenZawal.descriptionBn,
        forbiddenSpan: today.forbiddenZawal,
      );
    }

    if (today.forbiddenSunset.contains(now)) {
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.asr,
        currentWaqtNameBn: 'সূর্যাস্ত (মাকরূহ সময়)',
        nextWaqt: WaqtType.maghrib,
        nextWaqtNameBn: 'মাগরিব',
        nextWaqtTime: today.maghrib,
        timeRemaining: today.maghrib.difference(now),
        isForbiddenTime: true,
        forbiddenReasonBn: today.forbiddenSunset.descriptionBn,
        forbiddenSpan: today.forbiddenSunset,
      );
    }

    // Standard Waqt Timeline Determination
    if (now.isBefore(today.fajr)) {
      // Midnight to Fajr -> Still Isha period or Tahajjud
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.isha,
        currentWaqtNameBn: 'তাহাজ্জুদ / এশার শেষ সময়',
        nextWaqt: WaqtType.fajr,
        nextWaqtNameBn: 'ফজর',
        nextWaqtTime: today.fajr,
        timeRemaining: today.fajr.difference(now),
        isForbiddenTime: false,
      );
    }

    if (now.isBefore(today.sunrise)) {
      // Fajr
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.fajr,
        currentWaqtNameBn: 'ফজর',
        nextWaqt: WaqtType.sunrise,
        nextWaqtNameBn: 'সূর্যোদয় (ফজর শেষ)',
        nextWaqtTime: today.sunrise,
        timeRemaining: today.sunrise.difference(now),
        isForbiddenTime: false,
      );
    }

    if (now.isBefore(today.dhuhr)) {
      // Post-Sunrise / Ishraq / Chasht
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.sunrise,
        currentWaqtNameBn: 'ইশরাক / চাশত',
        nextWaqt: WaqtType.dhuhr,
        nextWaqtNameBn: 'যোহর',
        nextWaqtTime: today.dhuhr,
        timeRemaining: today.dhuhr.difference(now),
        isForbiddenTime: false,
      );
    }

    if (now.isBefore(today.asr)) {
      // Dhuhr
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.dhuhr,
        currentWaqtNameBn: 'যোহর',
        nextWaqt: WaqtType.asr,
        nextWaqtNameBn: 'আসর',
        nextWaqtTime: today.asr,
        timeRemaining: today.asr.difference(now),
        isForbiddenTime: false,
      );
    }

    if (now.isBefore(today.maghrib)) {
      // Asr
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.asr,
        currentWaqtNameBn: 'আসর',
        nextWaqt: WaqtType.maghrib,
        nextWaqtNameBn: 'মাগরিব (ইফতার)',
        nextWaqtTime: today.maghrib,
        timeRemaining: today.maghrib.difference(now),
        isForbiddenTime: false,
      );
    }

    if (now.isBefore(today.isha)) {
      // Maghrib
      return CurrentWaqtStatus(
        currentWaqt: WaqtType.maghrib,
        currentWaqtNameBn: 'মাগরিব',
        nextWaqt: WaqtType.isha,
        nextWaqtNameBn: 'এশা',
        nextWaqtTime: today.isha,
        timeRemaining: today.isha.difference(now),
        isForbiddenTime: false,
      );
    }

    // Isha until midnight
    final nextFajr = tomorrow?.fajr ?? today.fajr.add(const Duration(days: 1));
    return CurrentWaqtStatus(
      currentWaqt: WaqtType.isha,
      currentWaqtNameBn: 'এশা',
      nextWaqt: WaqtType.fajr,
      nextWaqtNameBn: 'ফজর (আগামীকাল)',
      nextWaqtTime: nextFajr,
      timeRemaining: nextFajr.difference(now),
      isForbiddenTime: false,
    );
  }
}

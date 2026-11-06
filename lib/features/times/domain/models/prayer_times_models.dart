import 'package:flutter/foundation.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';

enum CalculationMethodOption {
  karachi,
  muslimWorldLeague,
  egyptian,
  ummAlQura,
  dubai,
  moonsightingCommittee,
  northAmerica,
  kuwait,
  qatar,
  singapore,
  tehran,
  turkey,
}

enum AsrMadhabOption { hanafi, shafi }

enum HighLatitudeRuleOption {
  middleOfTheNight,
  seventhOfTheNight,
  twilightAngle,
}

enum WaqtType { fajr, sunrise, dhuhr, asr, maghrib, isha }

@immutable
class ForbiddenTimeSpan {
  const ForbiddenTimeSpan({
    required this.start,
    required this.end,
    required this.nameBn,
    required this.descriptionBn,
  });

  final DateTime start;
  final DateTime end;
  final String nameBn;
  final String descriptionBn;

  bool contains(DateTime time) =>
      time.isAfter(start.subtract(const Duration(seconds: 1))) &&
      time.isBefore(end);
}

@immutable
class WaqtAdjustment {
  const WaqtAdjustment({
    this.fajr = 0,
    this.sunrise = 0,
    this.dhuhr = 0,
    this.asr = 0,
    this.maghrib = 0,
    this.isha = 0,
  });

  factory WaqtAdjustment.fromJson(Map<String, dynamic> json) {
    return WaqtAdjustment(
      fajr: json['fajr'] as int? ?? 0,
      sunrise: json['sunrise'] as int? ?? 0,
      dhuhr: json['dhuhr'] as int? ?? 0,
      asr: json['asr'] as int? ?? 0,
      maghrib: json['maghrib'] as int? ?? 0,
      isha: json['isha'] as int? ?? 0,
    );
  }

  final int fajr;
  final int sunrise;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;

  Map<String, dynamic> toJson() => {
    'fajr': fajr,
    'sunrise': sunrise,
    'dhuhr': dhuhr,
    'asr': asr,
    'maghrib': maghrib,
    'isha': isha,
  };
}

@immutable
class PrayerTimesSettings {
  const PrayerTimesSettings({
    required this.location,
    this.method = CalculationMethodOption.karachi,
    this.madhab = AsrMadhabOption.hanafi,
    this.highLatitudeRule = HighLatitudeRuleOption.middleOfTheNight,
    this.hijriOffsetDays = 0,
    this.adjustments = const WaqtAdjustment(),
    this.isAutoLocation = false,
  });

  factory PrayerTimesSettings.fromJson(Map<String, dynamic> json) {
    return PrayerTimesSettings(
      location: json['location'] != null
          ? LocationItem.fromJson(json['location'] as Map<String, dynamic>)
          : LocationItem.defaultDhaka,
      method: CalculationMethodOption.values.byName(
        json['method'] as String? ?? 'karachi',
      ),
      madhab: AsrMadhabOption.values.byName(
        json['madhab'] as String? ?? 'hanafi',
      ),
      highLatitudeRule: HighLatitudeRuleOption.values.byName(
        json['highLatitudeRule'] as String? ?? 'middleOfTheNight',
      ),
      hijriOffsetDays: json['hijriOffsetDays'] as int? ?? 0,
      adjustments: json['adjustments'] != null
          ? WaqtAdjustment.fromJson(json['adjustments'] as Map<String, dynamic>)
          : const WaqtAdjustment(),
      isAutoLocation: json['isAutoLocation'] as bool? ?? false,
    );
  }

  final LocationItem location;
  final CalculationMethodOption method;
  final AsrMadhabOption madhab;
  final HighLatitudeRuleOption highLatitudeRule;
  final int hijriOffsetDays;
  final WaqtAdjustment adjustments;
  final bool isAutoLocation;

  Map<String, dynamic> toJson() => {
    'location': location.toJson(),
    'method': method.name,
    'madhab': madhab.name,
    'highLatitudeRule': highLatitudeRule.name,
    'hijriOffsetDays': hijriOffsetDays,
    'adjustments': adjustments.toJson(),
    'isAutoLocation': isAutoLocation,
  };

  PrayerTimesSettings copyWith({
    LocationItem? location,
    CalculationMethodOption? method,
    AsrMadhabOption? madhab,
    HighLatitudeRuleOption? highLatitudeRule,
    int? hijriOffsetDays,
    WaqtAdjustment? adjustments,
    bool? isAutoLocation,
  }) {
    return PrayerTimesSettings(
      location: location ?? this.location,
      method: method ?? this.method,
      madhab: madhab ?? this.madhab,
      highLatitudeRule: highLatitudeRule ?? this.highLatitudeRule,
      hijriOffsetDays: hijriOffsetDays ?? this.hijriOffsetDays,
      adjustments: adjustments ?? this.adjustments,
      isAutoLocation: isAutoLocation ?? this.isAutoLocation,
    );
  }

  static const PrayerTimesSettings bangladeshDefault = PrayerTimesSettings(
    location: LocationItem.defaultDhaka,
  );
}

@immutable
class DailyScheduleTimes {
  const DailyScheduleTimes({
    required this.date,
    required this.dateKey,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.tahajjudStart,
    required this.ishraq,
    required this.chasht,
    required this.zawalStart,
    required this.zawalEnd,
    required this.forbiddenSunrise,
    required this.forbiddenZawal,
    required this.forbiddenSunset,
    required this.sehriEnd,
    required this.iftar,
  });

  final DateTime date;
  final String dateKey;
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final DateTime tahajjudStart;
  final DateTime ishraq;
  final DateTime chasht;
  final DateTime zawalStart;
  final DateTime zawalEnd;
  final ForbiddenTimeSpan forbiddenSunrise;
  final ForbiddenTimeSpan forbiddenZawal;
  final ForbiddenTimeSpan forbiddenSunset;
  final DateTime sehriEnd;
  final DateTime iftar;
}

@immutable
class CurrentWaqtStatus {
  const CurrentWaqtStatus({
    required this.currentWaqt,
    required this.currentWaqtNameBn,
    required this.nextWaqt,
    required this.nextWaqtNameBn,
    required this.nextWaqtTime,
    required this.timeRemaining,
    required this.isForbiddenTime,
    this.forbiddenReasonBn,
    this.forbiddenSpan,
  });

  final WaqtType currentWaqt;
  final String currentWaqtNameBn;
  final WaqtType nextWaqt;
  final String nextWaqtNameBn;
  final DateTime nextWaqtTime;
  final Duration timeRemaining;
  final bool isForbiddenTime;
  final String? forbiddenReasonBn;
  final ForbiddenTimeSpan? forbiddenSpan;
}

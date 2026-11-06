import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';
import 'package:musalli/features/times/domain/services/qibla_calculator.dart';

void main() {
  group('QiblaCalculator Tests', () {
    test('Calculates bearing to Kaaba from Dhaka correctly (~277.6°)', () {
      // Dhaka coordinates: 23.8103° N, 90.4125° E
      final bearing = QiblaCalculator.calculateBearing(23.8103, 90.4125);
      expect(bearing, closeTo(277.6, 1.0));
    });

    test('Calculates bearing to Kaaba from Chittagong correctly (~279.3°)', () {
      final bearing = QiblaCalculator.calculateBearing(22.3569, 91.7832);
      expect(bearing, closeTo(279.3, 1.0));
    });

    test('Calculates bearing to Kaaba from Sylhet correctly (~277.0°)', () {
      final bearing = QiblaCalculator.calculateBearing(24.8949, 91.8687);
      expect(bearing, closeTo(277.0, 1.0));
    });
  });

  group('LocationItem & PrayerTimesModels Tests', () {
    test('LocationItem serialization and properties', () {
      const loc = LocationItem.defaultDhaka;

      final json = loc.toJson();
      final restored = LocationItem.fromJson(json);

      expect(restored.id, 'dhaka');
      expect(restored.nameBn, 'ঢাকা');
      expect(restored.lat, 23.8103);
      expect(restored.lng, 90.4125);
      expect(restored.isPopular, isTrue);
    });

    test('PrayerTimesSettings copyWith and defaults', () {
      const def = PrayerTimesSettings.bangladeshDefault;
      expect(def.location.id, 'dhaka');
      expect(def.method, CalculationMethodOption.karachi);
      expect(def.madhab, AsrMadhabOption.hanafi);

      final updated = def.copyWith(
        method: CalculationMethodOption.muslimWorldLeague,
        madhab: AsrMadhabOption.shafi,
        hijriOffsetDays: 1,
      );

      expect(updated.method, CalculationMethodOption.muslimWorldLeague);
      expect(updated.madhab, AsrMadhabOption.shafi);
      expect(updated.hijriOffsetDays, 1);
      expect(updated.location.id, 'dhaka');
    });

    test('DailyScheduleTimes & WaqtStatus calculation', () {
      final date = DateTime(2026, 11, 6, 12);
      final schedule = PrayerTimesCalculator.calculateDailySchedule(
        date,
        PrayerTimesSettings.bangladeshDefault,
      );

      expect(schedule.fajr.isBefore(schedule.sunrise), isTrue);
      expect(schedule.sunrise.isBefore(schedule.dhuhr), isTrue);
      expect(schedule.dhuhr.isBefore(schedule.asr), isTrue);
      expect(schedule.asr.isBefore(schedule.maghrib), isTrue);
      expect(schedule.maghrib.isBefore(schedule.isha), isTrue);

      // Check Waqt status at 12:30 PM (Dhuhr time)
      final atDhuhr = schedule.dhuhr.add(const Duration(minutes: 30));
      final status = PrayerTimesCalculator.getCurrentWaqtStatus(
        atDhuhr,
        schedule,
      );
      expect(status.currentWaqt, WaqtType.dhuhr);
      expect(status.nextWaqt, WaqtType.asr);
      expect(status.isForbiddenTime, isFalse);
    });
  });

  group('BanglaIslamicDateFormatter Tests', () {
    test('Formats Gregorian Date into Bengali string', () {
      final date = DateTime(2026, 11, 6);
      final str = BanglaIslamicDateFormatter.formatGregorianBangla(date);
      expect(str, contains('৬'));
      expect(str, contains('নভেম্বর'));
      expect(str, contains('২০২৬'));
    });

    test('Formats Bengali Time in 12-hour format with period', () {
      final timeMorning = DateTime(2026, 11, 6, 5, 15);
      final morningStr = BanglaIslamicDateFormatter.formatBanglaTime(timeMorning);
      expect(morningStr, contains('ভোর'));
      expect(morningStr, contains('৫:১৫'));

      final timeAfternoon = DateTime(2026, 11, 6, 16, 20);
      final afternoonStr = BanglaIslamicDateFormatter.formatBanglaTime(timeAfternoon);
      expect(afternoonStr, contains('বিকাল'));
      expect(afternoonStr, contains('৪:২০'));
    });

    test('Formats Hijri date approximations', () {
      final date = DateTime(2026, 11, 6);
      final hijriStr = BanglaIslamicDateFormatter.formatHijriDate(date);
      expect(hijriStr, contains('হিজরি'));
    });
  });
}

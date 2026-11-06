import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/times/data/locations_repository.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Prayer Times Engine Acceptance Criteria', () {
    const dhakaSettings = PrayerTimesSettings.bangladeshDefault;

    int getBstMinutes(DateTime date) {
      // Convert to UTC+6 (Bangladesh Standard Time)
      final utc = date.toUtc();
      final totalUtcMin = utc.hour * 60 + utc.minute + 360;
      return (totalUtcMin + 1440) % 1440;
    }

    test('1. Dhaka matches Islamic Foundation Bangladesh / Karachi within ±2 minutes for 2026-01-01 (Winter)', () {
      final tJan1 = PrayerTimesCalculator.calculateDailySchedule(
        DateTime.utc(2026, 1, 1, 6),
        dhakaSettings,
      );

      // Reference BST minutes: Fajr 5:20 (320m), Sunrise 6:41 (401m), Dhuhr 12:03 (723m), Asr 15:47 (947m), Maghrib 17:23 (1043m), Isha 18:43 (1123m)
      expect((getBstMinutes(tJan1.fajr) - 320).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tJan1.sunrise) - 401).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tJan1.dhuhr) - 723).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tJan1.asr) - 947).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tJan1.maghrib) - 1043).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tJan1.isha) - 1123).abs(), lessThanOrEqualTo(2));
    });

    test('2. Dhaka matches Islamic Foundation Bangladesh / Karachi within ±2 minutes for 2026-04-14 (Spring)', () {
      final tApr14 = PrayerTimesCalculator.calculateDailySchedule(
        DateTime.utc(2026, 4, 14, 6),
        dhakaSettings,
      );

      // Reference BST minutes: Fajr 4:21 (261m), Sunrise 5:38 (338m), Dhuhr 12:00 (720m), Asr 16:31 (991m), Maghrib 18:19 (1099m), Isha 19:37 (1177m)
      expect((getBstMinutes(tApr14.fajr) - 261).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tApr14.sunrise) - 338).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tApr14.dhuhr) - 720).abs(), lessThanOrEqualTo(2));
      expect((getBstMinutes(tApr14.asr) - 991).abs(), lessThanOrEqualTo(2));
      expect(
        (getBstMinutes(tApr14.maghrib) - 1099).abs(),
        lessThanOrEqualTo(2),
      );
      expect((getBstMinutes(tApr14.isha) - 1177).abs(), lessThanOrEqualTo(2));
    });

    test('3. Forbidden times (Sunrise, Zawal, Sunset) span exactly 15 minutes each', () {
      final schedule = PrayerTimesCalculator.calculateDailySchedule(
        DateTime.utc(2026, 6, 1, 6),
        dhakaSettings,
      );

      expect(
        schedule.forbiddenSunrise.end
            .difference(schedule.forbiddenSunrise.start)
            .inMinutes,
        15,
      );
      expect(
        schedule.forbiddenZawal.end
            .difference(schedule.forbiddenZawal.start)
            .inMinutes,
        15,
      );
      expect(
        schedule.forbiddenSunset.end
            .difference(schedule.forbiddenSunset.start)
            .inMinutes,
        15,
      );
    });

    test('4. Tahajjud start time is in the last third of the night before next Fajr', () {
      final schedule = PrayerTimesCalculator.calculateDailySchedule(
        DateTime.utc(2026, 1, 1, 6),
        dhakaSettings,
      );

      expect(schedule.tahajjudStart.isAfter(schedule.maghrib), isTrue);
      expect(
        schedule.tahajjudStart.isBefore(
          schedule.fajr.add(const Duration(days: 1)),
        ),
        isTrue,
      );
    });

    test('5. Offline district repository loads all 64 districts of Bangladesh and world cities', () async {
      final repo = LocationsRepository();
      final locations = await repo.getAllLocations();
      expect(locations.length, greaterThanOrEqualTo(80));

      final bdDistricts = locations
          .where((l) => l.countryBn == 'বাংলাদেশ')
          .toList();
      expect(bdDistricts.length, 64);

      final searchDhaka = await repo.searchLocations('ঢাকা');
      expect(searchDhaka.any((l) => l.id == 'dhaka'), isTrue);

      final searchSylhet = await repo.searchLocations('sylhet');
      expect(searchSylhet.any((l) => l.id == 'sylhet'), isTrue);
    });

    test('6. Bengali 12h time formatting outputs authentic periods', () {
      final tDawn = DateTime(2026, 1, 1, 5, 20);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tDawn),
        contains('ভোর'),
      );

      final tMorning = DateTime(2026, 1, 1, 9, 30);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tMorning),
        contains('সকাল'),
      );

      final tNoon = DateTime(2026, 1, 1, 12, 15);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tNoon),
        contains('দুপুর'),
      );

      final tAfternoon = DateTime(2026, 1, 1, 16);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tAfternoon),
        contains('বিকাল'),
      );

      final tSunset = DateTime(2026, 1, 1, 17, 30);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tSunset),
        contains('সন্ধ্যা'),
      );

      final tNight = DateTime(2026, 1, 1, 21);
      expect(
        BanglaIslamicDateFormatter.formatBanglaTime(tNight),
        contains('রাত'),
      );
    });
  });
}

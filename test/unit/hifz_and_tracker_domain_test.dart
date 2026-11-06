import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/hifz/domain/hifz_models.dart';
import 'package:musalli/features/tracker/domain/tracker_models.dart';

void main() {
  group('Hifz Spaced Repetition Domain Tests', () {
    test('createNew creates initial 1-day interval item', () {
      final item = HifzItemRecord.createNew(1);
      expect(item.surahNumber, 1);
      expect(item.intervalDays, 1);
      expect(item.repetitionsCount, 0);
      expect(item.isDue, isFalse);
    });

    test('markReviewed increments interval correctly upon success', () {
      var item = HifzItemRecord.createNew(1);
      
      // 1 -> 3
      item = item.markReviewed(success: true);
      expect(item.intervalDays, 3);
      expect(item.repetitionsCount, 1);

      // 3 -> 7
      item = item.markReviewed(success: true);
      expect(item.intervalDays, 7);
      expect(item.repetitionsCount, 2);

      // 7 -> 14
      item = item.markReviewed(success: true);
      expect(item.intervalDays, 14);
      expect(item.repetitionsCount, 3);

      // 14 -> 30
      item = item.markReviewed(success: true);
      expect(item.intervalDays, 30);

      // 30 -> 60
      item = item.markReviewed(success: true);
      expect(item.intervalDays, 60);
    });

    test('markReviewed resets interval to 1 on failure/lapse', () {
      var item = HifzItemRecord.createNew(112);
      item = item.markReviewed(success: true); // 3
      item = item.markReviewed(success: true); // 7
      expect(item.intervalDays, 7);

      // Failure resets to 1 day
      item = item.markReviewed(success: false);
      expect(item.intervalDays, 1);
      expect(item.repetitionsCount, 3);
    });

    test('Serialization and Deserialization preserves properties', () {
      final original = HifzItemRecord.createNew(114).markReviewed(success: true);
      final json = original.toJson();
      final restored = HifzItemRecord.fromJson(json);

      expect(restored.surahNumber, original.surahNumber);
      expect(restored.intervalDays, original.intervalDays);
      expect(restored.repetitionsCount, original.repetitionsCount);
    });
  });

  group('Prayer Tracker Domain Tests', () {
    test('DayPrayerRecord calculates completed count correctly', () {
      const record = DayPrayerRecord(
        dateStr: '2026-11-06',
        fajr: PrayerStatus.jamaat,
        dhuhr: PrayerStatus.ontime,
        asr: PrayerStatus.qaza,
        maghrib: PrayerStatus.ontime,
        isha: PrayerStatus.missed,
        witr: PrayerStatus.ontime,
      );

      // completedCount counts ontime & jamaat for the 5 daily prayers
      expect(record.completedCount, 3); // fajr (jamaat), dhuhr (ontime), maghrib (ontime)
      expect(record.isAllFardCompleted, isFalse);
    });

    test('DayPrayerRecord identifies all fard completed', () {
      const allDone = DayPrayerRecord(
        dateStr: '2026-11-06',
        fajr: PrayerStatus.jamaat,
        dhuhr: PrayerStatus.jamaat,
        asr: PrayerStatus.ontime,
        maghrib: PrayerStatus.jamaat,
        isha: PrayerStatus.ontime,
        witr: PrayerStatus.ontime,
      );

      expect(allDone.completedCount, 5);
      expect(allDone.isAllFardCompleted, isTrue);
    });

    test('QazaRecord calculates total missed prayers accurately', () {
      const qaza = QazaRecord(
        fajr: 10,
        dhuhr: 5,
        asr: 5,
        maghrib: 2,
        isha: 10,
        witr: 10,
      );

      expect(qaza.total, 42);

      final json = qaza.toJson();
      final restored = QazaRecord.fromJson(json);
      expect(restored.total, 42);
      expect(restored.fajr, 10);
      expect(restored.maghrib, 2);
    });
  });
}

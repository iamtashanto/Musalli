import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/helpers/domain/sajda_sahu_tree.dart';
import 'package:musalli/features/helpers/domain/sick_prayer_tree.dart';
import 'package:musalli/features/kids/domain/kids_models.dart';
import 'package:musalli/features/kids/domain/kids_service.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';
import 'package:musalli/features/tracker/domain/tracker_models.dart';

void main() {
  group('Comprehensive Domain Logic Coverage', () {
    test('DecisionTree: Sajda Sahu and Sick Prayer Trees have valid structures', () {
      expect(SajdaSahuDecisionTree.rootNodeId, isNotEmpty);
      expect(SajdaSahuDecisionTree.nodes, isNotEmpty);

      // Walk tree from root
      final root = SajdaSahuDecisionTree.nodes[SajdaSahuDecisionTree.rootNodeId]!;
      expect(root.question, isNotEmpty);
      expect(root.options, isNotEmpty);
      for (final opt in root.options) {
        expect(opt.label, isNotEmpty);
        if (opt.nextNodeId != null) {
          expect(SajdaSahuDecisionTree.nodes[opt.nextNodeId!], isNotNull);
        }
      }

      expect(SickPrayerDecisionTree.rootNodeId, isNotEmpty);
      expect(SickPrayerDecisionTree.nodes, isNotEmpty);
      final sickRoot = SickPrayerDecisionTree.nodes[SickPrayerDecisionTree.rootNodeId]!;
      expect(sickRoot.question, isNotEmpty);
      for (final opt in sickRoot.options) {
        expect(opt.label, isNotEmpty);
        if (opt.nextNodeId != null) {
          expect(SickPrayerDecisionTree.nodes[opt.nextNodeId!], isNotNull);
        }
      }
    });

    test('PrayerTimesCalculator: covers all CalculationMethodOption variants', () {
      final date = DateTime(2026, 6, 21); // Summer solstice
      for (final method in CalculationMethodOption.values) {
        final settings = PrayerTimesSettings(
          location: LocationItem.defaultDhaka,
          method: method,
          madhab: AsrMadhabOption.shafi,
          highLatitudeRule: HighLatitudeRuleOption.seventhOfTheNight,
        );
        final schedule = PrayerTimesCalculator.calculateDailySchedule(date, settings);
        expect(schedule.fajr, isNotNull);
        expect(schedule.maghrib, isNotNull);
      }

      // Also test twilightAngle and middleOfTheNight high-latitude rules
      final p1 = PrayerTimesCalculator.getParameters(
        CalculationMethodOption.karachi,
        AsrMadhabOption.hanafi,
        HighLatitudeRuleOption.twilightAngle,
      );
      expect(p1.method, isNotNull);

      final p2 = PrayerTimesCalculator.getParameters(
        CalculationMethodOption.karachi,
        AsrMadhabOption.hanafi,
        HighLatitudeRuleOption.middleOfTheNight,
      );
      expect(p2.method, isNotNull);
    });

    test('PrayerTimesCalculator: evaluates all branches of getCurrentWaqtStatus', () {
      final schedule = PrayerTimesCalculator.calculateDailySchedule(
        DateTime(2026, 11, 6),
        PrayerTimesSettings.bangladeshDefault,
      );

      // 1. Midnight to Fajr (Tahajjud)
      final preFajr = schedule.fajr.subtract(const Duration(minutes: 30));
      final s1 = PrayerTimesCalculator.getCurrentWaqtStatus(preFajr, schedule);
      expect(s1.currentWaqt, WaqtType.isha);

      // 2. Fajr time
      final duringFajr = schedule.fajr.add(const Duration(minutes: 10));
      final s2 = PrayerTimesCalculator.getCurrentWaqtStatus(duringFajr, schedule);
      expect(s2.currentWaqt, WaqtType.fajr);

      // 3. Ishraq / Post-Sunrise
      final postSunrise = schedule.sunrise.add(const Duration(minutes: 30));
      final s3 = PrayerTimesCalculator.getCurrentWaqtStatus(postSunrise, schedule);
      expect(s3.currentWaqt, WaqtType.sunrise);

      // 4. Asr time
      final duringAsr = schedule.asr.add(const Duration(minutes: 15));
      final s4 = PrayerTimesCalculator.getCurrentWaqtStatus(duringAsr, schedule);
      expect(s4.currentWaqt, WaqtType.asr);

      // 5. Sunset forbidden period
      final sunsetForbidden = schedule.maghrib.subtract(const Duration(minutes: 5));
      final s5 = PrayerTimesCalculator.getCurrentWaqtStatus(sunsetForbidden, schedule);
      expect(s5.isForbiddenTime, isTrue);

      // 6. Maghrib time
      final duringMaghrib = schedule.maghrib.add(const Duration(minutes: 10));
      final s6 = PrayerTimesCalculator.getCurrentWaqtStatus(duringMaghrib, schedule);
      expect(s6.currentWaqt, WaqtType.maghrib);

      // 7. Isha time
      final duringIsha = schedule.isha.add(const Duration(minutes: 20));
      final s7 = PrayerTimesCalculator.getCurrentWaqtStatus(duringIsha, schedule);
      expect(s7.currentWaqt, WaqtType.isha);
    });

    test('BanglaIslamicDateFormatter: formats remaining methods and month spans', () {
      // Test all 12 months in Bangla Gregorian
      for (int m = 1; m <= 12; m++) {
        final d = DateTime(2026, m, 15);
        final formatted = BanglaIslamicDateFormatter.formatGregorianBangla(d);
        expect(formatted, isNotEmpty);
      }

      // Test time with seconds
      final t = DateTime(2026, 1, 1, 14, 5, 9);
      final tSec = BanglaIslamicDateFormatter.formatBanglaTime(t, includeSeconds: true);
      expect(tSec, contains('দুপুর'));

      // Test Hijri offset
      final h1 = BanglaIslamicDateFormatter.formatHijriDate(DateTime(2026, 3, 20), offsetDays: 1);
      final h2 = BanglaIslamicDateFormatter.formatHijriDate(DateTime(2026, 3, 20), offsetDays: -1);
      expect(h1, isNotEmpty);
      expect(h2, isNotEmpty);
    });

    test('Types: Posture helper and metadata', () {
      expect(Posture.values.length, 16);
      for (final p in Posture.values) {
        expect(p.name, isNotEmpty);
      }

      // Cover SimStep copyWith and properties
      const s1 = SimStep(
        id: 'step_1',
        rakat: 1,
        repeat: 1,
        spokenTakbir: 'আল্লাহু আকবার',
        isLoud: false,
        durationHintMs: 2000,
        titleBn: 'দাঁড়ান',
        posture: Posture.standing,
        recitationIds: ['sana'],
        instructionBn: 'দাঁড়ান',
        genderVariants: GenderVariantFlags.male,
      );
      expect(s1.instructionBn, 'দাঁড়ান');

      final s2 = s1.copyWith(
        spokenTakbir: 'আল্লাহু আকবার',
        repeat: 3,
        isLoud: true,
      );
      expect(s2.spokenTakbir, 'আল্লাহু আকবার');
      expect(s2.repeat, 3);
      expect(s2.isLoud, isTrue);

      // Cover Timeline metadata
      const tl = Timeline(
        steps: [s1],
        metadata: TimelineMetadata(
          totalRakats: 2,
          prayerSlug: 'fajr',
          unitLabel: 'ফরজ',
          gender: SimGender.male,
          role: SimRole.alone,
          totalSteps: 1,
          totalTasbihCount: 0,
          estimatedDurationMs: 60000,
          isJanaza: false,
        ),
      );
      expect(tl.steps.length, 1);
      expect(tl.metadata.prayerSlug, 'fajr');
      expect(tl.metadata.estimatedDuration.inSeconds, 60);
    });

    test('Kids Models & Progression direct unit coverage', () {
      const service = KidsService();
      final lessons = service.getLessons();
      expect(lessons.length, 6);
      expect(service.isLessonUnlocked(KidsLessonId.wudu, const {}), isTrue);
      expect(service.isLessonUnlocked(KidsLessonId.takbir, const {}), isFalse);
      expect(service.isLessonUnlocked(KidsLessonId.takbir, {KidsLessonId.wudu.key}), isTrue);

      final challenge = service.generateMathChallenge();
      expect(challenge.promptBn, isNotEmpty);
      expect(challenge.optionsBn.length, greaterThanOrEqualTo(3));
      expect(challenge.num1, greaterThan(0));
      expect(challenge.num2, greaterThan(0));
      expect(challenge.sum, equals(challenge.num1 + challenge.num2));
      expect(challenge.correctIndex, inInclusiveRange(0, challenge.optionsBn.length - 1));

      // Test all lesson status checks
      for (final id in KidsLessonId.values) {
        final unlocked = service.isLessonUnlocked(id, {
          KidsLessonId.wudu.key,
          KidsLessonId.takbir.key,
          KidsLessonId.fatiha.key,
          KidsLessonId.shortSurahs.key,
          KidsLessonId.twoRakat.key,
          KidsLessonId.fourRakat.key,
        });
        expect(unlocked, isTrue);
      }
    });

    test('TrackerModels: DayPrayerRecord empty factory & serialization', () {
      final empty = DayPrayerRecord.empty('2026-11-06');
      expect(empty.completedCount, 0);
      expect(empty.fajr, PrayerStatus.missed);

      // Verify all prayer status labels and values
      for (final st in PrayerStatus.values) {
        expect(st.labelBn, isNotEmpty);
        expect(st.emoji, isNotEmpty);
      }

      final json = empty.toJson();
      final restored = DayPrayerRecord.fromJson('2026-11-06', json);
      expect(restored.dateStr, '2026-11-06');
      expect(restored.completedCount, 0);

      // Verify QazaRecord serialization and values
      const qaza = QazaRecord(fajr: 1, dhuhr: 2, asr: 3, maghrib: 4, isha: 5, witr: 6);
      expect(qaza.total, 21);
      final qJson = qaza.toJson();
      final qRestored = QazaRecord.fromJson(qJson);
      expect(qRestored.total, 21);
    });
  });
}

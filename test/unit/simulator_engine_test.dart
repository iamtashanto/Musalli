import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/simulator/domain/engine.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/prayer_type.dart';
import 'package:musalli/shared/content/salah_config.dart';

void main() {
  group('Namaj Simulator Engine Tests', () {
    void assertStandardTimelineInvariants(
      Timeline timeline,
      int expectedRakats,
    ) {
      expect(timeline.metadata.totalRakats, expectedRakats);
      expect(timeline.metadata.isJanaza, isFalse);
      expect(timeline.steps.isNotEmpty, isTrue);

      // 1. Number of Rukus === rakats
      final rukus = timeline.steps
          .where((s) => s.posture == Posture.ruku)
          .toList();
      expect(rukus.length, expectedRakats);

      // 2. Number of Sajdas === rakats * 2
      final sajdas = timeline.steps
          .where((s) => s.posture == Posture.sajda)
          .toList();
      expect(sajdas.length, expectedRakats * 2);

      // 3. Number of Jalsas (between sajdas) === rakats
      final jalsas = timeline.steps
          .where((s) => s.posture == Posture.jalsa)
          .toList();
      expect(jalsas.length, expectedRakats);

      // 4. Number of Qawmas === rakats
      final qawmas = timeline.steps
          .where((s) => s.posture == Posture.qawma)
          .toList();
      expect(qawmas.length, expectedRakats);

      // 5. Exactly one Salam pair
      final salamRight = timeline.steps
          .where((s) => s.posture == Posture.salamRight)
          .toList();
      final salamLeft = timeline.steps
          .where((s) => s.posture == Posture.salamLeft)
          .toList();
      expect(salamRight.length, 1);
      expect(salamLeft.length, 1);
    }

    test('1. Fajr 2 Rakat Fard produces valid timeline', () {
      const config = ContentSalahConfig(
        rakats: 2,
        qiratRakats: [1, 2],
        firstSittingAfter: null,
        jahr: [1, 2],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'fajr',
      );

      assertStandardTimelineInvariants(timeline, 2);

      // Sana only in Rakat 1
      final sanaSteps = timeline.steps
          .where((s) => s.recitationIds.contains('dua-1'))
          .toList();
      expect(sanaSteps.length, 1);
      expect(sanaSteps[0].rakat, 1);

      // Both rakats have Fatiha and additional Surah
      final fatihaSteps = timeline.steps
          .where((s) => s.recitationIds.contains('surah-1'))
          .toList();
      expect(fatihaSteps.length, 2);

      // Only final sitting (no first sitting in 2 rakat)
      final firstSitting = timeline.steps
          .where((s) => s.id == 'r1-qada-first' || s.id == 'r2-qada-first')
          .toList();
      expect(firstSitting, isEmpty);

      final finalSitting = timeline.steps
          .where((s) => s.id == 'r2-qada-final')
          .toList();
      expect(finalSitting.length, 1);
    });

    test('2. Maghrib 3 Rakat Fard produces valid timeline with first sitting after rakat 2', () {
      const config = ContentSalahConfig(
        rakats: 3,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
        jahr: [1, 2],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'maghrib',
      );

      assertStandardTimelineInvariants(timeline, 3);

      // First sitting after Rakat 2
      final firstSitting = timeline.steps
          .where((s) => s.id == 'r2-qada-first')
          .toList();
      expect(firstSitting.length, 1);

      // Final sitting after Rakat 3
      final finalSitting = timeline.steps
          .where((s) => s.id == 'r3-qada-final')
          .toList();
      expect(finalSitting.length, 1);

      // Extra surah only in rakats 1 and 2, not rakat 3
      final surahSteps = timeline.steps
          .where((s) => s.id.endsWith('-surah'))
          .toList();
      expect(surahSteps.length, 2);
      expect(surahSteps[0].rakat, 1);
      expect(surahSteps[1].rakat, 2);
    });

    test('3. Zuhr 4 Rakat Fard produces valid timeline', () {
      const config = ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
        jahr: [],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.female,
        role: SimRole.alone,
        prayerSlug: 'zuhr',
      );

      assertStandardTimelineInvariants(timeline, 4);

      // First sitting after rakat 2
      expect(timeline.steps.any((s) => s.id == 'r2-qada-first'), isTrue);
      // Final sitting after rakat 4
      expect(timeline.steps.any((s) => s.id == 'r4-qada-final'), isTrue);
      // Female variants used
      expect(
        timeline.steps[0].genderVariants.sajdaPosture,
        'compact_elbows_tucked',
      );
    });

    test('4. Witr 3 Rakat with Qunut in Rakat 3 before Ruku', () {
      const config = ContentSalahConfig(
        rakats: 3,
        qiratRakats: [1, 2, 3],
        firstSittingAfter: 2,
        hasQunut: QunutConfig(enabled: true, rakat: 3, position: 'before-ruku'),
        jahr: [],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'witr',
      );

      assertStandardTimelineInvariants(timeline, 3);

      // Contains Qunut Takbir and Dua Qunut in Rakat 3
      final qunutTakbir = timeline.steps
          .where((s) => s.posture == Posture.qunutTakbir)
          .toList();
      expect(qunutTakbir.length, 1);
      expect(qunutTakbir[0].rakat, 3);

      final duaQunut = timeline.steps
          .where((s) => s.recitationIds.contains('dua-5'))
          .toList();
      expect(duaQunut.length, 1);
      expect(duaQunut[0].rakat, 3);
    });

    test('5. Eid Prayer has 6 extra takbirs (3 in Rakat 1, 3 in Rakat 2)', () {
      const config = ContentSalahConfig(
        rakats: 2,
        qiratRakats: [1, 2],
        extraTakbirs: [
          ExtraTakbir(count: 3, position: 'after-sana', rakat: 1),
          ExtraTakbir(count: 3, position: 'before-ruku', rakat: 2),
        ],
        jahr: [1, 2],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'eid-ul-fitr',
      );

      assertStandardTimelineInvariants(timeline, 2);

      // Extra Eid takbir raise steps
      final eidTakbirs = timeline.steps
          .where((s) => s.posture == Posture.eidTakbirRaised)
          .toList();
      expect(eidTakbirs.length, 6);
    });

    test('6. Janaza Prayer (4 takbirs, no ruku, no sajda)', () {
      const config = ContentSalahConfig(
        rakats: 0,
        isJanaza: true,
        sajdaCount: 0,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'janaza',
      );

      expect(timeline.metadata.isJanaza, isTrue);
      expect(timeline.metadata.totalRakats, 0);

      // Zero Rukus, Zero Sajdas
      expect(timeline.steps.where((s) => s.posture == Posture.ruku), isEmpty);
      expect(timeline.steps.where((s) => s.posture == Posture.sajda), isEmpty);

      // 4 Janaza takbirs
      final janazaTakbirs = timeline.steps
          .where((s) => s.posture == Posture.janazaTakbir)
          .toList();
      expect(janazaTakbirs.length, 4);

      // Salam right and left
      expect(
        timeline.steps.any((s) => s.posture == Posture.salamRight),
        isTrue,
      );
      expect(timeline.steps.any((s) => s.posture == Posture.salamLeft), isTrue);
    });

    test('7. Salatut Tasbih sums to exactly 300 tasbihs across 4 rakats', () {
      const config = ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2, 3, 4],
        firstSittingAfter: 2,
        tasbihDistribution: [
          ContentTasbihDistribution(
            position: 'after-sana',
            count: 15,
            labelBn: 'কেরাতের পূর্বে',
          ),
          ContentTasbihDistribution(
            position: 'after-surah',
            count: 10,
            labelBn: 'কেরাতের পর',
          ),
          ContentTasbihDistribution(
            position: 'ruku',
            count: 10,
            labelBn: 'রুকুতে',
          ),
          ContentTasbihDistribution(
            position: 'qawmah',
            count: 10,
            labelBn: 'কওমায়',
          ),
          ContentTasbihDistribution(
            position: 'sajda-1',
            count: 10,
            labelBn: '১ম সিজদায়',
          ),
          ContentTasbihDistribution(
            position: 'jalsah',
            count: 10,
            labelBn: 'জলসায়',
          ),
          ContentTasbihDistribution(
            position: 'sajda-2',
            count: 10,
            labelBn: '২য় সিজদায়',
          ),
        ],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'salatut-tasbih',
      );

      assertStandardTimelineInvariants(timeline, 4);

      // 75 tasbihs per rakat * 4 rakats = 300 total
      expect(timeline.metadata.totalTasbihCount, 300);
    });

    test('8. Muqtadi role stands silently during Qirat in Hanafi fiqh', () {
      const config = ContentSalahConfig(
        rakats: 2,
        qiratRakats: [1, 2],
        firstSittingAfter: null,
        jahr: [1, 2],
        sajdaCount: 2,
        endsWithSalam: true,
      );

      final timeline = buildTimeline(
        config,
        gender: SimGender.male,
        role: SimRole.muqtadi,
        prayerSlug: 'fajr',
      );

      // Fatiha step should NOT be present for muqtadi
      expect(timeline.steps.any((s) => s.id == 'r1-fatiha'), isFalse);
      // Instead, silent qiyam is present
      expect(timeline.steps.any((s) => s.id == 'r1-qiyam-muqtadi'), isTrue);
      // But Sana, tasbihat, tashahhud, etc. ARE recited
      expect(timeline.steps.any((s) => s.id == 'r1-sana'), isTrue);
      expect(timeline.steps.any((s) => s.id == 'r2-qada-final'), isTrue);
    });

    test('9. Invariants hold for all 29 prayers in prayers.json', () {
      final file = File('assets/content/prayers.json');
      if (!file.existsSync()) return;

      final jsonStr = file.readAsStringSync();
      final list = jsonDecode(jsonStr) as List<dynamic>;

      for (final raw in list) {
        final prayer = ContentPrayerType.fromJson(raw as Map<String, dynamic>);
        for (final unit in prayer.rakatUnits) {
          final config = unit.config;
          final timeline = buildTimeline(
            config,
            gender: SimGender.male,
            role: SimRole.alone,
            prayerSlug: prayer.slug,
            unitLabel: unit.label,
          );

          if (config.isJanaza) {
            expect(timeline.metadata.isJanaza, isTrue);
            expect(
              timeline.steps.where((s) => s.posture == Posture.ruku),
              isEmpty,
            );
            expect(
              timeline.steps.where((s) => s.posture == Posture.sajda),
              isEmpty,
            );
            expect(
              timeline.steps
                  .where((s) => s.posture == Posture.janazaTakbir)
                  .length,
              4,
            );
          } else {
            assertStandardTimelineInvariants(timeline, config.rakats);
          }
        }
      }
    });
  });
}

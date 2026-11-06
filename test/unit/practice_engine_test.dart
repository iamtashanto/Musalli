import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/simulator/domain/engine.dart';
import 'package:musalli/features/simulator/domain/practice/practice_engine.dart';
import 'package:musalli/features/simulator/domain/practice/practice_models.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/content/salah_config.dart';

void main() {
  group('Practice Mode Engine Tests', () {
    const engine = PracticeEngine();

    test(
      '1. Fajr 2 Rakat generates questions covering all required checkpoints',
      () {
        const fajrConfig = ContentSalahConfig(
          rakats: 2,
          qiratRakats: [1, 2],
          firstSittingAfter: 2,
          jahr: [1, 2],
        );

        final timeline = buildTimeline(
          fajrConfig,
          gender: SimGender.male,
          role: SimRole.alone,
          prayerSlug: 'fajr',
          unitLabel: 'fard',
        );

        final questions = engine.generateQuestions(
          timeline,
          difficulty: PracticeDifficulty.standard,
        );

        expect(questions, isNotEmpty);

        // Check question types present
        final types = questions.map((q) => q.type).toSet();
        expect(types.contains(PracticeQuestionType.nextPosture), isTrue);
        expect(types.contains(PracticeQuestionType.whatRecitation), isTrue);
        expect(types.contains(PracticeQuestionType.howManyTimes), isTrue);
        expect(types.contains(PracticeQuestionType.surahMatching), isTrue);
        expect(types.contains(PracticeQuestionType.sitOrStand), isTrue);

        // Verify each question has exactly one correct answer
        for (final q in questions) {
          final correctCount = q.options.where((o) => o.isCorrect).length;
          expect(
            correctCount,
            1,
            reason: 'Question ${q.id} must have exactly 1 correct answer',
          );
          expect(q.promptBn.isNotEmpty, isTrue);
          expect(q.correctExplanationBn.isNotEmpty, isTrue);
        }
      },
    );

    test('2. Fiqh impact accuracy: Takbir Tahrima missing invalidates salah, Wajib missing requires Sajda Sahu', () {
      const zuhrConfig = ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
      );

      final timeline = buildTimeline(
        zuhrConfig,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'dhuhr',
        unitLabel: 'fard',
      );

      final questions = engine.generateQuestions(
        timeline,
        difficulty: PracticeDifficulty.standard,
      );

      final tahrimaQ = questions.firstWhere(
        (q) => q.id.startsWith('q_tahrima'),
      );
      expect(tahrimaQ.fiqhImpact, MistakeFiqhImpact.invalidatesSalah);

      final sitStandR2 = questions.firstWhere((q) => q.id == 'q_sit_stand_r2');
      expect(sitStandR2.fiqhImpact, MistakeFiqhImpact.requiresSajdaSahu);
    });

    test('3. Surah matching distinction: Yes in rakat 1, No in rakat 3 of 4-rakat Fard', () {
      const zuhrConfig = ContentSalahConfig(
        rakats: 4,
        qiratRakats: [1, 2],
        firstSittingAfter: 2,
      );

      final timeline = buildTimeline(
        zuhrConfig,
        gender: SimGender.male,
        role: SimRole.alone,
        prayerSlug: 'dhuhr',
        unitLabel: 'fard',
      );

      final questions = engine.generateQuestions(
        timeline,
        difficulty: PracticeDifficulty.standard,
      );

      final qRakat1 = questions.firstWhere((q) => q.id == 'q_surah_match_r1');
      final correctOpt1 = qRakat1.options.firstWhere((o) => o.isCorrect);
      expect(correctOpt1.labelBn, contains('হ্যাঁ'));

      final qRakat3 = questions.firstWhere((q) => q.id == 'q_surah_match_r3');
      final correctOpt3 = qRakat3.options.firstWhere((o) => o.isCorrect);
      expect(correctOpt3.labelBn, contains('না'));
    });

    test('4. Badge evaluation awards badge for high score (≥ 90%)', () {
      final badge95 = engine.evaluateBadge(
        prayerSlug: 'fajr',
        scorePercent: 95,
        difficulty: PracticeDifficulty.standard,
      );
      expect(badge95, contains('ফজর আয়ত্ত'));

      final badgeExpert = engine.evaluateBadge(
        prayerSlug: 'fajr',
        scorePercent: 100,
        difficulty: PracticeDifficulty.expert,
      );
      expect(badgeExpert, contains('ফজর আয়ত্ত (দক্ষ)'));

      final badgeFail = engine.evaluateBadge(
        prayerSlug: 'fajr',
        scorePercent: 70,
        difficulty: PracticeDifficulty.standard,
      );
      expect(badgeFail, isNull);
    });
  });
}

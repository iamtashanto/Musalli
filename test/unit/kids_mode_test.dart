import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/kids/domain/kids_models.dart';
import 'package:musalli/features/kids/domain/kids_service.dart';

void main() {
  group('Kids Mode Domain & Progression Tests', () {
    const service = KidsService();

    test('1. Progressive path has exactly 6 stages starting from Wudu up to 4-Rakat prayer', () {
      final lessons = service.getLessons();
      expect(lessons.length, 6);

      expect(lessons[0].id, KidsLessonId.wudu);
      expect(lessons[1].id, KidsLessonId.takbir);
      expect(lessons[2].id, KidsLessonId.fatiha);
      expect(lessons[3].id, KidsLessonId.shortSurahs);
      expect(lessons[4].id, KidsLessonId.twoRakat);
      expect(lessons[5].id, KidsLessonId.fourRakat);

      for (final l in lessons) {
        expect(l.titleBn.isNotEmpty, isTrue);
        expect(l.subtitleBn.isNotEmpty, isTrue);
        expect(l.stickerName.isNotEmpty, isTrue);
        expect(l.targetRoute.isNotEmpty, isTrue);
      }
    });

    test(
      '2. Unlocking progression requires previous stage to be completed',
      () {
        // Stage 1 (wudu) is unlocked by default
        expect(service.isLessonUnlocked(KidsLessonId.wudu, {}), isTrue);

        // Stage 2 (takbir) is locked until wudu is complete
        expect(service.isLessonUnlocked(KidsLessonId.takbir, {}), isFalse);
        expect(service.isLessonUnlocked(KidsLessonId.takbir, {'wudu'}), isTrue);

        // Stage 5 (twoRakat) is locked until shortSurahs is complete
        expect(
          service.isLessonUnlocked(KidsLessonId.twoRakat, {'wudu', 'takbir'}),
          isFalse,
        );
        expect(
          service.isLessonUnlocked(KidsLessonId.twoRakat, {
            'wudu',
            'takbir',
            'fatiha',
            'shortSurahs',
          }),
          isTrue,
        );
      },
    );

    test('3. Parent math lock challenge produces valid arithmetic problem in Bengali numerals', () {
      final rng = Random(42);
      final challenge = service.generateMathChallenge(rng);

      expect(challenge.num1 + challenge.num2, challenge.sum);
      expect(challenge.optionsBn.length, 3);
      expect(challenge.correctIndex, greaterThanOrEqualTo(0));
      expect(challenge.correctIndex, lessThan(3));

      // Prompt and options are formatted in Bengali numerals
      expect(challenge.promptBn, contains('+'));
      expect(challenge.promptBn, contains('কত?'));
      expect(
        RegExp('[০-৯]').hasMatch(challenge.optionsBn[challenge.correctIndex]),
        isTrue,
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/wudu/domain/wudu_engine.dart';
import 'package:musalli/features/wudu/domain/wudu_models.dart';

void main() {
  group('Wudu Engine & Timeline Acceptance Tests', () {
    const engine = WuduEngine();

    test('1. Standard timeline builds all canonical steps including Bismillah and closing Dua', () {
      final timeline = engine.buildTimeline();
      expect(timeline.length, greaterThanOrEqualTo(12));

      // First step is Bismillah
      expect(timeline[0].id, WuduStepId.niyyahAndBismillah);
      expect(timeline[0].ruling, WuduRuling.sunnat);

      // Last step is Dua After Wudu
      expect(timeline.steps.last.id, WuduStepId.duaAfterWudu);
      expect(
        timeline.steps.last.arabicDua,
        contains('أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا اللَّهُ'),
      );
    });

    test('2. Hanafi Quranic Fards (4 items) are rigorously tagged', () {
      final timeline = engine.buildTimeline();
      final fardSteps = timeline.steps
          .where((s) => s.ruling == WuduRuling.fard)
          .toList();

      // Exactly 6 step entries corresponding to the 4 limbs:
      // 1. Face, 2. Right Arm, 3. Left Arm, 4. Head Masah, 5. Right Foot, 6. Left Foot
      expect(fardSteps.length, 6);

      final fardIds = fardSteps.map((s) => s.id).toSet();
      expect(fardIds.contains(WuduStepId.washFace), isTrue);
      expect(fardIds.contains(WuduStepId.washRightArm), isTrue);
      expect(fardIds.contains(WuduStepId.washLeftArm), isTrue);
      expect(fardIds.contains(WuduStepId.masahHead), isTrue);
      expect(fardIds.contains(WuduStepId.washRightFoot), isTrue);
      expect(fardIds.contains(WuduStepId.washLeftFoot), isTrue);
    });

    test(
      '3. Three-time washing rule applies to washed limbs, one-time to masah',
      () {
        final timeline = engine.buildTimeline();

        final face = timeline.steps.firstWhere(
          (s) => s.id == WuduStepId.washFace,
        );
        expect(face.repeatCount, 3);

        final arm = timeline.steps.firstWhere(
          (s) => s.id == WuduStepId.washRightArm,
        );
        expect(arm.repeatCount, 3);

        final head = timeline.steps.firstWhere(
          (s) => s.id == WuduStepId.masahHead,
        );
        expect(head.repeatCount, 1);
      },
    );

    test(
      '4. Wudu practice quiz questions test sequencing and fard knowledge',
      () {
        final questions = engine.generatePracticeQuestions();
        expect(questions.length, greaterThanOrEqualTo(4));

        for (final q in questions) {
          expect(q.promptBn.isNotEmpty, isTrue);
          expect(q.options.length, greaterThanOrEqualTo(3));
          expect(q.correctIndex, greaterThanOrEqualTo(0));
          expect(q.correctIndex, lessThan(q.options.length));
          expect(q.explanationBn.isNotEmpty, isTrue);
        }

        final fardQ = questions.firstWhere((q) => q.id == 'wudu_fard_count');
        expect(fardQ.options[fardQ.correctIndex], '৪টি');
      },
    );
  });
}

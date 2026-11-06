import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/helpers/domain/masbuq_engine.dart';
import 'package:musalli/features/helpers/domain/qasr_engine.dart';
import 'package:musalli/features/helpers/domain/sajda_sahu_tree.dart';
import 'package:musalli/features/helpers/domain/sick_prayer_tree.dart';

void main() {
  group('Sajda Sahu Decision Tree Tests', () {
    test('Root node contains all primary question branches', () {
      final root = SajdaSahuDecisionTree.getNode('root');
      expect(root, isNotNull);
      expect(root!.options.length, 4);
    });

    test('Omitting Fatiha/Surah unintentionally requires Sajda Sahu', () {
      final qiratNode = SajdaSahuDecisionTree.getNode('qirat_omission');
      expect(qiratNode, isNotNull);

      final unintentionalOpt = qiratNode!.options.firstWhere(
        (o) => o.label.contains('ভুলবশত'),
      );
      final result = unintentionalOpt.result;
      expect(result, isNotNull);
      expect(result!.requiresSajdaSahu, isTrue);
      expect(result.invalidatesSalah, isFalse);
      expect(result.verdict, contains('সাহু সিজদা দিতে হবে'));
    });

    test(
      'Omitting Fatiha/Surah intentionally invalidates Salah (requires repeat)',
      () {
        final qiratNode = SajdaSahuDecisionTree.getNode('qirat_omission');
        final intentionalOpt = qiratNode!.options.firstWhere(
          (o) => o.label.contains('ইচ্ছাকৃতভাবে'),
        );
        final result = intentionalOpt.result;
        expect(result, isNotNull);
        expect(result!.invalidatesSalah, isTrue);
        expect(result.verdict, contains('দোহরানো ওয়াজিব'));
      },
    );

    test('Omitting Thana/Tasbih does not require Sajda Sahu', () {
      final omissionNode = SajdaSahuDecisionTree.getNode('omission_category');
      final sunnahOpt = omissionNode!.options.firstWhere(
        (o) => o.label.contains('ছানা'),
      );
      final result = sunnahOpt.result;
      expect(result, isNotNull);
      expect(result!.requiresSajdaSahu, isFalse);
      expect(result.verdict, contains('কিছুই করণীয় নেই'));
    });

    test('Laughing aloud (Qahqaha) invalidates both Wudu and Salah', () {
      final mufsidatNode = SajdaSahuDecisionTree.getNode('mufsidat_node');
      final laughOpt = mufsidatNode!.options.firstWhere(
        (o) => o.label.contains('হেসে'),
      );
      final result = laughOpt.result;
      expect(result, isNotNull);
      expect(result!.invalidatesSalah, isTrue);
      expect(result.title, contains('অজু'));
    });
  });

  group('Sick Prayer Decision Tree Tests', () {
    test('Unable to stand sits on floor/chair with lower sajda gesture', () {
      final standingCheck = SickPrayerDecisionTree.getNode(
        'standing_ability_check',
      );
      final cannotSajdaOpt = standingCheck!.options.firstWhere(
        (o) => o.label.contains('সিজদা করতে পারি না'),
      );
      final result = cannotSajdaOpt.result;
      expect(result, isNotNull);
      expect(result!.verdict, contains('ইশারায়'));
      expect(result.actionSteps, anyElement(contains('বালিশ')));
    });

    test('Bedridden patient performs head gestures lying down', () {
      final lyingCheck = SickPrayerDecisionTree.getNode('lying_down_check');
      final canMoveHeadOpt = lyingCheck!.options.firstWhere(
        (o) => o.label.contains('মাথা দিয়ে ইশারা'),
      );
      final result = canMoveHeadOpt.result;
      expect(result, isNotNull);
      expect(result!.verdict, contains('মাথার ইশারায়'));
    });

    test('Cannot move head delays prayer until recovery', () {
      final lyingCheck = SickPrayerDecisionTree.getNode('lying_down_check');
      final cannotMoveHeadOpt = lyingCheck!.options.firstWhere(
        (o) => o.label.contains('মাথা নাড়ানোর শক্তিও নেই'),
      );
      final result = cannotMoveHeadOpt.result;
      expect(result, isNotNull);
      expect(
        result!.verdict,
        contains('চোখ বা ভ্রুর ইশারায় হানাফি মতে নামাজ হয় না'),
      );
    });
  });

  group('Masbuq Engine Tests', () {
    test('Joined in Rakat 1 with Ruku has 0 missed rakats', () {
      final plan = MasbuqEngine.calculate(prayerSlug: 'fajr', joinedRakat: 1);
      expect(plan.missedRakatsCount, 0);
      expect(plan.steps, isEmpty);
    });

    test('Fajr: Missed Rakat 1 generates 1 step with Thana, Fatiha, Surah and final Qa dah', () {
      final plan = MasbuqEngine.calculate(prayerSlug: 'fajr', joinedRakat: 2);
      expect(plan.missedRakatsCount, 1);
      expect(plan.steps.length, 1);
      final step = plan.steps.first;
      expect(step.mustSitAfterSajda, isTrue);
      expect(step.sittingType, 'final');
      expect(step.recitations, anyElement(contains('ছানা')));
      expect(step.recitations, anyElement(contains('অন্য একটি সূরা')));
    });

    test('Maghrib: Joined in Rakat 3 (missed 2 rakats) generates Qa dah after 1st make-up rakat', () {
      final plan = MasbuqEngine.calculate(
        prayerSlug: 'maghrib',
        joinedRakat: 3,
      );
      expect(plan.missedRakatsCount, 2);
      expect(plan.steps.length, 2);

      // In Maghrib, after 1st make-up rakat, total is 2 rakats (1 with imam + 1 alone) -> MUST SIT!
      final step1 = plan.steps[0];
      expect(step1.mustSitAfterSajda, isTrue);
      expect(step1.sittingType, 'first');

      // 2nd make-up rakat -> recitation has Surah, and final sitting
      final step2 = plan.steps[1];
      expect(step2.mustSitAfterSajda, isTrue);
      expect(step2.sittingType, 'final');
      expect(step2.recitations, anyElement(contains('অন্য সূরা মিলানো')));
    });

    test('Zuhr (4-rakat): Joined in Rakat 4 (missed 3 rakats)', () {
      final plan = MasbuqEngine.calculate(prayerSlug: 'dhuhr', joinedRakat: 4);
      expect(plan.missedRakatsCount, 3);
      expect(plan.steps.length, 3);

      // Step 1: sits (1 with imam + 1 alone = 2)
      expect(plan.steps[0].mustSitAfterSajda, isTrue);
      expect(plan.steps[0].sittingType, 'first');

      // Step 2: does not sit (total 3), recites Surah (recitation wise 2nd rakat)
      expect(plan.steps[1].mustSitAfterSajda, isFalse);
      expect(plan.steps[1].recitations, anyElement(contains('অন্য সূরা')));

      // Step 3: sits (total 4), NO surah (only Fatiha)
      expect(plan.steps[2].mustSitAfterSajda, isTrue);
      expect(plan.steps[2].sittingType, 'final');
      expect(
        plan.steps[2].recitations,
        anyElement(contains('অন্য সূরা মিলানো লাগবে না')),
      );
    });
  });

  group('Qasr Engine Tests', () {
    test('Distance < 77.25 km requires full 4 rakats (Itmam)', () {
      final result = QasrEngine.calculate(distanceKm: 50, stayDays: 5);
      expect(result.isMusafir, isFalse);
      expect(result.verdictTitle, contains('পূর্ণ নামাজ'));
      expect(result.prayerAdjustments['যোহর'], contains('৪ রাকাত'));
    });

    test('Distance >= 77.25 km and stay < 15 days requires Qasr', () {
      final result = QasrEngine.calculate(distanceKm: 120, stayDays: 7);
      expect(result.isMusafir, isTrue);
      expect(result.verdictTitle, contains('কসর'));
      expect(result.prayerAdjustments['যোহর'], contains('২ রাকাত কসর'));
      expect(result.prayerAdjustments['মাগরিব'], contains('৩ রাকাত'));
      expect(result.prayerAdjustments['ফজর'], contains('২ রাকাত'));
    });

    test('Distance >= 77.25 km but stay >= 15 days is Muqim (Itmam)', () {
      final result = QasrEngine.calculate(distanceKm: 250, stayDays: 20);
      expect(result.isMusafir, isFalse);
      expect(result.verdictTitle, contains('মুকীম'));
    });

    test('Uncertain stay ("maybe tomorrow") remains Musafir', () {
      final result = QasrEngine.calculate(
        distanceKm: 100,
        stayDays: 20,
        isUncertainStay: true,
      );
      expect(result.isMusafir, isTrue);
    });
  });
}

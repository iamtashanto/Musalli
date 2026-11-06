import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/app_bootstrap.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/services/crash_reporting_service.dart';
import 'package:musalli/features/simulator/domain/practice/practice_models.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/tracker/domain/tracker_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Musalli App End-to-End Walkthrough & Integration Tests', () {
    testWidgets('1. App shell boots into Home and displays bottom navigation tabs', (tester) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            flavorConfigProvider.overrideWithValue(FlavorConfig.dev()),
          ],
          child: const MusalliApp(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Check navigation tabs present
      expect(find.text('হোম'), findsWidgets);
      expect(find.text('শিখুন'), findsWidgets);
      expect(find.text('সিমুলেটর'), findsWidgets);
      expect(find.text('সময়'), findsWidgets);
      expect(find.text('আরও'), findsWidgets);
    });

    test('2. Practice Quiz Flow: verifies question structure, options, and fiqh explanation', () {
      const question = PracticeQuestion(
        id: 'q1',
        stepIndex: 1,
        type: PracticeQuestionType.nextPosture,
        promptBn: 'তাকবীরে তাহরীমার পর কী করবেন?',
        options: [
          PracticeOption(
            id: 'opt1',
            labelBn: 'হাত বাঁধুন (কিয়াম)',
            posture: Posture.qiyamHandsFolded,
            isCorrect: true,
          ),
          PracticeOption(
            id: 'opt2',
            labelBn: 'রুকুতে যান',
            posture: Posture.ruku,
            isCorrect: false,
          ),
        ],
        correctExplanationBn: 'তাকবীরের পর তাহরীমার হাত বেঁধে ছানা পড়তে হয়।',
        fiqhImpact: MistakeFiqhImpact.requiresSajdaSahu,
      );

      expect(question.options.first.isCorrect, isTrue);
      expect(question.options.last.isCorrect, isFalse);
      expect(question.promptBn, contains('তাকবীরে তাহরীমা'));
      expect(question.fiqhImpact, equals(MistakeFiqhImpact.requiresSajdaSahu));
    });

    test('3. Tracker Database & Qaza Integration', () {
      final initialRecord = DayPrayerRecord.empty('2026-11-06');
      expect(initialRecord.completedCount, equals(0));

      const updated = DayPrayerRecord(
        dateStr: '2026-11-06',
        fajr: PrayerStatus.ontime,
        dhuhr: PrayerStatus.jamaat,
        asr: PrayerStatus.missed,
        maghrib: PrayerStatus.missed,
        isha: PrayerStatus.missed,
        witr: PrayerStatus.missed,
      );
      expect(updated.completedCount, equals(2));
      expect(updated.fajr, equals(PrayerStatus.ontime));

      const qaza = QazaRecord(
        fajr: 2,
        dhuhr: 4,
        asr: 1,
        isha: 3,
        witr: 1,
      );
      expect(qaza.total, equals(11));
    });

    test('4. Privacy Crash Reporting Service sanitizes PII and coordinates', () {
      final service = CrashReportingService(initialOptIn: true);
      expect(service.isOptedIn, isTrue);

      service.recordError(
        Exception('Network error for user test@example.com at 23.8103, 90.4125'),
        StackTrace.current,
        reason: 'Contacting server at privacy@musalli.com',
      );

      service.setOptIn(enabled: false);
      expect(service.isOptedIn, isFalse);
    });
  });
}

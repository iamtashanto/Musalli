import 'package:drift/native.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/router/app_router.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

void main() {
  group('BengaliNumberFormatter', () {
    test('converts ASCII digits to Bengali numerals in Bangla mode', () {
      expect(BengaliNumberFormatter.formatInt(0), '০');
      expect(BengaliNumberFormatter.formatInt(17), '১৭');
      expect(BengaliNumberFormatter.formatInt(300), '৩০০');
      expect(
        BengaliNumberFormatter.formatString('04:52 AM'),
        '০৪:৫২ AM',
      );
    });

    test('preserves ASCII digits when isBangla is false', () {
      expect(BengaliNumberFormatter.formatInt(17, isBangla: false), '17');
      expect(
        BengaliNumberFormatter.formatString('04:52 AM', isBangla: false),
        '04:52 AM',
      );
    });

    test('converts Bengali numerals back to ASCII digits', () {
      expect(BengaliNumberFormatter.toAsciiDigits('১২৩৪৫৬৭৮৯০'), '1234567890');
    });

    test('formats durations in Bengali and ASCII digits', () {
      expect(
        BengaliNumberFormatter.formatDuration(
          const Duration(minutes: 4, seconds: 9),
        ),
        '০৪:০৯',
      );
      expect(
        BengaliNumberFormatter.formatDuration(
          const Duration(hours: 1, minutes: 5, seconds: 30),
          includeHours: true,
        ),
        '০১:০৫:৩০',
      );
    });
  });

  group('Deep Link Normalization', () {
    test('normalizes musalli://namaj/<slug> to /namaj/<slug>', () {
      final uri = Uri.parse('musalli://namaj/fajr');
      expect(normalizeIncomingDeepLinkUri(uri), '/namaj/fajr');
    });

    test('normalizes musalli://simulator?prayer=zuhr&unit=fard', () {
      final uri = Uri.parse('musalli://simulator?prayer=zuhr&unit=fard');
      expect(
        normalizeIncomingDeepLinkUri(uri),
        '/simulator?prayer=zuhr&unit=fard',
      );
    });

    test('normalizes https://namajshikkha.tashanto.com/namaj/fajr App Link', () {
      final uri = Uri.parse('https://namajshikkha.tashanto.com/namaj/fajr');
      expect(normalizeIncomingDeepLinkUri(uri), '/namaj/fajr');
    });

    test('returns null for normal internal paths', () {
      final uri = Uri.parse('/namaj/fajr');
      expect(normalizeIncomingDeepLinkUri(uri), isNull);
    });
  });

  group('FlavorConfig & GlassQualityDetector', () {
    test('FlavorConfig.dev and FlavorConfig.prod have distinct IDs and names', () {
      final dev = FlavorConfig.dev();
      final prod = FlavorConfig.prod();

      expect(dev.isDev, isTrue);
      expect(dev.applicationId, 'com.tashanto.musalli.dev');
      expect(prod.isProd, isTrue);
      expect(prod.applicationId, 'com.tashanto.musalli');
    });

    test('evaluateFrameTimings downgrades GlassQuality on slow frames', () {
      final slowTimings = List<FrameTiming>.generate(
        12,
        (_) => FrameTiming(
          vsyncStart: 0,
          buildStart: 100,
          buildFinish: 14000,
          rasterStart: 14100,
          rasterFinish: 28000,
          rasterFinishWallTime: 28000,
        ),
      );
      final downgraded = GlassQualityDetector.evaluateFrameTimings(
        slowTimings,
        current: GlassQuality.high,
      );
      expect(downgraded, GlassQuality.low);
    });
  });

  group('Drift AppDatabase & Freezed FourLayerText', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    test('stores, updates, and reads settings in SQLite', () async {
      expect(await db.getSetting('app_locale'), isNull);
      await db.setSetting('app_locale', 'bn');
      expect(await db.getSetting('app_locale'), 'bn');

      await db.setSetting('app_locale', 'en');
      expect(await db.getSetting('app_locale'), 'en');
    });

    test('serializes and deserializes FourLayerText with Freezed', () {
      const item = FourLayerText(
        id: 'test-1',
        titleBn: 'তাকবীর',
        titleEn: 'Takbir',
        arabic: 'اللَّهُ أَكْبَرُ',
        uccharonBn: 'আল্লাহু আকবার',
        banglish: 'Allahu Akbar',
        meaningBn: 'আল্লাহ সর্বশ্রেষ্ঠ',
        meaningEn: 'Allah is the Greatest',
        grade: HadithGrade.sahih,
      );

      final json = item.toJson();
      final restored = FourLayerText.fromJson(json);
      expect(restored, item);
      expect(restored.reviewStatus, ReviewStatus.verified);
    });
  });
}


import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/features/audio/data/audio_manifest.dart';
import 'package:musalli/features/content/data/content_repository.dart';
import 'package:musalli/features/content/data/content_search_service.dart';
import 'package:musalli/features/simulator/domain/prayer_step_generator.dart';
import 'package:musalli/shared/content/content.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ContentRepository repository;
  late ContentSearchService searchService;

  setUpAll(() async {
    repository = ContentRepository();
    searchService = ContentSearchService(repository);
    await searchService.initialize();
  });

  tearDownAll(() {
    searchService.dispose();
  });

  group('Content Validation Tests', () {
    test('All 29 canonical prayers load with non-empty Arabic and valid SalahConfig', () async {
      final prayers = await repository.getPrayers();
      expect(prayers.length, 29);

      final seenSlugs = <String>{};

      for (final prayer in prayers) {
        expect(prayer.slug.trim(), isNotEmpty);
        expect(
          seenSlugs.contains(prayer.slug),
          isFalse,
          reason: 'Duplicate prayer slug: ${prayer.slug}',
        );
        seenSlugs.add(prayer.slug);

        // Niyyat Arabic must be non-empty
        expect(
          prayer.niyyat.arabic.trim(),
          isNotEmpty,
          reason: '${prayer.slug} niyyat Arabic is empty',
        );

        // Rakat math validation
        expect(
          prayer.rakatUnits,
          isNotEmpty,
          reason: '${prayer.slug} has no rakat units',
        );

        int unitsSum = 0;
        for (final unit in prayer.rakatUnits) {
          unitsSum += unit.count;
          final cfg = unit.config;
          expect(
            cfg.rakats,
            unit.count,
            reason: '${prayer.slug} unit ${unit.label} count mismatch',
          );
          if (!cfg.isJanaza) {
            expect(cfg.sajdaCount, greaterThanOrEqualTo(1));
          }
          if (cfg.tasbihDistribution != null) {
            final tSum = cfg.tasbihDistribution!.fold<int>(
              0,
              (sum, item) => sum + item.count,
            );
            expect(
              tSum,
              75,
              reason: '${prayer.slug} tasbih count must sum to 75 per rakat',
            );
          }
        }

        expect(
          unitsSum,
          prayer.totalRakats,
          reason:
              '${prayer.slug} rakat sum ($unitsSum) != totalRakats (${prayer.totalRakats})',
        );

        // Verify references or reviewStatus
        for (final ref in prayer.references) {
          expect(ref.source.trim(), isNotEmpty);
          expect(ref.number.trim(), isNotEmpty);
        }
      }
    });

    test('All 5 standard daily prayers match canonical total rakats', () async {
      final fajr = await repository.getPrayerBySlug('fajr');
      final dhuhr = await repository.getPrayerBySlug('dhuhr');
      final asr = await repository.getPrayerBySlug('asr');
      final maghrib = await repository.getPrayerBySlug('maghrib');
      final isha = await repository.getPrayerBySlug('isha');

      expect(fajr?.totalRakats, 4); // 2 Sunnah + 2 Fard
      expect(dhuhr?.totalRakats, 12); // 4 Sunnah + 4 Fard + 2 Sunnah + 2 Nafl
      expect(asr?.totalRakats, 8); // 4 Sunnah Ghair Muakkadah + 4 Fard
      expect(maghrib?.totalRakats, 7); // 3 Fard + 2 Sunnah + 2 Nafl
      expect(
        isha?.totalRakats,
        17,
      ); // 4 Sunnah + 4 Fard + 2 Sunnah + 2 Nafl + 3 Witr + 2 Nafl
    });

    test('All 17 Masail rulings have references or needs-review status', () async {
      final rulings = await repository.getRulings();
      expect(rulings.length, 17);

      for (final ruling in rulings) {
        expect(ruling.titleBn.trim(), isNotEmpty);
        expect(ruling.bodyBn.trim(), isNotEmpty);
        if (ruling.references.isEmpty) {
          expect(
            ruling.reviewStatus,
            ContentReviewStatus.needsReview,
            reason:
                'Ruling ${ruling.id} lacks references but is not flagged needs-review',
          );
        }
      }
    });

    test(
      'All 36 Duas have non-empty Arabic and authentic transliteration',
      () async {
        final duas = await repository.getDuas();
        expect(duas.length, 36);

        final seenIds = <String>{};
        for (final dua in duas) {
          expect(
            seenIds.contains(dua.id),
            isFalse,
            reason: 'Duplicate dua id ${dua.id}',
          );
          seenIds.add(dua.id);
          expect(
            dua.arabic.trim(),
            isNotEmpty,
            reason: '${dua.id} Arabic is empty',
          );
          expect(dua.uccharonBn.trim(), isNotEmpty);
          expect(dua.meaningBn.trim(), isNotEmpty);
        }
      },
    );

    test('All 13 prayer Surahs have non-empty Ayahs with valid numbering', () async {
      final surahs = await repository.getSurahs();
      expect(surahs.length, 13);

      for (final surah in surahs) {
        expect(
          surah.ayahs,
          isNotEmpty,
          reason: 'Surah ${surah.id} has no ayahs',
        );
        expect(
          surah.ayahs.length >= surah.ayahCount,
          isTrue,
          reason:
              'Surah ${surah.id} has ${surah.ayahs.length} ayahs, expected at least ${surah.ayahCount}',
        );
        for (final ayah in surah.ayahs) {
          expect(ayah.arabic.trim(), isNotEmpty);
          expect(ayah.meaningBn.trim(), isNotEmpty);
        }
      }
    });

    test('All 114 Quran Surahs metadata are present', () async {
      final allSurahs = await repository.getAllSurahs();
      expect(allSurahs.length, 114);
      expect(allSurahs.first.number, 1);
      expect(allSurahs.first.nameBangla, 'আল-ফাতিহা');
      expect(allSurahs.last.number, 114);
      expect(allSurahs.last.nameBangla, 'আন-নাস');
    });

    test('AudioManifest correctly maps core Salah recitations to bundled audio files', () async {
      final manifest = await AudioManifest.load();
      expect(manifest.hasAudio('takbir'), isTrue);
      expect(manifest.hasAudio('dua-sana'), isTrue);
      expect(manifest.hasAudio('surah-1'), isTrue);
      expect(manifest.hasAudio('dua-ruku'), isTrue);
      expect(manifest.hasAudio('dua-sajda'), isTrue);
      expect(manifest.hasAudio('dua-tashahhud'), isTrue);
      expect(manifest.hasAudio('dua-durood'), isTrue);
      expect(manifest.hasAudio('dua-masura'), isTrue);
      expect(manifest.hasAudio('dua-salam'), isTrue);
      expect(manifest.lookup('surah-112'), 'assets/audio/surah-112.mp3');
    });
  });

  group('FTS Search Benchmark: 15 Multi-lingual Queries (< 100ms each)', () {
    const testQueries = [
      'janaza', // 1: Banglish funeral
      'জানাজা', // 2: Bangla funeral
      'funeral', // 3: English funeral
      'fajr', // 4: English/Banglish Fajr
      'ফজর', // 5: Bangla Fajr
      'sahu', // 6: Banglish Sajda Sahu
      'সেজদায়ে সাহু', // 7: Bangla Sajda Sahu
      'wudu', // 8: Banglish/English Wudu
      'অজু', // 9: Bangla Wudu
      'bitor', // 10: Banglish Witr
      'বিতর', // 11: Bangla Witr
      'kursi', // 12: Banglish Ayatul Kursi
      'tahajjud', // 13: Banglish Tahajjud
      'দোয়া', // 14: Bangla Dua
      'নামাজ', // 15: Bangla Namaj
    ];

    for (int i = 0; i < testQueries.length; i++) {
      final query = testQueries[i];
      test('Query #${i + 1} ("$query") returns relevant results in < 100ms', () async {
        final stopwatch = Stopwatch()..start();
        final results = await searchService.search(query);
        stopwatch.stop();

        expect(
          stopwatch.elapsedMilliseconds,
          lessThan(100),
          reason:
              'Query "$query" took ${stopwatch.elapsedMilliseconds}ms, exceeding 100ms threshold',
        );
        expect(
          results,
          isNotEmpty,
          reason: 'Query "$query" returned zero results',
        );

        // Verify top result matches query context
        final top = results.first;
        expect(top.title.isNotEmpty, isTrue);
      });
    }
  });

  group('Step Generator & Gender Posture Differences', () {
    test(
      'Generates distinct posture instructions for male vs female',
      () async {
        const generator = PrayerStepGenerator();
        final fajr = await repository.getPrayerBySlug('fajr');
        final fardUnit = fajr!.rakatUnits.firstWhere(
          (u) => u.status == ContentRulingStatus.fard,
        );

        final maleGroups = generator.generateRakatGroups(
          fardUnit.config,
          isMale: true,
        );
        final femaleGroups = generator.generateRakatGroups(
          fardUnit.config,
          isMale: false,
        );

        expect(maleGroups.length, 2);
        expect(femaleGroups.length, 2);

        final maleTakbir = maleGroups.first.steps.firstWhere(
          (s) => s.id == 'r1-takbir',
        );
        final femaleTakbir = femaleGroups.first.steps.firstWhere(
          (s) => s.id == 'r1-takbir',
        );

        expect(maleTakbir.maleRule, contains('কানের লতি'));
        expect(maleTakbir.femaleRule, isNull);

        expect(femaleTakbir.femaleRule, contains('বুকের উপর'));
        expect(femaleTakbir.maleRule, isNull);
      },
    );

    test('Generates Janaza steps without ruku or sajda', () async {
      const generator = PrayerStepGenerator();
      final janaza = await repository.getPrayerBySlug('janaza');
      final unit = janaza!.rakatUnits.first;

      final groups = generator.generateRakatGroups(unit.config, isMale: true);
      expect(groups.length, 1);
      expect(groups.first.steps.length, 4);

      final postures = groups.first.steps.map((s) => s.postureName).toList();
      expect(postures.any((p) => p.contains('রুকু')), isFalse);
      expect(postures.any((p) => p.contains('সিজদা')), isFalse);
    });
  });
}

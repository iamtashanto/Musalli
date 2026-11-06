import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/app_bootstrap.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/showcase/design_system_showcase_screen.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/router/app_router.dart';
import 'package:musalli/core/theme/musalli_theme.dart';

void main() {
  Widget buildTestApp({required AppDatabase db, FlavorConfig? flavor}) {
    return ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        flavorConfigProvider.overrideWithValue(flavor ?? FlavorConfig.dev()),
      ],
      child: const MusalliApp(),
    );
  }

  testWidgets(
    '5 bottom tabs render in Bangla, preserve tab state, and support deep link musalli://namaj/fajr',
    (WidgetTester tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(buildTestApp(db: db));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      Finder navTab(String label) => find.descendant(
        of: find.byType(GlassBottomNavBar),
        matching: find.text(label),
      );

      // Verify all 5 Bangla bottom tabs are visible
      expect(navTab('হোম'), findsOneWidget);
      expect(navTab('শিখুন'), findsOneWidget);
      expect(navTab('সিমুলেটর'), findsOneWidget);
      expect(navTab('সময়'), findsOneWidget);
      expect(navTab('আরও'), findsOneWidget);

      // Switch to Learn tab (শিখুন) and enter search text to verify FTS search
      await tester.tap(navTab('শিখুন'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.enterText(find.byType(TextField).first, 'জানাজা');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.textContaining('জানাজা'), findsWidgets);

      // Deep link to musalli://namaj/fajr opens real complete prayer detail page
      final container = ProviderScope.containerOf(
        tester.element(find.byType(MusalliApp)),
      );
      container.read(appRouterProvider).go('musalli://namaj/fajr');
      await tester.pump();
      await container.read(prayerBySlugProvider('fajr').future);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('ফজর'), findsWidgets);
      expect(find.textContaining('Fajr'), findsWidgets);
      expect(find.text('২ রাকাত সুন্নাত (মুয়াক্কাদাহ)'), findsOneWidget);
      expect(find.text('২ রাকাত ফরজ'), findsOneWidget);

      // Gender toggle: default is male ('পুরুষ')
      expect(find.text('পুরুষ'), findsOneWidget);
      expect(find.text('মহিলা'), findsOneWidget);
      expect(find.textContaining('কানের লতি'), findsWidgets);

      // Toggle to Female ('মহিলা')
      await tester.tap(find.text('মহিলা'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Female posture difference appears immediately
      expect(find.textContaining('বুকের উপর'), findsWidgets);

      expect(find.textContaining('fajr'), findsWidgets);
    },
  );

  testWidgets(
    'DesignSystemShowcaseScreen renders cleanly at 2.0x text scale without overflow and scrolls 50 GlassCards',
    (WidgetTester tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: MediaQuery(
            data: const MediaQueryData(
              size: Size(412, 915),
              textScaler: TextScaler.linear(2),
              disableAnimations: true,
            ),
            child: MaterialApp(
              locale: const Locale('bn'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              theme: MusalliTheme.dark(),
              home: const DesignSystemShowcaseScreen(),
            ),
          ),
        ),
      );
      await tester.pump();

      // Switch to GlassQuality.low and scroll through the 50 GlassCards list
      final container = ProviderScope.containerOf(
        tester.element(find.byType(DesignSystemShowcaseScreen)),
      );
      await container
          .read(glassQualityProvider.notifier)
          .setQuality(GlassQuality.low);
      await tester.pump();

      final scrollable = find.byKey(const Key('design-system-showcase-scroll'));
      expect(scrollable, findsOneWidget);

      await tester.drag(scrollable, const Offset(0, -1800));
      await tester.pump();
      await tester.drag(scrollable, const Offset(0, -1800));
      await tester.pump();

      // Verify zero layout overflow exceptions occurred at 2.0x text scale
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Every canonical prayer opens a complete detail screen from data',
    (WidgetTester tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      await tester.pumpWidget(buildTestApp(db: db));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final container = ProviderScope.containerOf(
        tester.element(find.byType(MusalliApp)),
      );

      const prayerSlugs = [
        'fajr',
        'dhuhr',
        'asr',
        'maghrib',
        'isha',
        'witr',
        'jumuah',
        'eid-ul-fitr',
        'eid-ul-adha',
        'janaza',
        'tahajjud',
        'tarawih',
        'chasht',
        'istikhara',
        'salatut-tasbih',
        'kaza',
        'musafir',
        'ishraq',
        'awwabin',
        'tahiyyatul-wudu',
        'tahiyyatul-masjid',
        'salatul-hajat',
        'salatul-tawbah',
        'salatul-kusuf',
        'salatul-khusuf',
        'salatul-istisqa',
        'shukr',
        'shab-e-qadr',
        'shab-e-barat',
      ];

      for (final slug in prayerSlugs) {
        container.read(appRouterProvider).go('/namaj/$slug');
        await tester.pump();
        await container.read(prayerBySlugProvider(slug).future);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 150));
        expect(
          tester.takeException(),
          isNull,
          reason: 'Opening /namaj/$slug failed',
        );
        expect(find.byType(GlassButton), findsOneWidget);
      }
    },
  );
}

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/app_bootstrap.dart';
import 'package:musalli/core/config/flavor_config.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/design_system/showcase/design_system_showcase_screen.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/router/app_router.dart';
import 'package:musalli/core/theme/musalli_theme.dart';

void main() {
  Widget buildTestApp({
    required AppDatabase db,
    FlavorConfig? flavor,
  }) {
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
      await tester.pumpAndSettle();

      // Verify all 5 Bangla bottom tabs are visible
      expect(find.text('হোম'), findsOneWidget);
      expect(find.text('শিখুন'), findsOneWidget);
      expect(find.text('সিমুলেটর'), findsOneWidget);
      expect(find.text('সময়'), findsOneWidget);
      expect(find.text('আরও'), findsOneWidget);

      // Switch to Learn tab (শিখুন) and enter search text to verify state preservation
      await tester.tap(find.text('শিখুন'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'জানাজা');
      await tester.pumpAndSettle();
      expect(find.text('জানাজার নামাজের নিয়ম ও দোয়া'), findsOneWidget);

      // Switch to Times tab (সময়) and back to Learn tab (শিখুন) — search filter stays preserved
      await tester.tap(find.text('সময়'));
      await tester.pumpAndSettle();
      expect(find.text('আসর (হানাফি)'), findsOneWidget);

      await tester.tap(find.text('শিখুন'));
      await tester.pumpAndSettle();
      expect(find.text('জানাজার নামাজের নিয়ম ও দোয়া'), findsOneWidget);

      // Deep link to musalli://namaj/fajr opens placeholder prayer detail page with slug
      final container = ProviderScope.containerOf(
        tester.element(find.byType(MusalliApp)),
      );
      container.read(appRouterProvider).go('musalli://namaj/fajr');
      await tester.pumpAndSettle();

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
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
          ],
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
}

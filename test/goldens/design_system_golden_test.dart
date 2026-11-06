import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/glass/glass_quality.dart';
import 'package:musalli/core/l10n/arb/app_localizations.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/theme/musalli_theme.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

class _TestGlassQualityNotifier extends GlassQualityNotifier {
  _TestGlassQualityNotifier(this._initial);
  final GlassQuality _initial;

  @override
  GlassQuality build() => _initial;
}

Widget _buildGoldenSubject({
  required ThemeData theme,
  required GlassQuality quality,
  required AppDatabase db,
}) {
  const sampleText = FourLayerText(
    id: 'golden-takbir',
    titleBn: 'তাকবীরে তাহরীমা',
    titleEn: 'Takbiratul Ihram',
    arabic: 'اللَّهُ أَكْبَرُ',
    uccharonBn: 'আল্লাহু আকবার',
    banglish: 'Allahu Akbar',
    meaningBn: 'আল্লাহ সর্বশ্রেষ্ঠ।',
    meaningEn: 'Allah is the Greatest.',
    referenceTextBn: 'সহীহ বুখারী ৭৫৭',
    grade: HadithGrade.sahih,
  );

  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      glassQualityProvider
          .overrideWith(() => _TestGlassQualityNotifier(quality)),
    ],
    child: MediaQuery(
      data: const MediaQueryData(
        size: Size(420, 620),
        disableAnimations: true,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('bn'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: theme,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    RulingBadge(category: RulingCategory.fard),
                    RulingBadge(category: RulingCategory.wajib),
                    RulingBadge(category: RulingCategory.sunnah),
                    RulingBadge(category: RulingCategory.nafl),
                    ReferenceChip(
                      citation: 'সহীহ বুখারী ৭৫৭',
                      grade: HadithGrade.sahih,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GlassButton(
                        label: 'সিমুলেটর',
                        icon: Icons.play_arrow_rounded,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GlassButton(
                        label: 'বিস্তারিত',
                        variant: GlassButtonVariant.secondary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const ArabicBlock(
                  data: sampleText,
                  initialShowBanglish: true,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  group('Design System Golden Tests (Light/Dark x High/Low GlassQuality)', () {
    final matrix = <({String name, ThemeData theme, GlassQuality quality})>[
      (
        name: 'ds_dark_high',
        theme: MusalliTheme.dark(),
        quality: GlassQuality.high,
      ),
      (
        name: 'ds_dark_low',
        theme: MusalliTheme.dark(),
        quality: GlassQuality.low,
      ),
      (
        name: 'ds_light_high',
        theme: MusalliTheme.light(),
        quality: GlassQuality.high,
      ),
      (
        name: 'ds_light_low',
        theme: MusalliTheme.light(),
        quality: GlassQuality.low,
      ),
    ];

    for (final config in matrix) {
      testWidgets(
        'matches golden snapshot for ${config.name}',
        (WidgetTester tester) async {
          final db = AppDatabase(NativeDatabase.memory());
          addTearDown(db.close);

          await tester.binding.setSurfaceSize(const Size(420, 620));
          addTearDown(() => tester.binding.setSurfaceSize(null));

          await tester.pumpWidget(
            _buildGoldenSubject(
              theme: config.theme,
              quality: config.quality,
              db: db,
            ),
          );
          await tester.pump();

          await expectLater(
            find.byType(Scaffold),
            matchesGoldenFile('goldens/${config.name}.png'),
          );
        },
      );
    }
  });
}
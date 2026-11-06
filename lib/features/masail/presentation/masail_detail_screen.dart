import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Universal detail screen for any Masail ruling.
class MasailDetailScreen extends ConsumerWidget {
  const MasailDetailScreen({required this.slug, super.key});

  final String slug;

  static const List<Map<String, String>> _sajdaTilawatAyahs = [
    {'surah': "সূরা আল-আ'রাফ", 'ayah': 'আয়াত ২০৬', 'juz': 'পারা ৯'},
    {'surah': "সূরা আর-রা'দ", 'ayah': 'আয়াত ১৫', 'juz': 'পারা ১৩'},
    {'surah': 'সূরা আন-নাহল', 'ayah': 'আয়াত ৪৯-৫০', 'juz': 'পারা ১৪'},
    {'surah': 'সূরা বনী ইসরাঈল', 'ayah': 'আয়াত ১০৯', 'juz': 'পারা ১৫'},
    {'surah': 'সূরা মারইয়াম', 'ayah': 'আয়াত ৫৮', 'juz': 'পারা ১৬'},
    {'surah': 'সূরা আল-হাজ্জ (১ম)', 'ayah': 'আয়াত ১৮', 'juz': 'পারা ১৭'},
    {'surah': 'সূরা আল-ফুরকান', 'ayah': 'আয়াত ৬০', 'juz': 'পারা ১৯'},
    {'surah': 'সূরা আন-নামল', 'ayah': 'আয়াত ২৫-২৬', 'juz': 'পারা ১৯'},
    {'surah': 'সূরা আস-সাজদাহ', 'ayah': 'আয়াত ১৫', 'juz': 'পারা ২১'},
    {'surah': 'সূরা সাদ', 'ayah': 'আয়াত ২৪', 'juz': 'পারা ২৩'},
    {'surah': 'সূরা হা-মীম সাজদাহ', 'ayah': 'আয়াত ৩৭-৩৮', 'juz': 'পারা ২৪'},
    {'surah': 'সূরা আন-নাজম', 'ayah': 'আয়াত ৬২', 'juz': 'পারা ২৭'},
    {'surah': 'সূরা আল-ইনশিকাক', 'ayah': 'আয়াত ২০-২১', 'juz': 'পারা ৩০'},
    {'surah': 'সূরা আল-আলাক', 'ayah': 'আয়াত ১৯', 'juz': 'পারা ৩০'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final rulingAsync = ref.watch(rulingBySlugProvider(slug));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: rulingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('ত্রুটি: $err')),
        data: (ruling) {
          if (ruling == null) {
            return Center(
              child: EmptyState(
                title: 'মাসআলা খুঁজে পাওয়া যায়নি',
                message: '"$slug" সম্পর্কিত কোনো বিবরণ পাওয়া যায়নি।',
              ),
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              GlassSliverAppBar(title: ruling.titleBn),

              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.spacing.md,
                  vertical: tokens.spacing.sm,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // 1. Header & Summary Box
                    GlassCard(
                      borderGlow: true,
                      padding: EdgeInsets.all(tokens.spacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  ruling.titleBn,
                                  style: typography.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              RulingBadge(
                                category: ruling.status.name == 'fard'
                                    ? RulingCategory.fard
                                    : ruling.status.name == 'wajib'
                                    ? RulingCategory.wajib
                                    : RulingCategory.sunnah,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ruling.titleEn,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          const Divider(height: 24),
                          Text(
                            'সারসংক্ষেপ:',
                            style: typography.label.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primaryEmerald,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ruling.summaryBn,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // Needs Review Banner
                    if (ruling.reviewStatus.name == 'needsReview') ...[
                      const Callout(
                        title: 'আলেমগণের পুনঃনিরীক্ষণাধীন',
                        message: 'এই বিষয়টি অধিকতর যাচাই ও ফিকহি প্রমাণের জন্য বিজ্ঞ মুফতিগণের বিশেষ পর্যালোচনায় রয়েছে।',
                        variant: CalloutVariant.warning,
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 2. Main Explanation (bodyBn)
                    GlassCard(
                      padding: EdgeInsets.all(tokens.spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'বিস্তারিত ব্যাখ্যা ও বিধান',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ruling.bodyBn,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // 3. Sajda Tilawat 14 Ayahs List (if applicable)
                    if (ruling.slug == 'sajda-tilawat') ...[
                      Text(
                        'পবিত্র কুরআনের ১৪টি সিজদার আয়াতসমূহ',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      ..._sajdaTilawatAyahs.asMap().entries.map((entry) {
                        final idx = entry.key + 1;
                        final item = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: GlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: colors.primaryEmerald.withValues(
                                      alpha: 0.15,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$idx',
                                      style: typography.label.copyWith(
                                        color: colors.primaryEmerald,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['surah']!,
                                        style: typography.bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        '${item['ayah']} • ${item['juz']}',
                                        style: typography.label.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.menu_book_rounded,
                                  size: 18,
                                  color: colors.primaryEmerald,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 4. Gender Differences (Men / Women notes)
                    if (ruling.genderDifferences != null &&
                        (ruling.genderDifferences!.male.isNotEmpty ||
                            ruling.genderDifferences!.female.isNotEmpty)) ...[
                      Text(
                        'পুরুষ ও নারীদের বিধানগত পার্থক্য',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      GlassCard(
                        padding: EdgeInsets.all(tokens.spacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (ruling.genderDifferences!.male.isNotEmpty) ...[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.male_rounded,
                                    color: colors.primaryEmerald,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'পুরুষদের জন্য:',
                                    style: typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colors.primaryEmerald,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                ruling.genderDifferences!.male.join('\n• '),
                                style: typography.bodyMedium.copyWith(
                                  color: colors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                              const Divider(height: 20),
                            ],
                            if (ruling
                                .genderDifferences!
                                .female
                                .isNotEmpty) ...[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.female_rounded,
                                    color: colors.goldAccent,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'নারীদের জন্য:',
                                    style: typography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colors.goldAccent,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                ruling.genderDifferences!.female.join('\n• '),
                                style: typography.bodyMedium.copyWith(
                                  color: colors.textSecondary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 6. FAQs Accordion
                    if (ruling.faqs != null && ruling.faqs!.isNotEmpty) ...[
                      Text(
                        'সচরাচর জিজ্ঞাসিত প্রশ্ন (FAQ)',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      ...ruling.faqs!.map((faq) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: GlassCard(
                            padding: EdgeInsets.zero,
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  faq.question,
                                  style: typography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                childrenPadding: EdgeInsets.fromLTRB(
                                  tokens.spacing.md,
                                  0,
                                  tokens.spacing.md,
                                  tokens.spacing.md,
                                ),
                                children: <Widget>[
                                  Text(
                                    faq.answer,
                                    style: typography.bodyMedium.copyWith(
                                      color: colors.textSecondary,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 7. References
                    if (ruling.references.isNotEmpty) ...[
                      Text(
                        'প্রামাণ্য তথ্যসূত্র',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ruling.references.map((ref) {
                          return ReferenceChip(
                            citation: '${ref.source} ${ref.number}',
                          );
                        }).toList(),
                      ),
                    ],

                    SizedBox(height: tokens.spacing.xl),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/shared/content/content.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Tab 2: Learn Hub (`শিখুন`) with categorized prayer cards, FTS search,
/// recent searches, rulings, taharat, surah/dua, hadith, faq, and history sections.
class LearnHubScreen extends ConsumerStatefulWidget {
  /// Creates a [LearnHubScreen].
  const LearnHubScreen({super.key});

  @override
  ConsumerState<LearnHubScreen> createState() => _LearnHubScreenState();
}

class _LearnHubScreenState extends ConsumerState<LearnHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _activeTabSection = 'prayers';
  String _searchQuery = '';

  static const List<({String key, String label})> _prayerCategories = [
    (key: 'all', label: 'সবগুলো'),
    (key: 'daily-fard', label: 'দৈনিক ফরজ'),
    (key: 'wajib', label: 'ওয়াজিব'),
    (key: 'jumuah-eid', label: 'জুমআ ও ঈদ'),
    (key: 'janaza', label: 'জানাজা'),
    (key: 'sunnah-nafl', label: 'সুন্নাত ও নফল'),
    (key: 'special', label: 'বিশেষ পরিস্থিতি'),
  ];

  static const List<String> _recentSearches = [
    'জানাজা',
    'সাহু সেজদা',
    'অজু',
    'ফজর',
    'বিতর',
    'আয়াতুল কুরসী',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSelectRecentSearch(String term) {
    unawaited(HapticFeedback.lightImpact());
    _searchController.text = term;
    setState(() => _searchQuery = term);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final prayersAsync = ref.watch(prayersListProvider);
    final rulingsAsync = ref.watch(rulingsListProvider);
    final taharatAsync = ref.watch(taharatListProvider);
    final duasAsync = ref.watch(duasListProvider);
    final allSurahsAsync = ref.watch(allSurahsListProvider);
    final faqsAsync = ref.watch(faqsListProvider);
    final historyAsync = ref.watch(historyErasProvider);

    final searchResultsAsync = _searchQuery.isEmpty
        ? null
        : ref.watch(contentSearchProvider(_searchQuery));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          // Glass Collapsing App Bar
          const GlassSliverAppBar(title: 'শিখুন'),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Global FTS Search Bar
                GlassSearchBar(
                  controller: _searchController,
                  hintText: 'নামাজ, সূরা, দোয়া বা মাসআলা খুঁজুন...',
                  onChanged: (text) => setState(() => _searchQuery = text),
                  onClear: () => setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  }),
                ),

                SizedBox(height: tokens.spacing.xs),

                // Recent Searches Chips
                if (_searchQuery.isEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: _recentSearches.map((term) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ActionChip(
                            label: Text(
                              term,
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                            backgroundColor: colors.surfaceGlassTint.withValues(
                              alpha: 0.5,
                            ),
                            side: BorderSide(
                              color: colors.borderSubtle.withValues(alpha: 0.3),
                            ),
                            onPressed: () => _onSelectRecentSearch(term),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                SizedBox(height: tokens.spacing.sm),

                // Live Search Results View
                if (_searchQuery.isNotEmpty) ...[
                  Text(
                    'অনুসন্ধানের ফলাফল ("$_searchQuery")',
                    style: typography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xs),
                  searchResultsAsync!.when(
                    loading: () => const GlassShimmerLoader(height: 120),
                    error: (err, _) => Text('Error: $err'),
                    data: (results) {
                      if (results.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: EmptyState(
                            title: 'কোনো ফলাফল পাওয়া যায়নি',
                            message: 'অন্য বানানে চেষ্টা করুন।',
                          ),
                        );
                      }

                      return Column(
                        children: results.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GlassCard(
                              onTap: () {
                                if (item.route.startsWith('/namaj/')) {
                                  unawaited(context.push(item.route));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(item.title)),
                                  );
                                }
                              },
                              padding: EdgeInsets.all(tokens.spacing.md),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: colors.primaryEmerald.withValues(
                                        alpha: 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        tokens.radii.sm,
                                      ),
                                    ),
                                    child: Icon(
                                      item.type == 'prayer'
                                          ? Icons.mosque_rounded
                                          : item.type == 'ruling'
                                          ? Icons.gavel_rounded
                                          : item.type == 'dua'
                                          ? Icons.favorite_border_rounded
                                          : Icons.menu_book_rounded,
                                      size: 20,
                                      color: colors.primaryEmerald,
                                    ),
                                  ),
                                  SizedBox(width: tokens.spacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.title,
                                          style: typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        Text(
                                          item.subtitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: typography.bodyMedium.copyWith(
                                            color: colors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: colors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],

                // Main Hub Sections (when not searching)
                if (_searchQuery.isEmpty) ...[
                  // Primary Section Filter Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          [
                            ('prayers', 'নামাজ'),
                            ('masail', 'মাসায়েল'),
                            ('taharat', 'তাহারাত'),
                            ('duas', 'সূরা ও দোয়া'),
                            ('quran', 'কুরআন'),
                            ('hadith_faq', 'হাদিস ও প্রশ্নোত্তর'),
                            ('history', 'ইতিহাস'),
                          ].map((item) {
                            final isSelected = _activeTabSection == item.$1;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: GlassChip(
                                label: item.$2,
                                selected: isSelected,
                                onTap: () {
                                  unawaited(HapticFeedback.selectionClick());
                                  setState(() => _activeTabSection = item.$1);
                                },
                              ),
                            );
                          }).toList(),
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  // 1. PRAYERS SECTION
                  if (_activeTabSection == 'prayers') ...[
                    // Sub-filter for prayer groups
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _prayerCategories.map((cat) {
                          final isSelected = _selectedCategory == cat.key;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: FilterChip(
                              label: Text(cat.label),
                              selected: isSelected,
                              onSelected: (_) {
                                unawaited(HapticFeedback.selectionClick());
                                setState(() => _selectedCategory = cat.key);
                              },
                              backgroundColor: colors.surfaceGlassTint,
                              selectedColor: colors.primaryEmerald.withValues(
                                alpha: 0.25,
                              ),
                              checkmarkColor: colors.primaryEmerald,
                              labelStyle: typography.label.copyWith(
                                color: isSelected
                                    ? colors.primaryEmerald
                                    : colors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              side: BorderSide(
                                color: isSelected
                                    ? colors.primaryEmerald
                                    : colors.borderSubtle,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: tokens.spacing.sm),

                    prayersAsync.when(
                      loading: () => const GlassShimmerLoader(height: 200),
                      error: (err, _) => Text('Error loading prayers: $err'),
                      data: (prayers) {
                        final filtered = _selectedCategory == 'all'
                            ? prayers
                            : prayers.where((p) {
                                switch (_selectedCategory) {
                                  case 'daily-fard':
                                    return p.group ==
                                        ContentPrayerGroup.dailyFard;
                                  case 'wajib':
                                    return p.group == ContentPrayerGroup.wajib;
                                  case 'jumuah-eid':
                                    return p.group ==
                                        ContentPrayerGroup.jumuahEid;
                                  case 'janaza':
                                    return p.group == ContentPrayerGroup.janaza;
                                  case 'sunnah-nafl':
                                    return p.group ==
                                        ContentPrayerGroup.sunnahNafl;
                                  case 'special':
                                    return p.group ==
                                        ContentPrayerGroup.special;
                                  default:
                                    return true;
                                }
                              }).toList();

                        return Column(
                          children: filtered.map((p) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Hero(
                                tag: 'prayer-card-${p.slug}',
                                child: GlassCard(
                                  onTap: () => context.push('/namaj/${p.slug}'),
                                  padding: EdgeInsets.all(tokens.spacing.md),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: colors.primaryEmerald
                                              .withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(
                                            tokens.radii.md,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            BengaliNumberFormatter.toBengali(
                                              p.totalRakats,
                                            ),
                                            style: typography.titleMedium
                                                .copyWith(
                                                  color: colors.primaryEmerald,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: tokens.spacing.md),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  p.nameBn,
                                                  style: typography.titleMedium
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            colors.textPrimary,
                                                      ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '(${p.nameEn})',
                                                  style: typography.label
                                                      .copyWith(
                                                        color: colors
                                                            .textSecondary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              p.timeDescriptionBn,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: typography.bodyMedium
                                                  .copyWith(
                                                    color: colors.textSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        p.nameAr,
                                        style: typography.arabicBody.copyWith(
                                          color: colors.primaryEmerald
                                              .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 2. MASAIL (RULINGS) SECTION
                  if (_activeTabSection == 'masail') ...[
                    rulingsAsync.when(
                      loading: () => const GlassShimmerLoader(height: 180),
                      error: (err, _) => Text('Error: $err'),
                      data: (rulings) {
                        return Column(
                          children: rulings.map((r) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          r.titleBn,
                                          style: typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        RulingBadge(
                                          category: r.status.name == 'fard'
                                              ? RulingCategory.fard
                                              : r.status.name == 'wajib'
                                              ? RulingCategory.wajib
                                              : RulingCategory.sunnah,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      r.summaryBn,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    if (r.references.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      ReferenceChip(
                                        citation:
                                            '${r.references.first.source} ${r.references.first.number}',
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 3. TAHARAT SECTION
                  if (_activeTabSection == 'taharat') ...[
                    taharatAsync.when(
                      loading: () => const GlassShimmerLoader(height: 180),
                      error: (err, _) => Text('Error: $err'),
                      data: (sections) {
                        return Column(
                          children: sections.map((t) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          t.titleBn,
                                          style: typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        Text(
                                          t.titleAr,
                                          style: typography.arabicBody.copyWith(
                                            color: colors.primaryEmerald,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      t.summaryBn,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    if (t.farzList != null) ...[
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        children: t.farzList!.map((f) {
                                          return Chip(
                                            label: Text('ফরজ: ${f.title}'),
                                            backgroundColor: colors
                                                .primaryEmerald
                                                .withValues(alpha: 0.1),
                                            labelStyle: typography.label
                                                .copyWith(
                                                  color: colors.primaryEmerald,
                                                ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 4. SURAHS & DUAS SECTION
                  if (_activeTabSection == 'duas') ...[
                    duasAsync.when(
                      loading: () => const GlassShimmerLoader(height: 180),
                      error: (err, _) => Text('Error: $err'),
                      data: (duas) {
                        return Column(
                          children: duas.map((d) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      d.titleBn,
                                      style: typography.titleMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      d.arabic,
                                      style: typography.arabicLarge.copyWith(
                                        color: colors.primaryEmerald,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      d.meaningBn,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 5. QURAN SECTION (114 Surahs)
                  if (_activeTabSection == 'quran') ...[
                    allSurahsAsync.when(
                      loading: () => const GlassShimmerLoader(height: 200),
                      error: (err, _) => Text('Error: $err'),
                      data: (surahs) {
                        return Column(
                          children: surahs.map((q) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors.primaryEmerald.withValues(
                                          alpha: 0.12,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          BengaliNumberFormatter.toBengali(
                                            q.number,
                                          ),
                                          style: typography.bodyMedium.copyWith(
                                            color: colors.primaryEmerald,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: tokens.spacing.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${q.nameBangla} (${q.nameEnglish})',
                                            style: typography.titleMedium
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: colors.textPrimary,
                                                ),
                                          ),
                                          Text(
                                            '${q.revelationType} • ${BengaliNumberFormatter.toBengali(q.totalAyah)} আয়াত',
                                            style: typography.label.copyWith(
                                              color: colors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      q.nameArabic,
                                      style: typography.arabicBody.copyWith(
                                        color: colors.primaryEmerald,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 6. HADITH & FAQ SECTION
                  if (_activeTabSection == 'hadith_faq') ...[
                    faqsAsync.when(
                      loading: () => const GlassShimmerLoader(height: 180),
                      error: (err, _) => Text('Error: $err'),
                      data: (faqs) {
                        return Column(
                          children: faqs.take(15).map((f) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'প্রশ্ন: ${f.questionBn}',
                                      style: typography.titleMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      f.answerBn,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],

                  // 7. HISTORY SECTION
                  if (_activeTabSection == 'history') ...[
                    historyAsync.when(
                      loading: () => const GlassShimmerLoader(height: 180),
                      error: (err, _) => Text('Error: $err'),
                      data: (eras) {
                        return Column(
                          children: eras.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${e.icon ?? "📖"} ${e.nameBn}',
                                          style: typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        Text(
                                          e.period,
                                          style: typography.label.copyWith(
                                            color: colors.goldAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      e.descriptionBn,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ],

                const SizedBox(height: 100), // bottom clearance
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

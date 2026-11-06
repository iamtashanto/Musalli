import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';

/// Hadiths and Islamic FAQ Screen with book filters, grade chips, and search.
class HadithScreen extends ConsumerStatefulWidget {
  const HadithScreen({super.key});

  @override
  ConsumerState<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends ConsumerState<HadithScreen> {
  int _activeSegment = 0; // 0: Hadith, 1: FAQ
  String _searchQuery = '';
  String _selectedBook = 'all';
  String _selectedFaqCategory = 'all';

  final List<(String key, String label)> _hadithBooks = [
    ('all', 'সকল হাদিস'),
    ('বুখারী', 'সহীহ বুখারী'),
    ('মুসলিম', 'সহীহ মুসলিম'),
    ('তিরমিযী', 'জামে তিরমিযী'),
    ('আবু দাউদ', 'সুনানে আবু দাউদ'),
    ('নাসাঈ', 'সুনানে নাসাঈ'),
  ];

  final List<(String key, String label)> _faqCategories = [
    ('all', 'সকল প্রশ্ন'),
    ('basic', 'মৌলিক'),
    ('rules', 'নিয়মকানুন'),
    ('wudu', 'অজু-তাহারাত'),
    ('women', 'নারী বিষয়ক'),
    ('sick', 'অসুস্থ ব্যক্তি'),
    ('traveler', 'মুসাফির'),
  ];

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final hadithsAsync = ref.watch(hadithsListProvider);
    final faqsAsync = ref.watch(faqsListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          const GlassSliverAppBar(title: 'হাদিস ও প্রশ্নোত্তর'),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Tab switcher (Hadith / FAQ)
                GlassSegmentedControl<int>(
                  segments: const {
                    0: 'নামাজের হাদিসসমূহ',
                    1: 'প্রশ্নোত্তর (FAQ)',
                  },
                  selectedValue: _activeSegment,
                  onValueChanged: (val) {
                    unawaited(HapticFeedback.selectionClick());
                    setState(() {
                      _activeSegment = val;
                      _searchQuery = '';
                    });
                  },
                ),

                SizedBox(height: tokens.spacing.md),

                // Search Bar
                GlassSearchBar(
                  hintText: _activeSegment == 0
                      ? 'হাদিসের বিষয় বা কিতাব খুঁজুন...'
                      : 'নামাজের মাসআলা বা প্রশ্ন খুঁজুন...',
                  onChanged: (text) => setState(() => _searchQuery = text),
                  onClear: () => setState(() => _searchQuery = ''),
                ),

                SizedBox(height: tokens.spacing.sm),

                // HADITH TAB
                if (_activeSegment == 0) ...[
                  // Book filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _hadithBooks.map((book) {
                        final isSelected = _selectedBook == book.$1;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: GlassChip(
                            label: book.$2,
                            selected: isSelected,
                            onTap: () {
                              unawaited(HapticFeedback.selectionClick());
                              setState(() => _selectedBook = book.$1);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  hadithsAsync.when(
                    loading: () => const GlassShimmerLoader(height: 200),
                    error: (err, _) => Text('ত্রুটি: $err'),
                    data: (hadiths) {
                      final filtered = hadiths.where((h) {
                        final matchesBook =
                            _selectedBook == 'all' ||
                            h.reference.source.contains(_selectedBook);
                        final matchesSearch =
                            _searchQuery.isEmpty ||
                            h.textBn.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ) ||
                            h.titleBn.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ) ||
                            h.narratorBn.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            );
                        return matchesBook && matchesSearch;
                      }).toList();

                      if (filtered.isEmpty) {
                        return const Center(
                          child: EmptyState(
                            title: 'কোনো হাদিস পাওয়া যায়নি',
                            message: 'অন্য নামে বা কিতাবে অনুসন্ধান করুন।',
                          ),
                        );
                      }

                      return Column(
                        children: filtered.map((h) {
                          final gradeLabel = h.reference.grade?.name == 'sahih'
                              ? 'সহীহ'
                              : h.reference.grade?.name == 'hasan'
                              ? 'হাসান'
                              : 'যঈফ';
                          final gradeColor = h.reference.grade?.name == 'sahih'
                              ? colors.primaryEmerald
                              : colors.goldAccent;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GlassCard(
                              padding: EdgeInsets.all(tokens.spacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Top row: Source and Grade
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${h.reference.source} • ${BengaliNumberFormatter.toBengali(h.reference.number)}',
                                        style: typography.label.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.primaryEmerald,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: gradeColor.withValues(
                                            alpha: 0.15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            tokens.radii.full,
                                          ),
                                          border: Border.all(
                                            color: gradeColor.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          gradeLabel,
                                          style: typography.label.copyWith(
                                            fontSize: 10,
                                            color: gradeColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  if (h.narratorBn.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'বর্ণনাকারী: ${h.narratorBn}',
                                      style: typography.label.copyWith(
                                        color: colors.textSecondary,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],

                                  const SizedBox(height: 6),
                                  Text(
                                    h.textBn,
                                    style: typography.bodyMedium.copyWith(
                                      color: colors.textPrimary,
                                      height: 1.5,
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

                // FAQ TAB
                if (_activeSegment == 1) ...[
                  // Category filters
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _faqCategories.map((cat) {
                        final isSelected = _selectedFaqCategory == cat.$1;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: GlassChip(
                            label: cat.$2,
                            selected: isSelected,
                            onTap: () {
                              unawaited(HapticFeedback.selectionClick());
                              setState(() => _selectedFaqCategory = cat.$1);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: tokens.spacing.md),

                  faqsAsync.when(
                    loading: () => const GlassShimmerLoader(height: 200),
                    error: (err, _) => Text('ত্রুটি: $err'),
                    data: (faqs) {
                      final filtered = faqs.where((f) {
                        final matchesCat =
                            _selectedFaqCategory == 'all' ||
                            f.category == _selectedFaqCategory;
                        final matchesSearch =
                            _searchQuery.isEmpty ||
                            f.questionBn.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            ) ||
                            f.answerBn.toLowerCase().contains(
                              _searchQuery.toLowerCase(),
                            );
                        return matchesCat && matchesSearch;
                      }).toList();

                      if (filtered.isEmpty) {
                        return const Center(
                          child: EmptyState(
                            title: 'কোনো প্রশ্ন পাওয়া যায়নি',
                            message: 'অন্য বিষয়ে অনুসন্ধান করুন।',
                          ),
                        );
                      }

                      return Column(
                        children: filtered.map((f) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: GlassCard(
                              padding: EdgeInsets.zero,
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  title: Text(
                                    f.questionBn,
                                    style: typography.titleMedium.copyWith(
                                      fontWeight: FontWeight.bold,
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
                                      f.answerBn,
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
                        }).toList(),
                      );
                    },
                  ),
                ],

                SizedBox(height: tokens.spacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

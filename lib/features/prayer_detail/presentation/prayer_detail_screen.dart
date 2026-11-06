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
import 'package:musalli/features/simulator/domain/prayer_step_generator.dart';
import 'package:musalli/shared/content/content.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Universal detail screen for any [ContentPrayerType].
class PrayerDetailScreen extends ConsumerStatefulWidget {
  /// Creates a [PrayerDetailScreen].
  const PrayerDetailScreen({required this.slug, super.key});

  /// Prayer slug e.g. "fajr", "dhuhr", "salatut-tasbih".
  final String slug;

  @override
  ConsumerState<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends ConsumerState<PrayerDetailScreen> {
  int _selectedUnitIndex = 0;
  bool _isMale = true;
  bool _isBookmarked = false;
  final Set<int> _expandedRakats = {};

  @override
  void initState() {
    super.initState();
    _expandedRakats.add(1);
    _expandedRakats.add(2);
  }

  void _onToggleGender(bool male) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _isMale = male);
  }

  void _onSelectUnit(int index) {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _selectedUnitIndex = index;
      _expandedRakats.clear();
      _expandedRakats.add(1);
      _expandedRakats.add(2);
    });
  }

  void _onToggleRakatExpansion(int rakat) {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      if (_expandedRakats.contains(rakat)) {
        _expandedRakats.remove(rakat);
      } else {
        _expandedRakats.add(rakat);
      }
    });
  }

  void _onShare(ContentPrayerType prayer) {
    unawaited(HapticFeedback.lightImpact());
    final deepLink = 'musalli://namaj/${prayer.slug}';
    final text =
        '${prayer.nameBn} (${prayer.nameEn}) নামাজের পূর্ণাঙ্গ নিয়ম ও দোয়া:\n$deepLink';

    unawaited(Clipboard.setData(ClipboardData(text: text)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${prayer.nameBn} নামাজের লিঙ্ক কপি করা হয়েছে!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onToggleBookmark() {
    unawaited(HapticFeedback.lightImpact());
    setState(() => _isBookmarked = !_isBookmarked);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'বুকমার্ক যুক্ত হয়েছে' : 'বুকমার্ক সরানো হয়েছে',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final prayerAsync = ref.watch(prayerBySlugProvider(widget.slug));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: prayerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (prayer) {
          if (prayer == null) {
            return Center(
              child: EmptyState(
                title: 'নামাজ খুঁজে পাওয়া যায়নি',
                message: '"${widget.slug}" সম্পর্কিত নামাজের তথ্য পাওয়া যায়নি।',
              ),
            );
          }

          final unitIndex = _selectedUnitIndex.clamp(
            0,
            prayer.rakatUnits.length - 1,
          );
          final activeUnit = prayer.rakatUnits.isNotEmpty
              ? prayer.rakatUnits[unitIndex]
              : null;

          const generator = PrayerStepGenerator();
          final rakatGroups = activeUnit != null
              ? generator.generateRakatGroups(
                  activeUnit.config,
                  isMale: _isMale,
                )
              : <GeneratedRakatGroup>[];

          return Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  // Glass Sliver App Bar
                  GlassSliverAppBar(
                    title: prayer.nameBn,
                    actions: <Widget>[
                      IconButton(
                        tooltip: 'বুকমার্ক',
                        icon: Icon(
                          _isBookmarked
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: _isBookmarked
                              ? colors.goldAccent
                              : colors.textPrimary,
                        ),
                        onPressed: _onToggleBookmark,
                      ),
                      IconButton(
                        tooltip: 'শেয়ার করুন',
                        icon: const Icon(Icons.share_rounded),
                        onPressed: () => _onShare(prayer),
                      ),
                    ],
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacing.md,
                      vertical: tokens.spacing.sm,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // 1. Hero Card: Header & Metadata
                        GlassCard(
                          heroTag: 'prayer-card-${prayer.slug}',
                          borderGlow: true,
                          padding: EdgeInsets.all(tokens.spacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          prayer.nameBn,
                                          style: typography.display.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          '${prayer.nameEn} • মোট ${BengaliNumberFormatter.toBengali(prayer.totalRakats)} রাকাত',
                                          style: typography.bodyMedium.copyWith(
                                            color: colors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    prayer.nameAr,
                                    style: typography.arabicLarge.copyWith(
                                      color: colors.primaryEmerald,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: tokens.spacing.md),
                              Row(
                                children: <Widget>[
                                  RulingBadge(
                                    category:
                                        prayer.category ==
                                            ContentPrayerCategory.fard
                                        ? RulingCategory.fard
                                        : prayer.category ==
                                              ContentPrayerCategory.wajib
                                        ? RulingCategory.wajib
                                        : RulingCategory.sunnah,
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.surfaceGlassTint,
                                      borderRadius: BorderRadius.circular(
                                        tokens.radii.full,
                                      ),
                                      border: Border.all(
                                        color: colors.borderSubtle,
                                      ),
                                    ),
                                    child: Text(
                                      'হানাফি মাযহাব',
                                      style: typography.label.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: tokens.spacing.sm),
                              Text(
                                prayer.timeDescriptionBn,
                                style: typography.bodyMedium.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: tokens.spacing.md),

                        // 2. Gender Toggle Chip
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'নিয়ম দেখুন:',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            GlassSegmentedControl<bool>(
                              segments: const {true: 'পুরুষ', false: 'মহিলা'},
                              selectedValue: _isMale,
                              onValueChanged: _onToggleGender,
                            ),
                          ],
                        ),

                        SizedBox(height: tokens.spacing.md),

                        // 3. "এক নজরে" Rakat Units
                        if (prayer.rakatUnits.isNotEmpty) ...[
                          Text(
                            'এক নজরে রাকাতসমূহ',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: tokens.spacing.xs),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                prayer.rakatUnits.length,
                                (i) {
                                  final unit = prayer.rakatUnits[i];
                                  final isSelected = i == _selectedUnitIndex;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GlassChip(
                                      label: unit.label,
                                      selected: isSelected,
                                      onTap: () => _onSelectUnit(i),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: tokens.spacing.md),
                        ],

                        // 4. Fazilat Section
                        if (prayer.fazilat != null) ...[
                          Callout(
                            title: 'নামাজের ফজিলত',
                            message: prayer.fazilat!.textBn,
                          ),
                          if (prayer.fazilat!.reference != null) ...[
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ReferenceChip(
                                citation:
                                    '${prayer.fazilat!.reference!.source} ${prayer.fazilat!.reference!.number}',
                              ),
                            ),
                          ],
                          SizedBox(height: tokens.spacing.md),
                        ],

                        // 5. Niyyat Section
                        Text(
                          'নিয়্যত',
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: tokens.spacing.xs),
                        Text(
                          'মনে মনে নির্দিষ্ট নামাজের সংকল্প করাই মূল নিয়্যত। মুখে আরবিতে বলা বাধ্যতামূলক নয়, তবে সহায়ক হিসেবে পড়া যায়:',
                          style: typography.bodyMedium.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        SizedBox(height: tokens.spacing.sm),
                        ArabicBlock(
                          data: FourLayerText(
                            id: prayer.niyyat.id,
                            titleBn: prayer.niyyat.titleBn,
                            titleEn: prayer.niyyat.titleEn,
                            arabic: prayer.niyyat.arabic,
                            uccharonBn: prayer.niyyat.uccharonBn,
                            banglish: prayer.niyyat.banglish,
                            meaningBn: prayer.niyyat.meaningBn,
                            meaningEn: prayer.niyyat.meaningEn ?? '',
                            audioAsset: 'assets/audio/allahu-akbar.mp3',
                          ),
                        ),

                        SizedBox(height: tokens.spacing.lg),

                        // 6. Step-by-Step Guide
                        Text(
                          'ধাপে ধাপে নামাজের নিয়ম (${activeUnit?.label ?? prayer.nameBn})',
                          style: typography.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: tokens.spacing.sm),

                        if (rakatGroups.isEmpty)
                          Text(
                            'এই নামাজের ধাপসমূহ প্রস্তুত হচ্ছে...',
                            style: typography.bodyMedium.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),

                        ...rakatGroups.map((group) {
                          final isExpanded = _expandedRakats.contains(
                            group.rakatNumber,
                          );

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
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
                                        group.labelBn,
                                        style: typography.titleMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.primaryEmerald,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            _onToggleRakatExpansion(
                                              group.rakatNumber,
                                            ),
                                        child: Text(
                                          isExpanded
                                              ? 'সংক্ষেপ করুন'
                                              : 'সব দেখুন',
                                          style: typography.label.copyWith(
                                            color: colors.primaryEmerald,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isExpanded) ...[
                                    const SizedBox(height: 8),
                                    ...group.steps.map((step) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colors.primaryEmerald
                                                    .withValues(alpha: 0.15),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check_rounded,
                                                  size: 14,
                                                  color: colors.primaryEmerald,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: tokens.spacing.sm),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    step.postureName,
                                                    style: typography.bodyLarge
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: colors
                                                              .textPrimary,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    step.instructionBn,
                                                    style: typography.bodyMedium
                                                        .copyWith(
                                                          color: colors
                                                              .textSecondary,
                                                        ),
                                                  ),
                                                  if (step.maleRule !=
                                                      null) ...[
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'পুরুষদের নিয়ম: ${step.maleRule}',
                                                      style: typography.label
                                                          .copyWith(
                                                            color: colors
                                                                .goldAccent,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                    ),
                                                  ],
                                                  if (step.femaleRule !=
                                                      null) ...[
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'মহিলাদের নিয়ম: ${step.femaleRule}',
                                                      style: typography.label
                                                          .copyWith(
                                                            color: colors
                                                                .goldAccent,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                    ),
                                                  ],
                                                  if (step.recitationTitle !=
                                                      null) ...[
                                                    const SizedBox(height: 4),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: colors
                                                            .surfaceGlassTint,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              tokens.radii.sm,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        'পড়বেন: ${step.recitationTitle}',
                                                        style: typography.label
                                                            .copyWith(
                                                              color: colors
                                                                  .primaryEmerald,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }),

                        SizedBox(height: tokens.spacing.md),

                        // 7. Common Mistakes
                        if (prayer.commonMistakes.isNotEmpty) ...[
                          Callout(
                            title: 'সাধারণ ভুলসমূহ',
                            message: prayer.commonMistakes.join('\n• '),
                            variant: CalloutVariant.warning,
                          ),
                          SizedBox(height: tokens.spacing.md),
                        ],

                        // 8. FAQs Accordion
                        if (prayer.faqs.isNotEmpty) ...[
                          Text(
                            'প্রশ্নোত্তর (FAQ)',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: tokens.spacing.xs),
                          ...prayer.faqs.map((faq) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: GlassCard(
                                padding: EdgeInsets.all(tokens.spacing.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      faq.question,
                                      style: typography.titleMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      faq.answer,
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: tokens.spacing.md),
                        ],

                        // 9. References
                        if (prayer.references.isNotEmpty) ...[
                          Text(
                            'সহায়ক তথ্যসূত্র',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: tokens.spacing.xs),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: prayer.references.map((ref) {
                              return ReferenceChip(
                                citation: '${ref.source} ${ref.number}',
                              );
                            }).toList(),
                          ),
                        ],

                        const SizedBox(height: 120), // sticky button clearance
                      ]),
                    ),
                  ),
                ],
              ),

              // Sticky Glass Button: "সিমুলেটরে দেখুন"
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: GlassButton(
                  label: 'সিমুলেটরে দেখুন',
                  icon: Icons.play_circle_fill_rounded,
                  isExpanded: true,
                  onPressed: () {
                    unawaited(HapticFeedback.mediumImpact());
                    context.go(
                      '/simulator?prayer=${prayer.slug}&unit=$_selectedUnitIndex',
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

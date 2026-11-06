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
import 'package:musalli/features/taharat/presentation/widgets/taharat_step_illustrations.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Universal detail screen for any Taharat topic (Wudu, Ghusl, Tayammum, etc.).
class TaharatDetailScreen extends ConsumerStatefulWidget {
  const TaharatDetailScreen({required this.slug, super.key});

  final String slug;

  @override
  ConsumerState<TaharatDetailScreen> createState() =>
      _TaharatDetailScreenState();
}

class _TaharatDetailScreenState extends ConsumerState<TaharatDetailScreen> {
  final Set<int> _completedSteps = {};
  bool _isChecklistMode = false;

  void _onToggleStep(int index) {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      if (_completedSteps.contains(index)) {
        _completedSteps.remove(index);
      } else {
        _completedSteps.add(index);
      }
    });
  }

  void _onResetChecklist() {
    unawaited(HapticFeedback.mediumImpact());
    setState(_completedSteps.clear);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final taharatAsync = ref.watch(taharatBySlugProvider(widget.slug));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: taharatAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('ত্রুটি: $err')),
        data: (taharat) {
          if (taharat == null) {
            return Center(
              child: EmptyState(
                title: 'তাহারাত তথ্য পাওয়া যায়নি',
                message: '"${widget.slug}" সম্পর্কিত কোনো তথ্য পাওয়া যায়নি।',
              ),
            );
          }

          final stepsCount = taharat.steps?.length ?? 0;
          final completedCount = _completedSteps.length;
          final progress = stepsCount > 0 ? completedCount / stepsCount : 0.0;

          return CustomScrollView(
            slivers: <Widget>[
              GlassSliverAppBar(
                title: taharat.titleBn,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      _isChecklistMode
                          ? Icons.checklist_rtl_rounded
                          : Icons.format_list_bulleted_rounded,
                      color: _isChecklistMode
                          ? colors.primaryEmerald
                          : colors.textPrimary,
                    ),
                    tooltip: 'চেকলিস্ট মোড',
                    onPressed: () {
                      unawaited(HapticFeedback.selectionClick());
                      setState(() => _isChecklistMode = !_isChecklistMode);
                    },
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
                    // 1. Hero Card
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
                                  taharat.titleBn,
                                  style: typography.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              Text(
                                taharat.titleAr,
                                style: typography.arabicLarge.copyWith(
                                  color: colors.primaryEmerald,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            taharat.titleEn,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          const Divider(height: 24),
                          Text(
                            taharat.summaryBn,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // 2. Checklist Progress Banner (if enabled)
                    if (_isChecklistMode && stepsCount > 0) ...[
                      GlassCard(
                        padding: EdgeInsets.all(tokens.spacing.md),
                        child: Row(
                          children: <Widget>[
                            ProgressRing(
                              progress: progress,
                              size: 48,
                              strokeWidth: 5,
                            ),
                            SizedBox(width: tokens.spacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'অনুশীলন চেকলিস্ট মোড',
                                    style: typography.titleMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    '$completedCountটি সম্পন্ন / মোট $stepsCountটি ধাপ',
                                    style: typography.label.copyWith(
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (completedCount > 0)
                              IconButton(
                                icon: const Icon(Icons.refresh_rounded),
                                tooltip: 'রিসেট করুন',
                                onPressed: _onResetChecklist,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 3. Farz List (ফরজসমূহ)
                    if (taharat.farzList != null &&
                        taharat.farzList!.isNotEmpty) ...[
                      Text(
                        'ফরজসমূহ (${BengaliNumberFormatter.toBengali(taharat.farzList!.length)}টি)',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      ...taharat.farzList!.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: GlassCard(
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: colors.fardContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.priority_high_rounded,
                                    color: colors.fardColor,
                                    size: 16,
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
                                        style: typography.bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item.description,
                                        style: typography.bodyMedium.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 4. Step-by-Step Method with Illustrations & Checklist
                    if (taharat.steps != null && taharat.steps!.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'ধারাবাহিক পদ্ধতি',
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            _isChecklistMode
                                ? 'ট্যাপ করে সম্পন্ন করুন'
                                : 'ধাপসমূহ',
                            style: typography.label.copyWith(
                              color: colors.primaryEmerald,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      ...taharat.steps!.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final step = entry.value;
                        final isDone = _completedSteps.contains(idx);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            onTap: _isChecklistMode
                                ? () => _onToggleStep(idx)
                                : null,
                            borderGlow: isDone,
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Step Vector Illustration
                                TaharatStepIllustration(
                                  stepIndex: idx,
                                  type: widget.slug,
                                  size: 56,
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
                                            'ধাপ ${BengaliNumberFormatter.toBengali(idx + 1)}: ${step.titleBn}',
                                            style: typography.bodyMedium
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: isDone
                                                      ? colors.primaryEmerald
                                                      : colors.textPrimary,
                                                ),
                                          ),
                                          if (step.isFard) ...[
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 1,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: colors.fardContainer,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      tokens.radii.full,
                                                    ),
                                              ),
                                              child: Text(
                                                'ফরজ',
                                                style: typography.label
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color: colors.fardColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        step.descriptionBn,
                                        style: typography.bodyMedium.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_isChecklistMode)
                                  Checkbox(
                                    value: isDone,
                                    activeColor: colors.primaryEmerald,
                                    onChanged: (_) => _onToggleStep(idx),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 5. Sunnah & Mustahab List
                    if (taharat.sunnahList != null &&
                        taharat.sunnahList!.isNotEmpty) ...[
                      Text(
                        'সুন্নাতসমূহ',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      GlassCard(
                        padding: EdgeInsets.all(tokens.spacing.md),
                        child: Column(
                          children: taharat.sunnahList!.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.check_rounded,
                                    size: 16,
                                    color: colors.primaryEmerald,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${item.title}: ${item.description}',
                                      style: typography.bodyMedium.copyWith(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 6. Breakers List (ভঙ্গকারী বিষয়সমূহ)
                    if (taharat.breakersList != null &&
                        taharat.breakersList!.isNotEmpty) ...[
                      Text(
                        'ভঙ্গকারী বিষয়সমূহ',
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      ...taharat.breakersList!.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: GlassCard(
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: colors.warning,
                                  size: 18,
                                ),
                                SizedBox(width: tokens.spacing.sm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.title,
                                        style: typography.bodyMedium.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        item.description,
                                        style: typography.label.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 7. Duas (ArabicBlock)
                    if (widget.slug == 'wudu') ...[
                      Text(
                        "অযুর দু'আসমূহ",
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      const ArabicBlock(
                        data: FourLayerText(
                          id: 'wudu-before',
                          titleBn: "অযুর শুরুর দু'আ",
                          titleEn: 'Dua before Wudu',
                          arabic: 'بِسْمِ اللَّهِ وَالْحَمْدُ لِلَّهِ',
                          uccharonBn: 'বিসমিল্লাহি ওয়াল হামদুলিল্লাহ।',
                          banglish: 'Bismillahi wal hamdulillah.',
                          meaningBn: 'আল্লাহর নামে শুরু করছি এবং সমস্ত প্রশংসা আল্লাহর জন্য।',
                          meaningEn: 'In the name of Allah, and all praise is for Allah.',
                          audioAsset: 'assets/audio/allahu-akbar.mp3',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ArabicBlock(
                        data: FourLayerText(
                          id: 'wudu-after',
                          titleBn: "অযুর শেষের দু'আ",
                          titleEn: 'Dua after Wudu',
                          arabic: 'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
                          uccharonBn: 'আশহাদু আল লা ইলাহা ইল্লাল্লাহু ওয়াহদাহু লা শারীকা লাহু, ওয়া আশহাদু আন্না মুহাম্মাদান আবদুহু ওয়া রাসুলুহু।',
                          banglish: 'Ashhadu al la ilaha illallahu wahdahu la sharika lahu, wa ashhadu anna Muhammadan abduhu wa rasuluhu.',
                          meaningBn: 'আমি সাক্ষ্য দিচ্ছি যে, এক আল্লাহ ছাড়া কোনো সত্য উপাস্য নেই, তাঁর কোনো শরিক নেই; এবং সাক্ষ্য দিচ্ছি যে, মুহাম্মদ (সা.) তাঁর বান্দা ও রাসূল।',
                          meaningEn: 'I bear witness that there is no god but Allah alone with no partner, and Muhammad is His slave and Messenger.',
                          audioAsset: 'assets/audio/allahu-akbar.mp3',
                        ),
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // 8. References
                    if (taharat.references.isNotEmpty) ...[
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
                        children: taharat.references.map((ref) {
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

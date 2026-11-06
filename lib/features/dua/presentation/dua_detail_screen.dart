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
import 'package:musalli/shared/content/content.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Detail screen for an individual Dua with 4-layer recitation, audio repeat,
/// speed control, and bookmarking.
class DuaDetailScreen extends ConsumerStatefulWidget {
  const DuaDetailScreen({required this.duaId, super.key});

  final String duaId;

  @override
  ConsumerState<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends ConsumerState<DuaDetailScreen> {
  bool _isBookmarked = false;
  int _targetRepeats = 1;
  int _completedRepeats = 0;
  double _playbackSpeed = 1.0;

  void _onToggleBookmark() {
    unawaited(HapticFeedback.lightImpact());
    setState(() => _isBookmarked = !_isBookmarked);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked
              ? 'দোয়াটি বুকমার্কে যুক্ত হয়েছে'
              : 'বুকমার্ক সরানো হয়েছে',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onSelectRepeat(int count) {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _targetRepeats = count;
      _completedRepeats = 0;
    });
  }

  void _onSelectSpeed(double speed) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _playbackSpeed = speed);
  }

  void _onCountRepeat() {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      if (_completedRepeats < _targetRepeats) {
        _completedRepeats++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final duasAsync = ref.watch(duasListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: duasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('ত্রুটি: $err')),
        data: (duas) {
          final dua = duas.cast<ContentDua?>().firstWhere(
            (d) => d?.id == widget.duaId,
            orElse: () => null,
          );

          if (dua == null) {
            return Center(
              child: EmptyState(
                title: 'দোয়াটি পাওয়া যায়নি',
                message: '"${widget.duaId}" সম্পর্কিত তথ্য নেই।',
              ),
            );
          }

          final fourLayerData = FourLayerText(
            id: dua.id,
            titleBn: dua.titleBn,
            titleEn: dua.titleEn,
            arabic: dua.arabic,
            uccharonBn: dua.uccharonBn,
            banglish: dua.banglish,
            meaningBn: dua.meaningBn,
            meaningEn: dua.meaningEn ?? '',
            audioAsset: 'assets/audio/allahu-akbar.mp3',
          );

          return CustomScrollView(
            slivers: <Widget>[
              GlassSliverAppBar(
                title: dua.titleBn,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      _isBookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: _isBookmarked
                          ? colors.goldAccent
                          : colors.textPrimary,
                    ),
                    tooltip: 'বুকমার্ক',
                    onPressed: _onToggleBookmark,
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
                    // Title card
                    GlassCard(
                      borderGlow: true,
                      padding: EdgeInsets.all(tokens.spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  dua.titleBn,
                                  style: typography.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.primaryEmerald.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    tokens.radii.full,
                                  ),
                                ),
                                child: Text(
                                  dua.category.name,
                                  style: typography.label.copyWith(
                                    color: colors.primaryEmerald,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (dua.titleEn.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              dua.titleEn,
                              style: typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // Controls card: Repeat count & Speed
                    GlassCard(
                      padding: EdgeInsets.all(tokens.spacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'পুনরাবৃত্তি (Repeat):',
                                style: typography.label.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [1, 3, 7, 33, 100].map((count) {
                                    final isSelected = _targetRepeats == count;
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: ChoiceChip(
                                        visualDensity: VisualDensity.compact,
                                        label: Text(
                                          '${BengaliNumberFormatter.toBengali(count)}x',
                                        ),
                                        selected: isSelected,
                                        selectedColor: colors.primaryEmerald
                                            .withValues(alpha: 0.25),
                                        backgroundColor: colors.surfaceGlassTint,
                                        labelStyle: typography.label.copyWith(
                                          color: isSelected
                                              ? colors.primaryEmerald
                                              : colors.textSecondary,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        onSelected: (_) => _onSelectRepeat(count),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'পড়ার গতি (Speed):',
                                style: typography.label.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [0.75, 1.0, 1.25, 1.5].map((spd) {
                                    final isSelected = _playbackSpeed == spd;
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: ChoiceChip(
                                        visualDensity: VisualDensity.compact,
                                        label: Text('${spd}x'),
                                        selected: isSelected,
                                        selectedColor: colors.primaryEmerald
                                            .withValues(alpha: 0.25),
                                        backgroundColor: colors.surfaceGlassTint,
                                        labelStyle: typography.label.copyWith(
                                          color: isSelected
                                              ? colors.primaryEmerald
                                              : colors.textSecondary,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                        onSelected: (_) => _onSelectSpeed(spd),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // Primary 4-Layer ArabicBlock
                    ArabicBlock(data: fourLayerData),

                    SizedBox(height: tokens.spacing.md),

                    // Interactive Tasbih Tap Counter (if multiple repeats)
                    if (_targetRepeats > 1) ...[
                      GlassCard(
                        onTap: _onCountRepeat,
                        borderGlow: _completedRepeats >= _targetRepeats,
                        padding: EdgeInsets.all(tokens.spacing.md),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ProgressRing(
                              progress: _completedRepeats / _targetRepeats,
                              size: 54,
                              strokeWidth: 5,
                            ),
                            SizedBox(width: tokens.spacing.lg),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'তাসবীহ কাউন্টার (ট্যাপ করুন)',
                                  style: typography.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${BengaliNumberFormatter.toBengali(_completedRepeats)} / ${BengaliNumberFormatter.toBengali(_targetRepeats)} বার সম্পন্ন',
                                  style: typography.titleMedium.copyWith(
                                    color: colors.primaryEmerald,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: tokens.spacing.md),
                    ],

                    // Notes / ফজিলত
                    if (dua.notes != null && dua.notes!.isNotEmpty) ...[
                      Callout(
                        title: "দু'আর ফজিলত ও তাৎপর্য",
                        message: dua.notes!,
                        variant: CalloutVariant.reference,
                      ),
                      SizedBox(height: tokens.spacing.sm),
                    ],

                    // Reference
                    if (dua.reference != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ReferenceChip(
                          citation:
                              '${dua.reference!.source} ${dua.reference!.number}',
                        ),
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

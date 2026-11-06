// Draggable bottom recitation panel with ArabicBlock, synced text highlight,
// Bangla instructions, and circular repeat counter.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

class RecitationPanel extends ConsumerStatefulWidget {
  const RecitationPanel({
    required this.step,
    required this.currentRepeat,
    this.onRepeatTick,
    this.onPlayAudio,
    super.key,
  });

  final SimStep step;
  final int currentRepeat;
  final VoidCallback? onRepeatTick;
  final ValueChanged<String>? onPlayAudio;

  @override
  ConsumerState<RecitationPanel> createState() => _RecitationPanelState();
}

class _RecitationPanelState extends ConsumerState<RecitationPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final step = widget.step;
    final hasRepeat = step.repeat > 1;

    // Load Duas and Surahs to resolve step.recitationIds
    final duasAsync = ref.watch(duasListProvider);
    final surahsAsync = ref.watch(surahsListProvider);

    FourLayerText? resolvedText;

    if (step.recitationIds.isNotEmpty &&
        duasAsync.hasValue &&
        surahsAsync.hasValue) {
      final duas = duasAsync.value ?? [];
      final surahs = surahsAsync.value ?? [];

      for (final id in step.recitationIds) {
        // Look in Duas
        final matchedDua = duas.where((d) => d.id == id).firstOrNull;
        if (matchedDua != null) {
          resolvedText = FourLayerText(
            id: matchedDua.id,
            titleBn: matchedDua.titleBn,
            titleEn: matchedDua.titleEn,
            arabic: matchedDua.arabic,
            uccharonBn: matchedDua.uccharonBn,
            banglish: matchedDua.banglish,
            meaningBn: matchedDua.meaningBn,
            meaningEn: matchedDua.meaningEn ?? '',
            audioAsset: matchedDua.audioSrc ?? 'assets/audio/allahu-akbar.mp3',
          );
          break;
        }

        // Look in Surahs
        final matchedSurah = surahs.where((s) => s.id == id).firstOrNull;
        if (matchedSurah != null) {
          final arabicText = matchedSurah.ayahs.map((a) => a.arabic).join('\n');
          final uccharonText = matchedSurah.ayahs
              .map((a) => a.uccharonBn)
              .join(' ');
          final meaningText = matchedSurah.ayahs
              .map((a) => a.meaningBn)
              .join(' ');

          resolvedText = FourLayerText(
            id: matchedSurah.id,
            titleBn: 'সূরা ${matchedSurah.nameBn} (${matchedSurah.nameAr})',
            titleEn: 'Surah ${matchedSurah.nameEn}',
            arabic: arabicText,
            uccharonBn: uccharonText,
            banglish: matchedSurah.nameEn,
            meaningBn: meaningText,
            meaningEn: '',
            audioAsset: 'assets/audio/surah-${matchedSurah.number}.mp3',
          );
          break;
        }
      }
    }

    return GlassCard(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header: Instruction + Spoken Takbir + Repeat Counter
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Instruction Title & Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        if (step.spokenTakbir != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primaryEmerald.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(
                                tokens.radii.full,
                              ),
                              border: Border.all(
                                color: colors.primaryEmerald.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Text(
                              step.spokenTakbir!,
                              style: typography.label.copyWith(
                                color: colors.primaryEmerald,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            step.titleBn,
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.instructionBn,
                      style: typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Animated Repeat Counter Circle
              if (hasRepeat) ...[
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: widget.onRepeatTick,
                  child: Semantics(
                    button: true,
                    label:
                        'তাসবীহ কাউন্টার: ${BengaliNumbers.toBengali(widget.currentRepeat)} এর মধ্যে ${BengaliNumbers.toBengali(step.repeat)} বার। ট্যাপ করে পুনরাবৃত্তি করুন।',
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: widget.currentRepeat / step.repeat,
                            strokeWidth: 3.5,
                            backgroundColor: colors.primaryEmerald.withValues(
                              alpha: 0.15,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colors.primaryEmerald,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              BengaliNumbers.toBengali(widget.currentRepeat),
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.primaryEmerald,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              '/${BengaliNumbers.toBengali(step.repeat)}',
                              style: typography.label.copyWith(
                                color: colors.textSecondary,
                                fontSize: 9,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Recitation Layer (ArabicBlock) if present
          if (resolvedText != null) ...[
            SizedBox(height: tokens.spacing.sm),
            const Divider(height: 16),
            ArabicBlock(
              data: resolvedText,
              initialShowMeaning: _isExpanded,
              onPlayAudio: () {
                if (resolvedText?.audioAsset != null &&
                    widget.onPlayAudio != null) {
                  widget.onPlayAudio!(resolvedText!.audioAsset!);
                }
              },
            ),
            const SizedBox(height: 4),
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded
                            ? 'সংক্ষেপ করুন'
                            : 'পূর্ণ অর্থ ও অনুবাদ দেখুন',
                        style: typography.label.copyWith(
                          color: colors.primaryEmerald,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: colors.primaryEmerald,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

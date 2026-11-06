// Animated Completion Dialog on finishing a prayer simulation.

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/domain/types.dart';

class CompletionDialog extends StatelessWidget {
  const CompletionDialog({
    required this.timeline,
    required this.duration,
    this.commonMistakes = const [],
    required this.onPracticeQuiz,
    required this.onAnotherPrayer,
    super.key,
  });

  final Timeline timeline;
  final Duration duration;
  final List<String> commonMistakes;
  final VoidCallback onPracticeQuiz;
  final VoidCallback onAnotherPrayer;

  String _formatDuration(Duration d) {
    final mins = d.inMinutes;
    final secs = d.inSeconds % 60;
    if (mins > 0) {
      return '${BengaliNumbers.toBengali(mins)} মিনিট ${BengaliNumbers.toBengali(secs)} সেকেন্ড';
    }
    return '${BengaliNumbers.toBengali(secs)} সেকেন্ড';
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final prayerName = timeline.metadata.prayerSlug ?? 'নামাজ';
    final rakats = timeline.metadata.totalRakats;
    final unitLabel =
        timeline.metadata.unitLabel ??
        (rakats > 0 ? '$rakats রাকাত' : 'জানাযা');

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(tokens.spacing.md),
      child: GlassCard(
        padding: EdgeInsets.all(tokens.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Subtle Glowing Emerald Halo Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    colors.primaryEmerald.withValues(alpha: 0.35),
                    colors.primaryEmerald.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colors.primaryEmerald,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),

            SizedBox(height: tokens.spacing.md),

            Text(
              'মাশাআল্লাহ!',
              style: typography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primaryEmerald,
              ),
            ),
            const SizedBox(height: 4),

            Text(
              'আপনি $prayerName-এর $unitLabel সফলভাবে সম্পন্ন করেছেন।',
              textAlign: TextAlign.center,
              style: typography.bodyMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: tokens.spacing.md),

            // Metrics Summary Box
            Container(
              padding: EdgeInsets.all(tokens.spacing.sm),
              decoration: BoxDecoration(
                color: colors.primaryEmerald.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(tokens.radii.md),
                border: Border.all(
                  color: colors.primaryEmerald.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'মোট সময়',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDuration(duration),
                        style: typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.primaryEmerald,
                        ),
                      ),
                    ],
                  ),
                  Container(width: 1, height: 28, color: colors.borderSubtle),
                  Column(
                    children: [
                      Text(
                        'মোট ধাপ',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${BengaliNumbers.toBengali(timeline.length)}টি ধাপ',
                        style: typography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.primaryEmerald,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Common Mistakes Note if available
            if (commonMistakes.isNotEmpty) ...[
              SizedBox(height: tokens.spacing.md),
              Callout(
                title: 'সতর্কতা ও সাধারণ ভুলসমূহ',
                message: commonMistakes.first,
                variant: CalloutVariant.warning,
              ),
            ],

            SizedBox(height: tokens.spacing.lg),

            // Action Buttons
            GlassButton(
              label: 'অনুশীলন (কুইজ) করুন',
              icon: Icons.quiz_rounded,
              onPressed: () {
                Navigator.of(context).pop();
                onPracticeQuiz();
              },
            ),

            const SizedBox(height: 8),

            GlassButton(
              label: 'অন্য নামাজ শুরু করুন',
              icon: Icons.refresh_rounded,
              variant: GlassButtonVariant.secondary,
              isExpanded: true,
              onPressed: () {
                Navigator.of(context).pop();
                onAnotherPrayer();
              },
            ),
          ],
        ),
      ),
    );
  }
}

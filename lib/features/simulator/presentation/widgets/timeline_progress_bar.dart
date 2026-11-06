// Segmented Timeline Progress Bar with Rakat Markers and Step Checkpoints.

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/domain/types.dart';

class TimelineProgressBar extends StatelessWidget {
  const TimelineProgressBar({
    required this.timeline,
    required this.currentStepIndex,
    this.onSeekStep,
    super.key,
  });

  final Timeline timeline;
  final int currentStepIndex;
  final ValueChanged<int>? onSeekStep;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    if (timeline.isEmpty) return const SizedBox.shrink();

    final totalSteps = timeline.length;
    final progress = (currentStepIndex + 1) / totalSteps;

    // Group steps by rakat to calculate rakat boundary markers
    final totalRakats = timeline.metadata.totalRakats;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Progress track & segmented fill
        ClipRRect(
          borderRadius: BorderRadius.circular(tokens.radii.full),
          child: Container(
            height: 6,
            color: colors.primaryEmerald.withValues(alpha: 0.15),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Animated Fill Bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colors.primaryEmerald, colors.emeraldLight],
                        ),
                        borderRadius: BorderRadius.circular(tokens.radii.full),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Step numbers and rakat indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'ধাপ: ${BengaliNumbers.toBengali(currentStepIndex + 1)} / ${BengaliNumbers.toBengali(totalSteps)}',
              style: typography.label.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (totalRakats > 0)
              Text(
                'মোট ${BengaliNumbers.toBengali(totalRakats)} রাকাত',
                style: typography.label.copyWith(
                  color: colors.primaryEmerald,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// Bottom Sheet displaying all steps in the current simulation for jumping.

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/domain/types.dart';

class StepListSheet extends StatelessWidget {
  const StepListSheet({
    required this.timeline,
    required this.currentStepIndex,
    required this.onSelectStep,
    super.key,
  });

  final Timeline timeline;
  final int currentStepIndex;
  final ValueChanged<int> onSelectStep;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceLowRamFallback,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(tokens.radii.lg),
        ),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Drag Handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'নামাজের ধাপসমূহ (${BengaliNumbers.toBengali(timeline.length)}টি ধাপ)',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: colors.textSecondary,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Steps List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(tokens.spacing.md),
              itemCount: timeline.length,
              itemBuilder: (context, index) {
                final step = timeline[index];
                final isCurrent = index == currentStepIndex;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GlassCard(
                    onTap: () {
                      onSelectStep(index);
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.all(tokens.spacing.sm),
                    child: Row(
                      children: <Widget>[
                        // Step Number or Active Indicator
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? colors.primaryEmerald
                                : colors.primaryEmerald.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              BengaliNumbers.toBengali(index + 1),
                              style: typography.label.copyWith(
                                color: isCurrent
                                    ? Colors.white
                                    : colors.primaryEmerald,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: tokens.spacing.sm),

                        // Title & Instruction
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  if (step.rakat != null) ...[
                                    Text(
                                      '${BengaliNumbers.toBengali(step.rakat)}ম রাকাত • ',
                                      style: typography.label.copyWith(
                                        color: colors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                  Expanded(
                                    child: Text(
                                      step.titleBn,
                                      style: typography.bodyMedium.copyWith(
                                        fontWeight: isCurrent
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        color: isCurrent
                                            ? colors.primaryEmerald
                                            : colors.textPrimary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                step.instructionBn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: typography.label.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (isCurrent)
                          Icon(
                            Icons.play_arrow_rounded,
                            color: colors.primaryEmerald,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

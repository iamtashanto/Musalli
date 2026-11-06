import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/simulator/domain/practice/practice_models.dart';

/// Modal dialog presented when a practice session concludes.
class PracticeResultsDialog extends StatelessWidget {
  const PracticeResultsDialog({
    super.key,
    required this.result,
    required this.onRetry,
    required this.onExit,
  });

  final PracticeResult result;
  final VoidCallback onRetry;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(tokens.spacing.md),
      child: GlassCard(
        padding: EdgeInsets.all(tokens.spacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Text(
                'অনুশীলন সম্পন্ন!',
                style: typography.titleLarge.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: tokens.spacing.xs),
              Text(
                '${result.prayerNameBn} (${result.difficulty.labelBn})',
                style: typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),

              SizedBox(height: tokens.spacing.lg),

              // Radial Score Ring
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: result.totalQuestions > 0
                          ? result.correctCount / result.totalQuestions
                          : 0,
                      strokeWidth: 10,
                      backgroundColor: colors.surfaceGlassTint,
                      color: result.isPassed
                          ? const Color(0xFF10B981)
                          : const Color(0xFFF59E0B),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${BengaliNumbers.toBengali(result.scorePercent)}%',
                        style: typography.display.copyWith(
                          color: result.isPassed
                              ? const Color(0xFF10B981)
                              : const Color(0xFFF59E0B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${BengaliNumbers.toBengali(result.correctCount)}/${BengaliNumbers.toBengali(result.totalQuestions)} সঠিক',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Badge unlock banner if eligible
              if (result.unlockedBadge != null) ...[
                SizedBox(height: tokens.spacing.md),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.md,
                    vertical: tokens.spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: tokens.radii.borderMd,
                    border: Border.all(color: const Color(0xFFF59E0B)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.military_tech,
                        color: Color(0xFFF59E0B),
                        size: 24,
                      ),
                      SizedBox(width: tokens.spacing.xs),
                      Text(
                        'নতুন ব্যাজ আনলক: ${result.unlockedBadge!}',
                        style: typography.label.copyWith(
                          color: const Color(0xFFF59E0B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Weak areas list if mistakes occurred
              if (result.weakAreas.isNotEmpty) ...[
                SizedBox(height: tokens.spacing.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'যে বিষয়গুলো আরও অনুশীলন প্রয়োজন:',
                    style: typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: result.weakAreas.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: tokens.spacing.xs),
                  itemBuilder: (context, index) {
                    final area = result.weakAreas[index];
                    return Container(
                      padding: EdgeInsets.all(tokens.spacing.sm),
                      decoration: BoxDecoration(
                        color: colors.surfaceGlassTint,
                        borderRadius: tokens.radii.borderSm,
                        border: Border.all(color: colors.borderSubtle),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Color(0xFFEF4444),
                              ),
                              SizedBox(width: tokens.spacing.xs),
                              Expanded(
                                child: Text(
                                  area.topicBn,
                                  style: typography.label.copyWith(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: tokens.spacing.xxs),
                          Text(
                            area.adviceBn,
                            style: typography.label.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],

              SizedBox(height: tokens.spacing.lg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onExit,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: tokens.spacing.sm,
                        ),
                        side: BorderSide(color: colors.borderSubtle),
                        shape: RoundedRectangleBorder(
                          borderRadius: tokens.radii.borderMd,
                        ),
                      ),
                      child: Text(
                        'ফিরে যান',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: tokens.spacing.sm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: tokens.spacing.sm,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: tokens.radii.borderMd,
                        ),
                      ),
                      child: Text(
                        'আবার চেষ্টা করুন',
                        style: typography.label.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

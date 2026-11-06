import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';

class ForbiddenTimesCard extends StatelessWidget {
  const ForbiddenTimesCard({required this.schedule, super.key});

  final DailyScheduleTimes schedule;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final forbiddenTimes = [
      (
        titleBn: 'সূর্যোদয় কালীন',
        start: schedule.forbiddenSunrise.start,
        end: schedule.forbiddenSunrise.end,
        reasonBn: 'সূর্য উদিত হওয়ার সময় প্রায় ১৫ মিনিট নামাজ পড়া নিষেধ।',
      ),
      (
        titleBn: 'নিস্তব্ধ দ্বিপ্রহর (ইস্তিওয়া)',
        start: schedule.forbiddenZawal.start,
        end: schedule.forbiddenZawal.end,
        reasonBn:
            'সূর্য মাথার ঠিক উপরে থাকার সময় যোহরের ওয়াক্ত শুরুর আগ পর্যন্ত।',
      ),
      (
        titleBn: 'সূর্যাস্ত কালীন',
        start: schedule.forbiddenSunset.start,
        end: schedule.forbiddenSunset.end,
        reasonBn:
            'সূর্যাস্তের পূর্বের ১৫ মিনিট (দিনের আসর ছাড়া অন্য নামাজ নিষেধ)।',
      ),
    ];

    return GlassCard(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE53935).withValues(alpha: 0.2),
                ),
                child: const Icon(
                  Icons.block_rounded,
                  size: 16,
                  color: Color(0xFFEF5350),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'নামাজের নিষিদ্ধ ৩টি সময় (মাকরূহে তাহরীমী)',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFF8A80),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: tokens.spacing.sm),
          Text(
            'এই তিন সময়ে যেকোনো ফরজ, ওয়াজিব, সুন্নাত বা নফল নামাজ আদায় করা নিষিদ্ধ:',
            style: typography.label.copyWith(color: colors.textSecondary),
          ),
          SizedBox(height: tokens.spacing.sm),
          ...forbiddenTimes.map((item) {
            final startStr = BanglaIslamicDateFormatter.formatBanglaTime(
              item.start,
            );
            final endStr = BanglaIslamicDateFormatter.formatBanglaTime(
              item.end,
            );

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: Color(0xFFEF5350))),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.titleBn,
                          style: typography.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          item.reasonBn,
                          style: typography.label.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$startStr - $endStr',
                    style: typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF8A80),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

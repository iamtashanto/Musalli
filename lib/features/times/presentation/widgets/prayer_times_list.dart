import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';

class PrayerTimesList extends StatelessWidget {
  const PrayerTimesList({
    required this.schedule,
    required this.status,
    super.key,
  });

  final DailyScheduleTimes schedule;
  final CurrentWaqtStatus status;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final waqts = [
      (
        type: WaqtType.fajr,
        titleBn: 'ফজর',
        time: schedule.fajr,
        subtitleBn:
            'সেহরি শেষ: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.sehriEnd)}',
        icon: Icons.wb_twilight_rounded,
      ),
      (
        type: WaqtType.sunrise,
        titleBn: 'সূর্যোদয়',
        time: schedule.sunrise,
        subtitleBn: 'ফজর শেষ ও ইশরাক শুরু',
        icon: Icons.wb_sunny_outlined,
      ),
      (
        type: null,
        titleBn: 'ইশরাক ও চাশত',
        time: schedule.ishraq,
        subtitleBn:
            'চাশত: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.chasht)}',
        icon: Icons.wb_sunny_rounded,
      ),
      (
        type: WaqtType.dhuhr,
        titleBn: 'যোহর',
        time: schedule.dhuhr,
        subtitleBn: 'দ্বিপ্রহর পর সালাতুল জোহর',
        icon: Icons.wb_sunny_rounded,
      ),
      (
        type: WaqtType.asr,
        titleBn: 'আসর (হানাফি)',
        time: schedule.asr,
        subtitleBn: 'দ্বিগুণ ছায়া অনুসারে',
        icon: Icons.wb_twilight_outlined,
      ),
      (
        type: WaqtType.maghrib,
        titleBn: 'মাগরিব',
        time: schedule.maghrib,
        subtitleBn:
            'ইফতার: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.iftar)}',
        icon: Icons.nights_stay_outlined,
      ),
      (
        type: WaqtType.isha,
        titleBn: 'এশা',
        time: schedule.isha,
        subtitleBn: 'রাতের প্রথম প্রহর',
        icon: Icons.nights_stay_rounded,
      ),
      (
        type: null,
        titleBn: 'তাহাজ্জুদ',
        time: schedule.tahajjudStart,
        subtitleBn: 'রাতের শেষ এক-তৃতীয়াংশ',
        icon: Icons.bedtime_rounded,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: waqts.map((item) {
        final isCurrent = item.type != null && item.type == status.currentWaqt;

        return Padding(
          padding: EdgeInsets.only(bottom: tokens.spacing.xs),
          child: _WaqtRowCard(
            titleBn: item.titleBn,
            time: item.time,
            subtitleBn: item.subtitleBn,
            icon: item.icon,
            isCurrent: isCurrent,
          ),
        );
      }).toList(),
    );
  }
}

class _WaqtRowCard extends StatelessWidget {
  const _WaqtRowCard({
    required this.titleBn,
    required this.time,
    required this.subtitleBn,
    required this.icon,
    required this.isCurrent,
  });

  final String titleBn;
  final DateTime time;
  final String subtitleBn;
  final IconData icon;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final timeStr = BanglaIslamicDateFormatter.formatBanglaTime(time);

    return Container(
      decoration: BoxDecoration(
        color: isCurrent
            ? colors.primaryEmerald.withValues(alpha: 0.18)
            : colors.surfaceGlassTint,
        borderRadius: tokens.radii.borderMd,
        border: Border.all(
          color: isCurrent ? colors.primaryEmerald : colors.borderSubtle,
          width: isCurrent ? 1.5 : 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.md,
        vertical: tokens.spacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrent
                  ? colors.primaryEmerald.withValues(alpha: 0.25)
                  : colors.surfaceGlassTint,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isCurrent ? colors.primaryEmerald : colors.textSecondary,
            ),
          ),
          SizedBox(width: tokens.spacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      titleBn,
                      style: typography.bodyLarge.copyWith(
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isCurrent
                            ? colors.textPrimary
                            : colors.textPrimary,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryEmerald,
                          borderRadius: BorderRadius.circular(
                            tokens.radii.full,
                          ),
                        ),
                        child: Text(
                          'চলমান',
                          style: typography.label.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  subtitleBn,
                  style: typography.label.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            timeStr,
            style: typography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: isCurrent ? colors.primaryEmerald : colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

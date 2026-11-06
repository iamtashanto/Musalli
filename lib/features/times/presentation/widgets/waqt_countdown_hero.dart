import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';

/// Flagship Hero Widget for Prayer Times:
/// Displays current waqt, live countdown, location switcher, and dual Hijri/Bangla dates.
class WaqtCountdownHero extends StatelessWidget {
  const WaqtCountdownHero({
    required this.status,
    required this.settings,
    required this.now,
    required this.onChangeLocation,
    super.key,
  });

  final CurrentWaqtStatus status;
  final PrayerTimesSettings settings;
  final DateTime now;
  final VoidCallback onChangeLocation;

  String _formatDurationBn(Duration duration) {
    if (duration.isNegative) return '০০:০০:০০';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final hStr = hours < 10 ? '০$hours' : BengaliNumbers.toBengali(hours);
    final mStr = minutes < 10 ? '০$minutes' : BengaliNumbers.toBengali(minutes);
    final sStr = seconds < 10 ? '০$seconds' : BengaliNumbers.toBengali(seconds);

    return '$hStr:$mStr:$sStr';
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final hijriStr = BanglaIslamicDateFormatter.formatHijriDate(
      now,
      offsetDays: settings.hijriOffsetDays,
    );
    final solarBanglaStr = BanglaIslamicDateFormatter.formatBengaliSolarDate(
      now,
    );
    final gregorianBn = BanglaIslamicDateFormatter.formatGregorianBangla(now);

    return GlassCard(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        children: [
          // Location & Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Location Pill Button
              GestureDetector(
                onTap: onChangeLocation,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.sm,
                    vertical: tokens.spacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceGlassTint,
                    borderRadius: BorderRadius.circular(tokens.radii.full),
                    border: Border.all(color: colors.borderSubtle),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: colors.goldAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        settings.location.nameBn,
                        style: typography.label.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),

              // Gregorian Date
              Text(
                gregorianBn,
                style: typography.label.copyWith(color: colors.textSecondary),
              ),
            ],
          ),

          SizedBox(height: tokens.spacing.sm),

          // Hijri & Bangla Solar Date Subheader
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              Text(
                hijriStr,
                style: typography.label.copyWith(
                  color: colors.goldAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '•',
                style: typography.label.copyWith(color: colors.textMuted),
              ),
              Text(
                solarBanglaStr,
                style: typography.label.copyWith(color: colors.textSecondary),
              ),
            ],
          ),

          SizedBox(height: tokens.spacing.md),

          // Current Waqt Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.xxs,
            ),
            decoration: BoxDecoration(
              color: status.isForbiddenTime
                  ? const Color(0xFFE53935).withValues(alpha: 0.2)
                  : colors.primaryEmerald.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(tokens.radii.full),
              border: Border.all(
                color: status.isForbiddenTime
                    ? const Color(0xFFEF5350)
                    : colors.primaryEmerald,
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status.isForbiddenTime
                      ? Icons.warning_amber_rounded
                      : Icons.access_time_rounded,
                  size: 14,
                  color: status.isForbiddenTime
                      ? const Color(0xFFFF8A80)
                      : colors.primaryEmerald,
                ),
                const SizedBox(width: 6),
                Text(
                  'চলমান: ${status.currentWaqtNameBn}',
                  style: typography.label.copyWith(
                    color: status.isForbiddenTime
                        ? const Color(0xFFFF8A80)
                        : colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.md),

          // Next Prayer Countdown
          Text(
            '${status.nextWaqtNameBn} বাকি',
            style: typography.bodyMedium.copyWith(color: colors.textSecondary),
          ),

          const SizedBox(height: 4),

          // Animated Digits
          Text(
            _formatDurationBn(status.timeRemaining),
            style: typography.display.copyWith(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: colors.textPrimary,
            ),
          ),

          // Forbidden Time Alert if applicable
          if (status.isForbiddenTime && status.forbiddenReasonBn != null) ...[
            SizedBox(height: tokens.spacing.sm),
            Container(
              padding: EdgeInsets.all(tokens.spacing.xs),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C).withValues(alpha: 0.25),
                borderRadius: tokens.radii.borderMd,
                border: Border.all(color: const Color(0xFFE53935)),
              ),
              child: Text(
                status.forbiddenReasonBn!,
                textAlign: TextAlign.center,
                style: typography.label.copyWith(
                  color: const Color(0xFFFFCDD2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

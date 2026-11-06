import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';

class RamadanViewSheet extends StatelessWidget {
  const RamadanViewSheet({required this.settings, super.key});

  final PrayerTimesSettings settings;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final now = DateTime.now();
    final todaySchedule = PrayerTimesCalculator.calculateDailySchedule(
      now,
      settings,
    );

    final isBeforeIftar = now.isBefore(todaySchedule.iftar);
    final nextTarget = isBeforeIftar
        ? todaySchedule.iftar
        : todaySchedule.sehriEnd.add(const Duration(days: 1));
    final diff = nextTarget.difference(now);

    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);
    final countdownStr =
        '${BengaliNumbers.toBengali(hours)} ঘণ্টা ${BengaliNumbers.toBengali(minutes)} মিনিট ${BengaliNumbers.toBengali(seconds)} সেকেন্ড';

    final daysList = List.generate(30, (i) {
      final date = now.add(Duration(days: i));
      return (
        dayIndex: i + 1,
        schedule: PrayerTimesCalculator.calculateDailySchedule(date, settings),
      );
    });

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: EdgeInsets.all(tokens.spacing.md),
      decoration: BoxDecoration(
        color: colors.backgroundMiddle,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.nightlight_round, color: colors.goldAccent),
                  const SizedBox(width: 8),
                  Text(
                    'মাহে রমজান সময়সূচি',
                    style: typography.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          SizedBox(height: tokens.spacing.sm),

          // Live Countdown Banner
          GlassCard(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Column(
              children: [
                Text(
                  isBeforeIftar ? 'আজকের ইফতার বাকি' : 'আগামীকালের সেহরি বাকি',
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  countdownStr,
                  style: typography.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.goldAccent,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'সেহরি শেষ: ${BanglaIslamicDateFormatter.formatBanglaTime(todaySchedule.sehriEnd)}',
                      style: typography.label.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      'ইফতার: ${BanglaIslamicDateFormatter.formatBanglaTime(todaySchedule.iftar)}',
                      style: typography.label.copyWith(
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

          // 30 Days List Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: colors.primaryEmerald.withValues(alpha: 0.15),
              borderRadius: tokens.radii.borderMd,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'রোজা',
                    style: typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primaryEmerald,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'তারিখ',
                    style: typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primaryEmerald,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'সেহরি শেষ',
                    textAlign: TextAlign.center,
                    style: typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primaryEmerald,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'ইফতার',
                    textAlign: TextAlign.center,
                    style: typography.label.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primaryEmerald,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.xs),

          // 30 Days List
          Expanded(
            child: ListView.separated(
              itemCount: daysList.length,
              separatorBuilder: (_, _) =>
                  Divider(color: colors.borderSubtle, height: 1),
              itemBuilder: (context, index) {
                final item = daysList[index];
                final isToday = index == 0;

                return Container(
                  color: isToday
                      ? colors.primaryEmerald.withValues(alpha: 0.15)
                      : null,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${BengaliNumbers.toBengali(item.dayIndex)} রমজান',
                          style: typography.label.copyWith(
                            fontWeight: isToday
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isToday
                                ? colors.primaryEmerald
                                : colors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${BengaliNumbers.toBengali(item.schedule.date.day)}/${BengaliNumbers.toBengali(item.schedule.date.month)}',
                          style: typography.label.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          BanglaIslamicDateFormatter.formatBanglaTime(
                            item.schedule.sehriEnd,
                          ),
                          textAlign: TextAlign.center,
                          style: typography.label.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          BanglaIslamicDateFormatter.formatBanglaTime(
                            item.schedule.iftar,
                          ),
                          textAlign: TextAlign.center,
                          style: typography.label.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.primaryEmerald,
                          ),
                        ),
                      ),
                    ],
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

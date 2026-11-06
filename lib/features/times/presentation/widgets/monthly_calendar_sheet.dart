import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';

class MonthlyCalendarSheet extends StatelessWidget {
  const MonthlyCalendarSheet({required this.settings, super.key});

  final PrayerTimesSettings settings;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    final monthSchedule = List.generate(daysInMonth, (index) {
      final date = DateTime(now.year, now.month, index + 1);
      return PrayerTimesCalculator.calculateDailySchedule(date, settings);
    });

    final monthName = BanglaIslamicDateFormatter.formatGregorianBangla(now)
        .split(' ')[2];

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        padding: EdgeInsets.fromLTRB(
          tokens.spacing.md,
          tokens.spacing.md,
          tokens.spacing.md,
          tokens.spacing.lg + 56, // Clearance above floating bottom nav
        ),
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
              Text(
                'মাসিক ক্যালেন্ডার ($monthName)',
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          SizedBox(height: tokens.spacing.sm),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: colors.primaryEmerald.withValues(alpha: 0.15),
              borderRadius: tokens.radii.borderMd,
            ),
            child: const Row(
              children: [
                Expanded(flex: 2, child: _HeaderCell('তারিখ')),
                Expanded(flex: 2, child: _HeaderCell('ফজর')),
                Expanded(flex: 2, child: _HeaderCell('যোহর')),
                Expanded(flex: 2, child: _HeaderCell('আসর')),
                Expanded(flex: 2, child: _HeaderCell('মাগরিব')),
                Expanded(flex: 2, child: _HeaderCell('এশা')),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.xs),

          // Scrollable Table Body
          Expanded(
            child: ListView.separated(
              itemCount: monthSchedule.length,
              separatorBuilder: (_, _) =>
                  Divider(color: colors.borderSubtle, height: 1),
              itemBuilder: (context, index) {
                final day = monthSchedule[index];
                final isToday = day.date.day == now.day;

                String timeOnly(DateTime dt) {
                  final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
                  final m = dt.minute < 10
                      ? '০${dt.minute}'
                      : BengaliNumbers.toBengali(dt.minute);
                  return '${BengaliNumbers.toBengali(h)}:$m';
                }

                return Container(
                  color: isToday
                      ? colors.primaryEmerald.withValues(alpha: 0.15)
                      : null,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${BengaliNumbers.toBengali(day.date.day)} $monthName',
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
                      Expanded(flex: 2, child: _BodyCell(timeOnly(day.fajr))),
                      Expanded(flex: 2, child: _BodyCell(timeOnly(day.dhuhr))),
                      Expanded(flex: 2, child: _BodyCell(timeOnly(day.asr))),
                      Expanded(
                        flex: 2,
                        child: _BodyCell(timeOnly(day.maghrib)),
                      ),
                      Expanded(flex: 2, child: _BodyCell(timeOnly(day.isha))),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: tokens.typography.label.copyWith(
        fontWeight: FontWeight.bold,
        color: tokens.colors.primaryEmerald,
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Text(
      text,
      textAlign: TextAlign.center,
      style: tokens.typography.label.copyWith(color: tokens.colors.textPrimary),
    );
  }
}

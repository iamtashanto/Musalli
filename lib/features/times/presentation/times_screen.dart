import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/bangla_islamic_dates.dart';
import 'package:musalli/features/times/presentation/providers/times_providers.dart';
import 'package:musalli/features/times/presentation/widgets/district_picker_sheet.dart';
import 'package:musalli/features/times/presentation/widgets/forbidden_times_card.dart';
import 'package:musalli/features/times/presentation/widgets/monthly_calendar_sheet.dart';
import 'package:musalli/features/times/presentation/widgets/prayer_times_list.dart';
import 'package:musalli/features/times/presentation/widgets/prayer_times_settings_sheet.dart';
import 'package:musalli/features/times/presentation/widgets/ramadan_view_sheet.dart';
import 'package:musalli/features/times/presentation/widgets/sky_background.dart';
import 'package:musalli/features/times/presentation/widgets/waqt_countdown_hero.dart';

class TimesScreen extends ConsumerStatefulWidget {
  const TimesScreen({super.key});

  @override
  ConsumerState<TimesScreen> createState() => _TimesScreenState();
}

class _TimesScreenState extends ConsumerState<TimesScreen> {
  void _openLocationPicker(LocationItem current) {
    unawaited(HapticFeedback.selectionClick());
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => DistrictPickerSheet(
          currentLocation: current,
          onSelectLocation: (selected) {
            final settingsRepo = ref.read(
              prayerTimesSettingsRepositoryProvider,
            );
            final currentSettings =
                ref.read(prayerTimesSettingsProvider).value ??
                PrayerTimesSettings.bangladeshDefault;
            unawaited(
              settingsRepo.saveSettings(
                currentSettings.copyWith(location: selected),
              ),
            );
            unawaited(settingsRepo.addSavedLocation(selected));
          },
        ),
      ),
    );
  }

  void _openSettings(PrayerTimesSettings current) {
    unawaited(HapticFeedback.selectionClick());
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => PrayerTimesSettingsSheet(
          initialSettings: current,
          onSaveSettings: (updated) {
            final settingsRepo = ref.read(
              prayerTimesSettingsRepositoryProvider,
            );
            unawaited(settingsRepo.saveSettings(updated));
          },
        ),
      ),
    );
  }

  void _openMonthlyCalendar(PrayerTimesSettings settings) {
    unawaited(HapticFeedback.selectionClick());
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => MonthlyCalendarSheet(settings: settings),
      ),
    );
  }

  void _openRamadanView(PrayerTimesSettings settings) {
    unawaited(HapticFeedback.selectionClick());
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => RamadanViewSheet(settings: settings),
      ),
    );
  }

  void _shareTimes(DailyScheduleTimes schedule, LocationItem location) {
    unawaited(HapticFeedback.lightImpact());
    final dateStr = BanglaIslamicDateFormatter.formatGregorianBangla(
      schedule.date,
    );
    final text =
        '''
আজকের নামাজের সময়সূচি (${location.nameBn})
$dateStr
----------------------------------
ফজর: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.fajr)}
সূর্যোদয়: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.sunrise)}
ইশরাক: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.ishraq)}
যোহর: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.dhuhr)}
আসর: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.asr)}
মাগরিব (ইফতার): ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.maghrib)}
এশা: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.isha)}
সেহরি শেষ: ${BanglaIslamicDateFormatter.formatBanglaTime(schedule.sehriEnd)}
----------------------------------
মুসল্লি (Musalli) - https://namajshikkha.tashanto.com
''';

    unawaited(Clipboard.setData(ClipboardData(text: text)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('নামাজের সময়সূচি কপি করা হয়েছে!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final settings =
        ref.watch(prayerTimesSettingsProvider).value ??
        PrayerTimesSettings.bangladeshDefault;
    final schedule = ref.watch(todayScheduleProvider);
    final status = ref.watch(currentWaqtStatusProvider);
    final now = ref.watch(liveClockStreamProvider).value ?? DateTime.now();

    return SkyBackground(
      schedule: schedule,
      now: now,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'নামাজের সময়সূচি',
            style: typography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'কিবলা কম্পাস',
              icon: Icon(Icons.explore_rounded, color: colors.primaryEmerald),
              onPressed: () => Navigator.of(context).pushNamed('/qibla'),
            ),
            IconButton(
              tooltip: 'নোটিফিকেশন ও আজান',
              icon: const Icon(Icons.notifications_active_rounded),
              onPressed: () => Navigator.of(context).pushNamed('/notifications/settings'),
            ),
            IconButton(
              tooltip: 'রমজান ক্যালেন্ডার',
              icon: Icon(Icons.nightlight_round, color: colors.goldAccent),
              onPressed: () => _openRamadanView(settings),
            ),
            IconButton(
              tooltip: 'মাসিক সময়সূচি',
              icon: const Icon(Icons.calendar_month_rounded),
              onPressed: () => _openMonthlyCalendar(settings),
            ),
            IconButton(
              tooltip: 'সেটিংস',
              icon: const Icon(Icons.settings_rounded),
              onPressed: () => _openSettings(settings),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.md,
            vertical: tokens.spacing.sm,
          ),
          children: [
            // 1. Hero Countdown & Waqt Status
            WaqtCountdownHero(
              status: status,
              settings: settings,
              now: now,
              onChangeLocation: () => _openLocationPicker(settings.location),
            ),

            SizedBox(height: tokens.spacing.md),

            // 2. Quick Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: GlassButton(
                    label: 'রমজান সূচি',
                    icon: Icons.nightlight_round,
                    onPressed: () => _openRamadanView(settings),
                  ),
                ),
                SizedBox(width: tokens.spacing.sm),
                Expanded(
                  child: GlassButton(
                    label: 'শেয়ার করুন',
                    icon: Icons.share_rounded,
                    onPressed: () => _shareTimes(schedule, settings.location),
                  ),
                ),
              ],
            ),

            SizedBox(height: tokens.spacing.md),

            // 3. Waqt Times List
            PrayerTimesList(schedule: schedule, status: status),

            SizedBox(height: tokens.spacing.md),

            // 4. Forbidden Times Card
            ForbiddenTimesCard(schedule: schedule),

            SizedBox(height: tokens.spacing.xl),
          ],
        ),
      ),
    );
  }
}

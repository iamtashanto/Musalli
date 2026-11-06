import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/times/data/locations_repository.dart';
import 'package:musalli/features/times/data/prayer_times_settings_repository.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';
import 'package:musalli/features/times/domain/services/prayer_times_calculator.dart';

final locationsRepositoryProvider = Provider<LocationsRepository>((ref) {
  return LocationsRepository();
});

final prayerTimesSettingsRepositoryProvider =
    Provider<PrayerTimesSettingsRepository>((ref) {
      final db = ref.watch(appDatabaseProvider);
      return PrayerTimesSettingsRepository(db);
    });

final prayerTimesSettingsProvider = StreamProvider<PrayerTimesSettings>((ref) {
  final repo = ref.watch(prayerTimesSettingsRepositoryProvider);
  return repo.watchSettings();
});

final allLocationsProvider = FutureProvider<List<LocationItem>>((ref) {
  return ref.watch(locationsRepositoryProvider).getAllLocations();
});

/// Current live clock stream updating every second for countdown and waqt transitions.
final StreamProvider<DateTime> liveClockStreamProvider =
    StreamProvider.autoDispose<DateTime>((ref) {
      final controller = StreamController<DateTime>();
      controller.add(DateTime.now());

      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        controller.add(DateTime.now());
      });

      ref.onDispose(() {
        timer.cancel();
        unawaited(controller.close());
      });

      return controller.stream;
    });

/// Daily prayer times for today.
final todayScheduleProvider = Provider<DailyScheduleTimes>((ref) {
  final settingsAsync = ref.watch(prayerTimesSettingsProvider);
  final settings = settingsAsync.value ?? PrayerTimesSettings.bangladeshDefault;
  final now = ref.watch(liveClockStreamProvider).value ?? DateTime.now();

  return PrayerTimesCalculator.calculateDailySchedule(now, settings);
});

/// Live status of current waqt and countdown.
final currentWaqtStatusProvider = Provider<CurrentWaqtStatus>((ref) {
  final today = ref.watch(todayScheduleProvider);
  final settingsAsync = ref.watch(prayerTimesSettingsProvider);
  final settings = settingsAsync.value ?? PrayerTimesSettings.bangladeshDefault;
  final now = ref.watch(liveClockStreamProvider).value ?? DateTime.now();

  final tomorrowDate = now.add(const Duration(days: 1));
  final tomorrow = PrayerTimesCalculator.calculateDailySchedule(
    tomorrowDate,
    settings,
  );

  return PrayerTimesCalculator.getCurrentWaqtStatus(now, today, tomorrow);
});

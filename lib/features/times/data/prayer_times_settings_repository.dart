import 'dart:convert';

import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';

/// Repository for persisting and observing Prayer Times settings in SQLite.
class PrayerTimesSettingsRepository {
  PrayerTimesSettingsRepository(this._database);

  final AppDatabase _database;
  static const String _kSettingsKey = 'prayer_times_settings_v1';
  static const String _kSavedLocationsKey = 'saved_locations_list_v1';

  /// Reads current settings from database, defaulting to Dhaka / Karachi / Hanafi.
  Future<PrayerTimesSettings> getSettings() async {
    try {
      final jsonStr = await _database.getSetting(_kSettingsKey);
      if (jsonStr == null || jsonStr.isEmpty) {
        return PrayerTimesSettings.bangladeshDefault;
      }
      final map = jsonDecode(jsonStr) as Map<String, dynamic>;
      return PrayerTimesSettings.fromJson(map);
    } catch (_) {
      return PrayerTimesSettings.bangladeshDefault;
    }
  }

  /// Saves updated settings.
  Future<void> saveSettings(PrayerTimesSettings settings) async {
    final jsonStr = jsonEncode(settings.toJson());
    await _database.setSetting(_kSettingsKey, jsonStr);
  }

  /// Observes settings reactively.
  Stream<PrayerTimesSettings> watchSettings() {
    return _database.watchSetting(_kSettingsKey).map((jsonStr) {
      if (jsonStr == null || jsonStr.isEmpty) {
        return PrayerTimesSettings.bangladeshDefault;
      }
      try {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return PrayerTimesSettings.fromJson(map);
      } catch (_) {
        return PrayerTimesSettings.bangladeshDefault;
      }
    });
  }

  /// Reads list of user's saved favorite locations.
  Future<List<LocationItem>> getSavedLocations() async {
    try {
      final jsonStr = await _database.getSetting(_kSavedLocationsKey);
      if (jsonStr == null || jsonStr.isEmpty) {
        return [LocationItem.defaultDhaka];
      }
      final list = jsonDecode(jsonStr) as List<dynamic>;
      return list
          .map((e) => LocationItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [LocationItem.defaultDhaka];
    }
  }

  /// Saves a location to user's saved locations list.
  Future<void> addSavedLocation(LocationItem location) async {
    final current = await getSavedLocations();
    final updated = [
      location,
      ...current.where((loc) => loc.id != location.id),
    ];
    final jsonStr = jsonEncode(updated.map((e) => e.toJson()).toList());
    await _database.setSetting(_kSavedLocationsKey, jsonStr);
  }
}

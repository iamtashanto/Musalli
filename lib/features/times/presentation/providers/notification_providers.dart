import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/core/services/notification_service.dart';

final notificationConfigProvider = StateNotifierProvider<NotificationConfigNotifier, PrayerNotificationConfig>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return NotificationConfigNotifier(db);
});

class NotificationConfigNotifier extends StateNotifier<PrayerNotificationConfig> {
  NotificationConfigNotifier(this._db) : super(PrayerNotificationConfig.defaultSettings) {
    _load();
  }

  final AppDatabase _db;
  static const _key = 'prayer_notifications_config_v1';

  Future<void> _load() async {
    final str = await _db.getSetting(_key);
    if (str != null && str.isNotEmpty) {
      try {
        final map = jsonDecode(str) as Map<String, dynamic>;
        state = PrayerNotificationConfig.fromJson(map);
      } catch (_) {}
    }
  }

  Future<void> updateConfig(PrayerNotificationConfig config) async {
    state = config;
    await _db.setSetting(_key, jsonEncode(config.toJson()));
  }
}

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/tracker/domain/tracker_models.dart';

final trackerRepositoryProvider = Provider<TrackerRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TrackerRepository(db);
});

class TrackerRepository {
  TrackerRepository(this._database);
  final AppDatabase _database;

  static const _qazaKey = 'tracker_qaza_counts_v1';

  String _dateKey(DateTime dt) =>
      '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

  Future<DayPrayerRecord> getDayRecord(DateTime dt) async {
    final key = _dateKey(dt);
    final str = await _database.getSetting('tracker_day_$key');
    if (str == null || str.isEmpty) return DayPrayerRecord.empty(key);
    try {
      final map = jsonDecode(str) as Map<String, dynamic>;
      return DayPrayerRecord.fromJson(key, map);
    } catch (_) {
      return DayPrayerRecord.empty(key);
    }
  }

  Stream<DayPrayerRecord> watchDayRecord(DateTime dt) {
    final key = _dateKey(dt);
    return _database.watchSetting('tracker_day_$key').map((str) {
      if (str == null || str.isEmpty) return DayPrayerRecord.empty(key);
      try {
        final map = jsonDecode(str) as Map<String, dynamic>;
        return DayPrayerRecord.fromJson(key, map);
      } catch (_) {
        return DayPrayerRecord.empty(key);
      }
    });
  }

  Future<void> updatePrayerStatus(DateTime dt, String prayerKey, PrayerStatus status) async {
    final key = _dateKey(dt);
    final current = await getDayRecord(dt);
    final json = current.toJson();
    json[prayerKey] = status.name;
    await _database.setSetting('tracker_day_$key', jsonEncode(json));
  }

  Future<QazaRecord> getQazaRecord() async {
    final str = await _database.getSetting(_qazaKey);
    if (str == null || str.isEmpty) return const QazaRecord();
    try {
      return QazaRecord.fromJson(jsonDecode(str) as Map<String, dynamic>);
    } catch (_) {
      return const QazaRecord();
    }
  }

  Future<void> updateQazaRecord(QazaRecord record) async {
    await _database.setSetting(_qazaKey, jsonEncode(record.toJson()));
  }

  Future<String> exportBackupJson() async {
    final qaza = await getQazaRecord();
    final backup = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'qaza': qaza.toJson(),
    };
    return jsonEncode(backup);
  }

  Future<void> importBackupJson(String jsonStr) async {
    final map = jsonDecode(jsonStr) as Map<String, dynamic>;
    if (map.containsKey('qaza')) {
      await updateQazaRecord(QazaRecord.fromJson(map['qaza'] as Map<String, dynamic>));
    }
  }
}

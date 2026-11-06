import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/hifz/domain/hifz_models.dart';

final hifzRepositoryProvider = Provider<HifzRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return HifzRepository(db);
});

class HifzRepository {
  HifzRepository(this._database);
  final AppDatabase _database;

  static const _kHifzListKey = 'hifz_surahs_list_v1';

  Future<List<HifzItemRecord>> getAllRecords() async {
    final str = await _database.getSetting(_kHifzListKey);
    if (str == null || str.isEmpty) return [];
    try {
      final list = jsonDecode(str) as List<dynamic>;
      return list.map((e) => HifzItemRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveRecord(HifzItemRecord record) async {
    final all = await getAllRecords();
    final index = all.indexWhere((e) => e.surahNumber == record.surahNumber);
    if (index >= 0) {
      all[index] = record;
    } else {
      all.add(record);
    }
    await _database.setSetting(_kHifzListKey, jsonEncode(all.map((e) => e.toJson()).toList()));
  }

  Future<List<int>> getMemorizedSurahNumbers() async {
    final all = await getAllRecords();
    return all.map((e) => e.surahNumber).toList();
  }
}


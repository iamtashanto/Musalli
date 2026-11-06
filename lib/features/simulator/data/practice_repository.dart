import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/simulator/domain/practice/practice_models.dart';

final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PracticeRepository(db);
});

final unlockedBadgesProvider = StreamProvider<List<String>>((ref) {
  final repo = ref.watch(practiceRepositoryProvider);
  return repo.watchUnlockedBadges();
});

/// Repository for persisting practice quiz results and unlocked badges.
class PracticeRepository {
  PracticeRepository(this._database);

  final AppDatabase _database;
  static const String _kBadgesKey = 'practice_unlocked_badges_v1';

  /// Saves quiz result and updates best score / badges.
  Future<void> saveResult(PracticeResult result) async {
    final bestScoreKey = 'practice_best_score_${result.prayerSlug}';
    final existingBest = await getBestScore(result.prayerSlug);

    if (result.scorePercent > existingBest) {
      await _database.setSetting(bestScoreKey, result.scorePercent.toString());
    }

    final badge = result.unlockedBadge;
    if (badge != null) {
      final currentBadges = await getUnlockedBadges();
      if (!currentBadges.contains(badge)) {
        final updated = [...currentBadges, badge];
        await _database.setSetting(_kBadgesKey, jsonEncode(updated));
      }
    }
  }

  /// Gets best score percentage for a prayer.
  Future<int> getBestScore(String prayerSlug) async {
    final str = await _database.getSetting('practice_best_score_$prayerSlug');
    if (str == null) return 0;
    return int.tryParse(str) ?? 0;
  }

  /// Gets list of unlocked badge strings.
  Future<List<String>> getUnlockedBadges() async {
    final str = await _database.getSetting(_kBadgesKey);
    if (str == null || str.isEmpty) return [];
    try {
      final list = jsonDecode(str) as List<dynamic>;
      return list.map((e) => e.toString()).toList();
    } catch (_) {
      return [];
    }
  }

  /// Observes unlocked badges.
  Stream<List<String>> watchUnlockedBadges() {
    return _database.watchSetting(_kBadgesKey).map((str) {
      if (str == null || str.isEmpty) return [];
      try {
        final list = jsonDecode(str) as List<dynamic>;
        return list.map((e) => e.toString()).toList();
      } catch (_) {
        return [];
      }
    });
  }
}

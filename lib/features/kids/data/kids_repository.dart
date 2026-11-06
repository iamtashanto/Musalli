import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/database/app_database.dart';
import 'package:musalli/core/providers/app_providers.dart';
import 'package:musalli/features/kids/domain/kids_models.dart';

final kidsRepositoryProvider = Provider<KidsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return KidsRepository(db);
});

final kidsProgressStreamProvider = StreamProvider<KidsProgress>((ref) {
  final repo = ref.watch(kidsRepositoryProvider);
  return repo.watchProgress();
});

/// Persistence repository for child learning progress and earned stickers.
class KidsRepository {
  KidsRepository(this._database);

  final AppDatabase _database;
  static const String _kProgressKey = 'kids_progress_v1';

  /// Reads current progress from SQLite.
  Future<KidsProgress> getProgress() async {
    final str = await _database.getSetting(_kProgressKey);
    if (str == null || str.isEmpty) return KidsProgress.initial;

    try {
      final map = jsonDecode(str) as Map<String, dynamic>;
      final completed = ((map['completed'] as List<dynamic>?) ?? [])
          .map((e) => e.toString())
          .toSet();
      final starsRaw = (map['stars'] as Map<String, dynamic>?) ?? {};
      final stars = starsRaw.map((k, v) => MapEntry(k, (v as num).toInt()));
      final stickers = ((map['stickers'] as List<dynamic>?) ?? [])
          .map((e) => e.toString())
          .toList();

      return KidsProgress(
        completedLessonIds: completed,
        lessonStars: stars,
        collectedStickers: stickers,
      );
    } catch (_) {
      return KidsProgress.initial;
    }
  }

  /// Observes progress reactively.
  Stream<KidsProgress> watchProgress() {
    return _database.watchSetting(_kProgressKey).map((str) {
      if (str == null || str.isEmpty) return KidsProgress.initial;
      try {
        final map = jsonDecode(str) as Map<String, dynamic>;
        final completed = ((map['completed'] as List<dynamic>?) ?? [])
            .map((e) => e.toString())
            .toSet();
        final starsRaw = (map['stars'] as Map<String, dynamic>?) ?? {};
        final stars = starsRaw.map((k, v) => MapEntry(k, (v as num).toInt()));
        final stickers = ((map['stickers'] as List<dynamic>?) ?? [])
            .map((e) => e.toString())
            .toList();

        return KidsProgress(
          completedLessonIds: completed,
          lessonStars: stars,
          collectedStickers: stickers,
        );
      } catch (_) {
        return KidsProgress.initial;
      }
    });
  }

  /// Marks a lesson as complete and updates star rating + sticker collection.
  Future<void> completeLesson({
    required KidsLessonId lessonId,
    required int stars,
    required String stickerName,
  }) async {
    final current = await getProgress();
    final updatedCompleted = {...current.completedLessonIds, lessonId.key};
    final currentStars = current.lessonStars[lessonId.key] ?? 0;
    final updatedStars = {
      ...current.lessonStars,
      lessonId.key: stars > currentStars ? stars : currentStars,
    };
    final updatedStickers = current.collectedStickers.contains(stickerName)
        ? current.collectedStickers
        : [...current.collectedStickers, stickerName];

    final jsonMap = {
      'completed': updatedCompleted.toList(),
      'stars': updatedStars,
      'stickers': updatedStickers,
    };

    await _database.setSetting(_kProgressKey, jsonEncode(jsonMap));
  }

  /// Resets child's progress (parent gate protected).
  Future<void> resetProgress() async {
    await _database.setSetting(
      _kProgressKey,
      jsonEncode({
        'completed': <String>[],
        'stars': <String, int>{},
        'stickers': <String>[],
      }),
    );
  }
}

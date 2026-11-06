import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/reference.dart';

part 'dua.freezed.dart';
part 'dua.g.dart';

/// Categorized Dua model for prayer, wudu, and daily life.
@freezed
abstract class ContentDua with _$ContentDua {
  const factory ContentDua({
    required String id,
    required String titleBn,
    @Default('') String titleEn,
    required String arabic,
    required String uccharonBn,
    required String banglish,
    required String meaningBn,
    String? meaningEn,
    required ContentDuaCategory category,
    @Default(ContentReviewStatus.verified) ContentReviewStatus reviewStatus,
    String? audioSrc,
    ContentReference? reference,
    String? notes,
  }) = _ContentDua;

  factory ContentDua.fromJson(Map<String, dynamic> json) =>
      _$ContentDuaFromJson(json);
}

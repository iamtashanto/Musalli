import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/reference.dart';

part 'hadith_item.freezed.dart';
part 'hadith_item.g.dart';

String _idFromJson(dynamic value) => value == null ? '' : value.toString();

/// Prophetic Hadith narration on Salah and worship.
@freezed
abstract class ContentHadithItem with _$ContentHadithItem {
  const factory ContentHadithItem({
    @JsonKey(fromJson: _idFromJson) required String id,
    required String titleBn,
    @Default('') String titleEn,
    required String narratorBn,
    String? narratorEn,
    required String textBn,
    String? textEn,
    required ContentReference reference,
    required String category,
    @Default(ContentReviewStatus.verified) ContentReviewStatus reviewStatus,
  }) = _ContentHadithItem;

  factory ContentHadithItem.fromJson(Map<String, dynamic> json) =>
      _$ContentHadithItemFromJson(json);
}


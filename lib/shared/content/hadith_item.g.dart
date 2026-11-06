// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadith_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentHadithItem _$ContentHadithItemFromJson(Map<String, dynamic> json) =>
    _ContentHadithItem(
      id: _idFromJson(json['id']),
      titleBn: json['titleBn'] as String,
      titleEn: json['titleEn'] as String? ?? '',
      narratorBn: json['narratorBn'] as String,
      narratorEn: json['narratorEn'] as String?,
      textBn: json['textBn'] as String,
      textEn: json['textEn'] as String?,
      reference: ContentReference.fromJson(
        json['reference'] as Map<String, dynamic>,
      ),
      category: json['category'] as String,
      reviewStatus:
          $enumDecodeNullable(
            _$ContentReviewStatusEnumMap,
            json['reviewStatus'],
          ) ??
          ContentReviewStatus.verified,
    );

Map<String, dynamic> _$ContentHadithItemToJson(_ContentHadithItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'narratorBn': instance.narratorBn,
      'narratorEn': instance.narratorEn,
      'textBn': instance.textBn,
      'textEn': instance.textEn,
      'reference': instance.reference,
      'category': instance.category,
      'reviewStatus': _$ContentReviewStatusEnumMap[instance.reviewStatus]!,
    };

const _$ContentReviewStatusEnumMap = {
  ContentReviewStatus.verified: 'verified',
  ContentReviewStatus.needsReview: 'needs-review',
};

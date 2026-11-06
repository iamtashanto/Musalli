// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'four_layer_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FourLayerText _$FourLayerTextFromJson(Map<String, dynamic> json) =>
    _FourLayerText(
      id: json['id'] as String,
      titleBn: json['titleBn'] as String,
      titleEn: json['titleEn'] as String,
      arabic: json['arabic'] as String,
      uccharonBn: json['uccharonBn'] as String,
      banglish: json['banglish'] as String,
      meaningBn: json['meaningBn'] as String,
      meaningEn: json['meaningEn'] as String,
      audioAsset: json['audioAsset'] as String?,
      referenceTextBn: json['referenceTextBn'] as String?,
      referenceTextEn: json['referenceTextEn'] as String?,
      grade: $enumDecodeNullable(_$HadithGradeEnumMap, json['grade']),
      reviewStatus:
          $enumDecodeNullable(_$ReviewStatusEnumMap, json['reviewStatus']) ??
          ReviewStatus.verified,
    );

Map<String, dynamic> _$FourLayerTextToJson(_FourLayerText instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'arabic': instance.arabic,
      'uccharonBn': instance.uccharonBn,
      'banglish': instance.banglish,
      'meaningBn': instance.meaningBn,
      'meaningEn': instance.meaningEn,
      'audioAsset': instance.audioAsset,
      'referenceTextBn': instance.referenceTextBn,
      'referenceTextEn': instance.referenceTextEn,
      'grade': _$HadithGradeEnumMap[instance.grade],
      'reviewStatus': _$ReviewStatusEnumMap[instance.reviewStatus]!,
    };

const _$HadithGradeEnumMap = {
  HadithGrade.sahih: 'sahih',
  HadithGrade.hasan: 'hasan',
  HadithGrade.daif: 'daif',
};

const _$ReviewStatusEnumMap = {
  ReviewStatus.verified: 'verified',
  ReviewStatus.needsReview: 'needs-review',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentDua _$ContentDuaFromJson(Map<String, dynamic> json) => _ContentDua(
  id: json['id'] as String,
  titleBn: json['titleBn'] as String,
  titleEn: json['titleEn'] as String? ?? '',
  arabic: json['arabic'] as String,
  uccharonBn: json['uccharonBn'] as String,
  banglish: json['banglish'] as String,
  meaningBn: json['meaningBn'] as String,
  meaningEn: json['meaningEn'] as String?,
  category: $enumDecode(_$ContentDuaCategoryEnumMap, json['category']),
  reviewStatus:
      $enumDecodeNullable(_$ContentReviewStatusEnumMap, json['reviewStatus']) ??
      ContentReviewStatus.verified,
  audioSrc: json['audioSrc'] as String?,
  reference: json['reference'] == null
      ? null
      : ContentReference.fromJson(json['reference'] as Map<String, dynamic>),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$ContentDuaToJson(_ContentDua instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'arabic': instance.arabic,
      'uccharonBn': instance.uccharonBn,
      'banglish': instance.banglish,
      'meaningBn': instance.meaningBn,
      'meaningEn': instance.meaningEn,
      'category': _$ContentDuaCategoryEnumMap[instance.category]!,
      'reviewStatus': _$ContentReviewStatusEnumMap[instance.reviewStatus]!,
      'audioSrc': instance.audioSrc,
      'reference': instance.reference,
      'notes': instance.notes,
    };

const _$ContentDuaCategoryEnumMap = {
  ContentDuaCategory.inSalah: 'in-salah',
  ContentDuaCategory.afterSalah: 'after-salah',
  ContentDuaCategory.wudu: 'wudu',
  ContentDuaCategory.janaza: 'janaza',
  ContentDuaCategory.qunut: 'qunut',
  ContentDuaCategory.istikhara: 'istikhara',
  ContentDuaCategory.daily: 'daily',
  ContentDuaCategory.masjid: 'masjid',
  ContentDuaCategory.sleep: 'sleep',
  ContentDuaCategory.food: 'food',
};

const _$ContentReviewStatusEnumMap = {
  ContentReviewStatus.verified: 'verified',
  ContentReviewStatus.needsReview: 'needs-review',
};

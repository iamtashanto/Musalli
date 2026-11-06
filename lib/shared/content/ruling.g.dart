// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentRuling _$ContentRulingFromJson(Map<String, dynamic> json) =>
    _ContentRuling(
      id: json['id'] as String,
      slug: json['slug'] as String,
      titleBn: json['titleBn'] as String,
      titleEn: json['titleEn'] as String? ?? '',
      summaryBn: json['summaryBn'] as String,
      category: json['category'] as String,
      status: $enumDecode(_$ContentRulingStatusEnumMap, json['status']),
      appliesTo: $enumDecode(_$AppliesToGenderEnumMap, json['appliesTo']),
      bodyBn: json['bodyBn'] as String,
      genderDifferences: json['genderDifferences'] == null
          ? null
          : ContentGenderDifferences.fromJson(
              json['genderDifferences'] as Map<String, dynamic>,
            ),
      faqs: (json['faqs'] as List<dynamic>?)
          ?.map((e) => ContentPrayerFAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
      references:
          (json['references'] as List<dynamic>?)
              ?.map((e) => ContentReference.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ContentReference>[],
      relatedTopics: (json['relatedTopics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relatedPrayers: (json['relatedPrayers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      reviewStatus:
          $enumDecodeNullable(
            _$ContentReviewStatusEnumMap,
            json['reviewStatus'],
          ) ??
          ContentReviewStatus.verified,
    );

Map<String, dynamic> _$ContentRulingToJson(_ContentRuling instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'summaryBn': instance.summaryBn,
      'category': instance.category,
      'status': _$ContentRulingStatusEnumMap[instance.status]!,
      'appliesTo': _$AppliesToGenderEnumMap[instance.appliesTo]!,
      'bodyBn': instance.bodyBn,
      'genderDifferences': instance.genderDifferences,
      'faqs': instance.faqs,
      'references': instance.references,
      'relatedTopics': instance.relatedTopics,
      'relatedPrayers': instance.relatedPrayers,
      'reviewStatus': _$ContentReviewStatusEnumMap[instance.reviewStatus]!,
    };

const _$ContentRulingStatusEnumMap = {
  ContentRulingStatus.fard: 'fard',
  ContentRulingStatus.wajib: 'wajib',
  ContentRulingStatus.sunnah: 'sunnah',
  ContentRulingStatus.nafl: 'nafl',
  ContentRulingStatus.mustahab: 'mustahab',
  ContentRulingStatus.makruh: 'makruh',
  ContentRulingStatus.haram: 'haram',
  ContentRulingStatus.mubah: 'mubah',
};

const _$AppliesToGenderEnumMap = {
  AppliesToGender.male: 'male',
  AppliesToGender.female: 'female',
  AppliesToGender.both: 'both',
};

const _$ContentReviewStatusEnumMap = {
  ContentReviewStatus.verified: 'verified',
  ContentReviewStatus.needsReview: 'needs-review',
};

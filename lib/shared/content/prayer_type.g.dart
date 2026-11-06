// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentGenderDifferences _$ContentGenderDifferencesFromJson(
  Map<String, dynamic> json,
) => _ContentGenderDifferences(
  male:
      (json['male'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  female:
      (json['female'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  note: json['note'] as String?,
);

Map<String, dynamic> _$ContentGenderDifferencesToJson(
  _ContentGenderDifferences instance,
) => <String, dynamic>{
  'male': instance.male,
  'female': instance.female,
  'note': instance.note,
};

_ContentPrayerStepDetail _$ContentPrayerStepDetailFromJson(
  Map<String, dynamic> json,
) => _ContentPrayerStepDetail(
  stepNumber: (json['stepNumber'] as num).toInt(),
  rakatLabel: json['rakatLabel'] as String,
  rakatsApplicable: (json['rakatsApplicable'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  titleBn: json['titleBn'] as String,
  descriptionBn: json['descriptionBn'] as String,
  recitationId: json['recitationId'] as String?,
  recitationCustom: json['recitationCustom'] == null
      ? null
      : ContentRecitation.fromJson(
          json['recitationCustom'] as Map<String, dynamic>,
        ),
  maleRule: json['maleRule'] as String?,
  femaleRule: json['femaleRule'] as String?,
  tips: json['tips'] as String?,
);

Map<String, dynamic> _$ContentPrayerStepDetailToJson(
  _ContentPrayerStepDetail instance,
) => <String, dynamic>{
  'stepNumber': instance.stepNumber,
  'rakatLabel': instance.rakatLabel,
  'rakatsApplicable': instance.rakatsApplicable,
  'titleBn': instance.titleBn,
  'descriptionBn': instance.descriptionBn,
  'recitationId': instance.recitationId,
  'recitationCustom': instance.recitationCustom,
  'maleRule': instance.maleRule,
  'femaleRule': instance.femaleRule,
  'tips': instance.tips,
};

_ContentPrayerFAQ _$ContentPrayerFAQFromJson(Map<String, dynamic> json) =>
    _ContentPrayerFAQ(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$ContentPrayerFAQToJson(_ContentPrayerFAQ instance) =>
    <String, dynamic>{'question': instance.question, 'answer': instance.answer};

_ContentSpecialRule _$ContentSpecialRuleFromJson(Map<String, dynamic> json) =>
    _ContentSpecialRule(
      title: json['title'] as String,
      description: json['description'] as String,
      reference: json['reference'] == null
          ? null
          : ContentReference.fromJson(
              json['reference'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ContentSpecialRuleToJson(_ContentSpecialRule instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'reference': instance.reference,
    };

_ContentPrayerType _$ContentPrayerTypeFromJson(
  Map<String, dynamic> json,
) => _ContentPrayerType(
  slug: json['slug'] as String,
  nameBn: json['nameBn'] as String,
  nameAr: json['nameAr'] as String,
  nameEn: json['nameEn'] as String,
  category: $enumDecode(_$ContentPrayerCategoryEnumMap, json['category']),
  group: $enumDecode(_$ContentPrayerGroupEnumMap, json['group']),
  timeDescriptionBn: json['timeDescriptionBn'] as String,
  rakatUnits:
      (json['rakatUnits'] as List<dynamic>?)
          ?.map((e) => ContentRakatUnit.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentRakatUnit>[],
  totalRakats: (json['totalRakats'] as num).toInt(),
  niyyat: ContentRecitation.fromJson(json['niyyat'] as Map<String, dynamic>),
  fazilat: json['fazilat'] == null
      ? null
      : ContentFazilat.fromJson(json['fazilat'] as Map<String, dynamic>),
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map(
            (e) => ContentPrayerStepDetail.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ContentPrayerStepDetail>[],
  genderDifferences: json['genderDifferences'] == null
      ? null
      : ContentGenderDifferences.fromJson(
          json['genderDifferences'] as Map<String, dynamic>,
        ),
  commonMistakes:
      (json['commonMistakes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  faqs:
      (json['faqs'] as List<dynamic>?)
          ?.map((e) => ContentPrayerFAQ.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentPrayerFAQ>[],
  references:
      (json['references'] as List<dynamic>?)
          ?.map((e) => ContentReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentReference>[],
  relatedPrayers: (json['relatedPrayers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  relatedRulings: (json['relatedRulings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  simulatorConfigId: json['simulatorConfigId'] as String? ?? '',
  specialRules: (json['specialRules'] as List<dynamic>?)
      ?.map((e) => ContentSpecialRule.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviewStatus:
      $enumDecodeNullable(_$ContentReviewStatusEnumMap, json['reviewStatus']) ??
      ContentReviewStatus.verified,
);

Map<String, dynamic> _$ContentPrayerTypeToJson(_ContentPrayerType instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'nameBn': instance.nameBn,
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'category': _$ContentPrayerCategoryEnumMap[instance.category]!,
      'group': _$ContentPrayerGroupEnumMap[instance.group]!,
      'timeDescriptionBn': instance.timeDescriptionBn,
      'rakatUnits': instance.rakatUnits,
      'totalRakats': instance.totalRakats,
      'niyyat': instance.niyyat,
      'fazilat': instance.fazilat,
      'steps': instance.steps,
      'genderDifferences': instance.genderDifferences,
      'commonMistakes': instance.commonMistakes,
      'faqs': instance.faqs,
      'references': instance.references,
      'relatedPrayers': instance.relatedPrayers,
      'relatedRulings': instance.relatedRulings,
      'simulatorConfigId': instance.simulatorConfigId,
      'specialRules': instance.specialRules,
      'reviewStatus': _$ContentReviewStatusEnumMap[instance.reviewStatus],
    };

const _$ContentPrayerCategoryEnumMap = {
  ContentPrayerCategory.fard: 'fard',
  ContentPrayerCategory.wajib: 'wajib',
  ContentPrayerCategory.sunnah: 'sunnah',
  ContentPrayerCategory.sunnahMuakkadah: 'sunnah-muakkadah',
  ContentPrayerCategory.sunnahGhairMuakkadah: 'sunnah-ghair-muakkadah',
  ContentPrayerCategory.nafl: 'nafl',
  ContentPrayerCategory.special: 'special',
};

const _$ContentPrayerGroupEnumMap = {
  ContentPrayerGroup.dailyFard: 'daily-fard',
  ContentPrayerGroup.wajib: 'wajib',
  ContentPrayerGroup.jumuahEid: 'jumuah-eid',
  ContentPrayerGroup.janaza: 'janaza',
  ContentPrayerGroup.sunnahNafl: 'sunnah-nafl',
  ContentPrayerGroup.special: 'special',
};

const _$ContentReviewStatusEnumMap = {
  ContentReviewStatus.verified: 'verified',
  ContentReviewStatus.needsReview: 'needs-review',
};

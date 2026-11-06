// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taharat_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaharatItem _$TaharatItemFromJson(Map<String, dynamic> json) => _TaharatItem(
  title: json['title'] as String,
  description: json['description'] as String,
  reference: json['reference'] == null
      ? null
      : ContentReference.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaharatItemToJson(_TaharatItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'reference': instance.reference,
    };

_TaharatStep _$TaharatStepFromJson(Map<String, dynamic> json) => _TaharatStep(
  stepNumber: (json['stepNumber'] as num).toInt(),
  titleBn: json['titleBn'] as String,
  titleEn: json['titleEn'] as String? ?? '',
  descriptionBn: json['descriptionBn'] as String,
  isFard: json['isFard'] as bool? ?? false,
  isSunnah: json['isSunnah'] as bool? ?? false,
  illustrationKey: json['illustrationKey'] as String,
  recitationId: json['recitationId'] as String?,
  recitationCustom: json['recitationCustom'] == null
      ? null
      : ContentRecitation.fromJson(
          json['recitationCustom'] as Map<String, dynamic>,
        ),
  tipsBn: json['tipsBn'] as String?,
  reference: json['reference'] == null
      ? null
      : ContentReference.fromJson(json['reference'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TaharatStepToJson(_TaharatStep instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'descriptionBn': instance.descriptionBn,
      'isFard': instance.isFard,
      'isSunnah': instance.isSunnah,
      'illustrationKey': instance.illustrationKey,
      'recitationId': instance.recitationId,
      'recitationCustom': instance.recitationCustom,
      'tipsBn': instance.tipsBn,
      'reference': instance.reference,
    };

_TaharatSpecialCase _$TaharatSpecialCaseFromJson(Map<String, dynamic> json) =>
    _TaharatSpecialCase(
      title: json['title'] as String,
      bodyBn: json['bodyBn'] as String,
      reference: json['reference'] == null
          ? null
          : ContentReference.fromJson(
              json['reference'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TaharatSpecialCaseToJson(_TaharatSpecialCase instance) =>
    <String, dynamic>{
      'title': instance.title,
      'bodyBn': instance.bodyBn,
      'reference': instance.reference,
    };

_ContentTaharatSection _$ContentTaharatSectionFromJson(
  Map<String, dynamic> json,
) => _ContentTaharatSection(
  slug: json['slug'] as String,
  titleBn: json['titleBn'] as String,
  titleAr: json['titleAr'] as String,
  titleEn: json['titleEn'] as String,
  summaryBn: json['summaryBn'] as String,
  farzList: (json['farzList'] as List<dynamic>?)
      ?.map((e) => TaharatItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  sunnahList: (json['sunnahList'] as List<dynamic>?)
      ?.map((e) => TaharatItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  mustahabList: (json['mustahabList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  makruhList: (json['makruhList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  breakersList: (json['breakersList'] as List<dynamic>?)
      ?.map((e) => TaharatItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  steps: (json['steps'] as List<dynamic>?)
      ?.map((e) => TaharatStep.fromJson(e as Map<String, dynamic>))
      .toList(),
  specialCases: (json['specialCases'] as List<dynamic>?)
      ?.map((e) => TaharatSpecialCase.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  reviewStatus:
      $enumDecodeNullable(_$ContentReviewStatusEnumMap, json['reviewStatus']) ??
      ContentReviewStatus.verified,
);

Map<String, dynamic> _$ContentTaharatSectionToJson(
  _ContentTaharatSection instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'titleBn': instance.titleBn,
  'titleAr': instance.titleAr,
  'titleEn': instance.titleEn,
  'summaryBn': instance.summaryBn,
  'farzList': instance.farzList,
  'sunnahList': instance.sunnahList,
  'mustahabList': instance.mustahabList,
  'makruhList': instance.makruhList,
  'breakersList': instance.breakersList,
  'steps': instance.steps,
  'specialCases': instance.specialCases,
  'faqs': instance.faqs,
  'references': instance.references,
  'reviewStatus': _$ContentReviewStatusEnumMap[instance.reviewStatus],
};

const _$ContentReviewStatusEnumMap = {
  ContentReviewStatus.verified: 'verified',
  ContentReviewStatus.needsReview: 'needs-review',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shikhun_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentSection _$ContentSectionFromJson(Map<String, dynamic> json) =>
    _ContentSection(
      title: json['title'] as String,
      paragraphs:
          (json['paragraphs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      keyPoints: (json['keyPoints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ContentSectionToJson(_ContentSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'paragraphs': instance.paragraphs,
      'keyPoints': instance.keyPoints,
    };

_ContentShikhunArticle _$ContentShikhunArticleFromJson(
  Map<String, dynamic> json,
) => _ContentShikhunArticle(
  slug: json['slug'] as String,
  titleBn: json['titleBn'] as String,
  titleEn: json['titleEn'] as String? ?? '',
  summaryBn: json['summaryBn'] as String,
  category: json['category'] as String,
  categoryLabelBn: json['categoryLabelBn'] as String,
  readTimeMinutes: (json['readTimeMinutes'] as num?)?.toInt() ?? 5,
  publishedDate: json['publishedDate'] as String? ?? '',
  contentSections:
      (json['contentSections'] as List<dynamic>?)
          ?.map((e) => ContentSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentSection>[],
  faqs:
      (json['faqs'] as List<dynamic>?)
          ?.map((e) => ContentPrayerFAQ.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentPrayerFAQ>[],
  relatedPrayers: (json['relatedPrayers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  relatedMasail: (json['relatedMasail'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ContentShikhunArticleToJson(
  _ContentShikhunArticle instance,
) => <String, dynamic>{
  'slug': instance.slug,
  'titleBn': instance.titleBn,
  'titleEn': instance.titleEn,
  'summaryBn': instance.summaryBn,
  'category': instance.category,
  'categoryLabelBn': instance.categoryLabelBn,
  'readTimeMinutes': instance.readTimeMinutes,
  'publishedDate': instance.publishedDate,
  'contentSections': instance.contentSections,
  'faqs': instance.faqs,
  'relatedPrayers': instance.relatedPrayers,
  'relatedMasail': instance.relatedMasail,
};

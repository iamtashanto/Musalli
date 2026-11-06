// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentHistoryEvent _$ContentHistoryEventFromJson(Map<String, dynamic> json) =>
    _ContentHistoryEvent(
      year: json['year'] as String,
      titleBn: json['title_bn'] as String,
      titleEn: json['title_en'] as String? ?? '',
      descriptionBn: json['description_bn'] as String,
      significanceBn: json['significance_bn'] as String?,
      slug: json['slug'] as String? ?? '',
    );

Map<String, dynamic> _$ContentHistoryEventToJson(
  _ContentHistoryEvent instance,
) => <String, dynamic>{
  'year': instance.year,
  'title_bn': instance.titleBn,
  'title_en': instance.titleEn,
  'description_bn': instance.descriptionBn,
  'significance_bn': instance.significanceBn,
  'slug': instance.slug,
};

_ContentHistoryEra _$ContentHistoryEraFromJson(Map<String, dynamic> json) =>
    _ContentHistoryEra(
      id: json['id'] as String,
      nameBn: json['name_bn'] as String,
      nameEn: json['name_en'] as String? ?? '',
      period: json['period'] as String,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      descriptionBn: json['description_bn'] as String,
      events:
          (json['events'] as List<dynamic>?)
              ?.map(
                (e) => ContentHistoryEvent.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ContentHistoryEvent>[],
    );

Map<String, dynamic> _$ContentHistoryEraToJson(_ContentHistoryEra instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_bn': instance.nameBn,
      'name_en': instance.nameEn,
      'period': instance.period,
      'color': instance.color,
      'icon': instance.icon,
      'description_bn': instance.descriptionBn,
      'events': instance.events,
    };

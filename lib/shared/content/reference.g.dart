// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentReference _$ContentReferenceFromJson(Map<String, dynamic> json) =>
    _ContentReference(
      type: $enumDecode(_$ReferenceTypeEnumMap, json['type']),
      source: json['source'] as String,
      number: _numberFromJson(json['number']),
      grade: $enumDecodeNullable(_$ContentHadithGradeEnumMap, json['grade']),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ContentReferenceToJson(_ContentReference instance) =>
    <String, dynamic>{
      'type': _$ReferenceTypeEnumMap[instance.type]!,
      'source': instance.source,
      'number': instance.number,
      'grade': _$ContentHadithGradeEnumMap[instance.grade],
      'url': instance.url,
    };

const _$ReferenceTypeEnumMap = {
  ReferenceType.quran: 'quran',
  ReferenceType.hadith: 'hadith',
  ReferenceType.fiqh: 'fiqh',
};

const _$ContentHadithGradeEnumMap = {
  ContentHadithGrade.sahih: 'sahih',
  ContentHadithGrade.hasan: 'hasan',
  ContentHadithGrade.daif: 'daif',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentFazilat _$ContentFazilatFromJson(Map<String, dynamic> json) =>
    _ContentFazilat(
      textBn: json['textBn'] as String,
      reference: json['reference'] == null
          ? null
          : ContentReference.fromJson(
              json['reference'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ContentFazilatToJson(_ContentFazilat instance) =>
    <String, dynamic>{
      'textBn': instance.textBn,
      'reference': instance.reference,
    };

_ContentSurah _$ContentSurahFromJson(
  Map<String, dynamic> json,
) => _ContentSurah(
  id: json['id'] as String,
  number: (json['number'] as num).toInt(),
  nameBn: json['nameBn'] as String,
  nameAr: json['nameAr'] as String,
  nameEn: json['nameEn'] as String,
  ayahCount: (json['ayahCount'] as num).toInt(),
  ayahs:
      (json['ayahs'] as List<dynamic>?)
          ?.map((e) => ContentRecitation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ContentRecitation>[],
  audioSrc: json['audioSrc'] as String? ?? '',
  revelation:
      $enumDecodeNullable(_$ContentRevelationTypeEnumMap, json['revelation']) ??
      ContentRevelationType.makki,
  fazilat: json['fazilat'] == null
      ? null
      : ContentFazilat.fromJson(json['fazilat'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContentSurahToJson(_ContentSurah instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'nameBn': instance.nameBn,
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'ayahCount': instance.ayahCount,
      'ayahs': instance.ayahs,
      'audioSrc': instance.audioSrc,
      'revelation': _$ContentRevelationTypeEnumMap[instance.revelation]!,
      'fazilat': instance.fazilat,
    };

const _$ContentRevelationTypeEnumMap = {
  ContentRevelationType.makki: 'makki',
  ContentRevelationType.madani: 'madani',
};

_QuranSurahSummary _$QuranSurahSummaryFromJson(Map<String, dynamic> json) =>
    _QuranSurahSummary(
      number: (json['number'] as num).toInt(),
      nameArabic: json['name_arabic'] as String,
      nameBangla: json['name_bangla'] as String,
      nameEnglish: json['name_english'] as String,
      nameBanglish: json['name_banglish'] as String,
      totalAyah: (json['total_ayah'] as num).toInt(),
      revelationType: json['revelation_type'] as String,
      revelationTypeEn: json['revelation_type_en'] as String,
      audioUrl: json['audio_url'] as String?,
    );

Map<String, dynamic> _$QuranSurahSummaryToJson(_QuranSurahSummary instance) =>
    <String, dynamic>{
      'number': instance.number,
      'name_arabic': instance.nameArabic,
      'name_bangla': instance.nameBangla,
      'name_english': instance.nameEnglish,
      'name_banglish': instance.nameBanglish,
      'total_ayah': instance.totalAyah,
      'revelation_type': instance.revelationType,
      'revelation_type_en': instance.revelationTypeEn,
      'audio_url': instance.audioUrl,
    };

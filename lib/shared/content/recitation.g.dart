// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentRecitation _$ContentRecitationFromJson(Map<String, dynamic> json) =>
    _ContentRecitation(
      id: json['id'] as String,
      titleBn: json['titleBn'] as String,
      titleEn: json['titleEn'] as String? ?? '',
      arabic: json['arabic'] as String,
      uccharonBn: json['uccharonBn'] as String,
      banglish: json['banglish'] as String,
      meaningBn: json['meaningBn'] as String,
      meaningEn: json['meaningEn'] as String?,
      audioSrc: json['audioSrc'] as String?,
      reference: json['reference'] == null
          ? null
          : ContentReference.fromJson(
              json['reference'] as Map<String, dynamic>,
            ),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ContentRecitationToJson(_ContentRecitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleBn': instance.titleBn,
      'titleEn': instance.titleEn,
      'arabic': instance.arabic,
      'uccharonBn': instance.uccharonBn,
      'banglish': instance.banglish,
      'meaningBn': instance.meaningBn,
      'meaningEn': instance.meaningEn,
      'audioSrc': instance.audioSrc,
      'reference': instance.reference,
      'notes': instance.notes,
    };

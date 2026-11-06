// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salah_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QunutConfig _$QunutConfigFromJson(Map<String, dynamic> json) => _QunutConfig(
  enabled: json['enabled'] as bool,
  rakat: (json['rakat'] as num).toInt(),
  position: json['position'] as String? ?? 'before-ruku',
);

Map<String, dynamic> _$QunutConfigToJson(_QunutConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'rakat': instance.rakat,
      'position': instance.position,
    };

_ExtraTakbir _$ExtraTakbirFromJson(Map<String, dynamic> json) => _ExtraTakbir(
  count: (json['count'] as num).toInt(),
  position: json['position'] as String,
  rakat: (json['rakat'] as num).toInt(),
);

Map<String, dynamic> _$ExtraTakbirToJson(_ExtraTakbir instance) =>
    <String, dynamic>{
      'count': instance.count,
      'position': instance.position,
      'rakat': instance.rakat,
    };

_ContentTasbihDistribution _$ContentTasbihDistributionFromJson(
  Map<String, dynamic> json,
) => _ContentTasbihDistribution(
  position: json['position'] as String,
  count: (json['count'] as num).toInt(),
  labelBn: json['labelBn'] as String,
);

Map<String, dynamic> _$ContentTasbihDistributionToJson(
  _ContentTasbihDistribution instance,
) => <String, dynamic>{
  'position': instance.position,
  'count': instance.count,
  'labelBn': instance.labelBn,
};

_ContentSalahConfig _$ContentSalahConfigFromJson(Map<String, dynamic> json) =>
    _ContentSalahConfig(
      rakats: (json['rakats'] as num).toInt(),
      rakatRange: (json['rakatRange'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      qiratRakats:
          (json['qiratRakats'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      firstSittingAfter: (json['firstSittingAfter'] as num?)?.toInt(),
      hasQunut: _qunutFromJson(json['hasQunut']),
      extraTakbirs: (json['extraTakbirs'] as List<dynamic>?)
          ?.map((e) => ExtraTakbir.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasbihDistribution: (json['tasbihDistribution'] as List<dynamic>?)
          ?.map(
            (e) =>
                ContentTasbihDistribution.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      tasbihFormula: json['tasbihFormula'] as String?,
      isJanaza: json['isJanaza'] as bool? ?? false,
      jahr:
          (json['jahr'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      sajdaCount: (json['sajdaCount'] as num?)?.toInt() ?? 2,
      endsWithSalam: json['endsWithSalam'] as bool? ?? true,
    );

Map<String, dynamic> _$ContentSalahConfigToJson(_ContentSalahConfig instance) =>
    <String, dynamic>{
      'rakats': instance.rakats,
      'rakatRange': instance.rakatRange,
      'qiratRakats': instance.qiratRakats,
      'firstSittingAfter': instance.firstSittingAfter,
      'hasQunut': _qunutToJson(instance.hasQunut),
      'extraTakbirs': instance.extraTakbirs,
      'tasbihDistribution': instance.tasbihDistribution,
      'tasbihFormula': instance.tasbihFormula,
      'isJanaza': instance.isJanaza,
      'jahr': instance.jahr,
      'sajdaCount': instance.sajdaCount,
      'endsWithSalam': instance.endsWithSalam,
    };

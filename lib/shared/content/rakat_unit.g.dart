// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rakat_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentRakatUnit _$ContentRakatUnitFromJson(Map<String, dynamic> json) =>
    _ContentRakatUnit(
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
      status: $enumDecode(_$ContentRulingStatusEnumMap, json['status']),
      config: ContentSalahConfig.fromJson(
        json['config'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ContentRakatUnitToJson(_ContentRakatUnit instance) =>
    <String, dynamic>{
      'label': instance.label,
      'count': instance.count,
      'status': _$ContentRulingStatusEnumMap[instance.status]!,
      'config': instance.config,
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

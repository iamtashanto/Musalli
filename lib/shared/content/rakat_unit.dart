import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/salah_config.dart';

part 'rakat_unit.freezed.dart';
part 'rakat_unit.g.dart';

/// Single rakat unit within a prayer (e.g. 2 Rakat Sunnah, 4 Rakat Fard).
@freezed
abstract class ContentRakatUnit with _$ContentRakatUnit {
  const factory ContentRakatUnit({
    required String label,
    required int count,
    required ContentRulingStatus status,
    required ContentSalahConfig config,
  }) = _ContentRakatUnit;

  factory ContentRakatUnit.fromJson(Map<String, dynamic> json) =>
      _$ContentRakatUnitFromJson(json);
}

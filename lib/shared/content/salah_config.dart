import 'package:freezed_annotation/freezed_annotation.dart';

part 'salah_config.freezed.dart';
part 'salah_config.g.dart';

/// Configuration for Qunut recitation (e.g. in Witr prayer).
@freezed
abstract class QunutConfig with _$QunutConfig {
  const factory QunutConfig({
    required bool enabled,
    required int rakat,
    @Default('before-ruku') String position,
  }) = _QunutConfig;

  factory QunutConfig.fromJson(Map<String, dynamic> json) =>
      _$QunutConfigFromJson(json);
}

/// Extra takbirs during prayer (e.g. Eid prayers).
@freezed
abstract class ExtraTakbir with _$ExtraTakbir {
  const factory ExtraTakbir({
    required int count,
    required String position,
    required int rakat,
  }) = _ExtraTakbir;

  factory ExtraTakbir.fromJson(Map<String, dynamic> json) =>
      _$ExtraTakbirFromJson(json);
}

/// Tasbih distribution for Salatut Tasbih.
@freezed
abstract class ContentTasbihDistribution with _$ContentTasbihDistribution {
  const factory ContentTasbihDistribution({
    required String position,
    required int count,
    required String labelBn,
  }) = _ContentTasbihDistribution;

  factory ContentTasbihDistribution.fromJson(Map<String, dynamic> json) =>
      _$ContentTasbihDistributionFromJson(json);
}

QunutConfig? _qunutFromJson(dynamic val) {
  if (val == null || val == false) return null;
  if (val is Map<String, dynamic>) return QunutConfig.fromJson(val);
  if (val == true) {
    return const QunutConfig(enabled: true, rakat: 3, position: 'before-ruku');
  }
  return null;
}

dynamic _qunutToJson(QunutConfig? val) => val?.toJson() ?? false;

/// Pure mathematical and liturgical configuration for a prayer unit.
@freezed
abstract class ContentSalahConfig with _$ContentSalahConfig {
  const factory ContentSalahConfig({
    required int rakats,
    List<int>? rakatRange,
    @Default(<int>[]) List<int> qiratRakats,
    int? firstSittingAfter,
    @JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson)
    QunutConfig? hasQunut,
    List<ExtraTakbir>? extraTakbirs,
    List<ContentTasbihDistribution>? tasbihDistribution,
    String? tasbihFormula,
    @Default(false) bool isJanaza,
    @Default(<int>[]) List<int> jahr,
    @Default(2) int sajdaCount,
    @Default(true) bool endsWithSalam,
  }) = _ContentSalahConfig;

  factory ContentSalahConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentSalahConfigFromJson(json);
}

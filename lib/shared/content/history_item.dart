import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_item.freezed.dart';
part 'history_item.g.dart';

/// Single historical event during an era of Islamic history.
@freezed
abstract class ContentHistoryEvent with _$ContentHistoryEvent {
  const factory ContentHistoryEvent({
    required String year,
    @JsonKey(name: 'title_bn') required String titleBn,
    @JsonKey(name: 'title_en') @Default('') String titleEn,
    @JsonKey(name: 'description_bn') required String descriptionBn,
    @JsonKey(name: 'significance_bn') String? significanceBn,
    @Default('') String slug,
  }) = _ContentHistoryEvent;

  factory ContentHistoryEvent.fromJson(Map<String, dynamic> json) =>
      _$ContentHistoryEventFromJson(json);
}

/// Era in Islamic history (e.g. Prophetic Era, Khulafa-e-Rashideen).
@freezed
abstract class ContentHistoryEra with _$ContentHistoryEra {
  const factory ContentHistoryEra({
    required String id,
    @JsonKey(name: 'name_bn') required String nameBn,
    @JsonKey(name: 'name_en') @Default('') String nameEn,
    required String period,
    String? color,
    String? icon,
    @JsonKey(name: 'description_bn') required String descriptionBn,
    @Default(<ContentHistoryEvent>[]) List<ContentHistoryEvent> events,
  }) = _ContentHistoryEra;

  factory ContentHistoryEra.fromJson(Map<String, dynamic> json) =>
      _$ContentHistoryEraFromJson(json);
}


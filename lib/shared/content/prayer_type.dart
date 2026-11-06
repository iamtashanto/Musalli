import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/rakat_unit.dart';
import 'package:musalli/shared/content/recitation.dart';
import 'package:musalli/shared/content/reference.dart';
import 'package:musalli/shared/content/surah.dart';

part 'prayer_type.freezed.dart';
part 'prayer_type.g.dart';

/// Gender posture difference notes.
@freezed
abstract class ContentGenderDifferences with _$ContentGenderDifferences {
  const factory ContentGenderDifferences({
    @Default(<String>[]) List<String> male,
    @Default(<String>[]) List<String> female,
    String? note,
  }) = _ContentGenderDifferences;

  factory ContentGenderDifferences.fromJson(Map<String, dynamic> json) =>
      _$ContentGenderDifferencesFromJson(json);
}

/// Detailed step for prayer breakdown.
@freezed
abstract class ContentPrayerStepDetail with _$ContentPrayerStepDetail {
  const factory ContentPrayerStepDetail({
    required int stepNumber,
    required String rakatLabel,
    List<int>? rakatsApplicable,
    required String titleBn,
    required String descriptionBn,
    String? recitationId,
    ContentRecitation? recitationCustom,
    String? maleRule,
    String? femaleRule,
    String? tips,
  }) = _ContentPrayerStepDetail;

  factory ContentPrayerStepDetail.fromJson(Map<String, dynamic> json) =>
      _$ContentPrayerStepDetailFromJson(json);
}

/// Prayer specific FAQ.
@freezed
abstract class ContentPrayerFAQ with _$ContentPrayerFAQ {
  const factory ContentPrayerFAQ({
    required String question,
    required String answer,
  }) = _ContentPrayerFAQ;

  factory ContentPrayerFAQ.fromJson(Map<String, dynamic> json) =>
      _$ContentPrayerFAQFromJson(json);
}

/// Special situational rule for a prayer.
@freezed
abstract class ContentSpecialRule with _$ContentSpecialRule {
  const factory ContentSpecialRule({
    required String title,
    required String description,
    ContentReference? reference,
  }) = _ContentSpecialRule;

  factory ContentSpecialRule.fromJson(Map<String, dynamic> json) =>
      _$ContentSpecialRuleFromJson(json);
}

/// Canonical Prayer model covering all 29 Islamic prayers.
@freezed
abstract class ContentPrayerType with _$ContentPrayerType {
  const factory ContentPrayerType({
    required String slug,
    required String nameBn,
    required String nameAr,
    required String nameEn,
    required ContentPrayerCategory category,
    required ContentPrayerGroup group,
    required String timeDescriptionBn,
    @Default(<ContentRakatUnit>[]) List<ContentRakatUnit> rakatUnits,
    required int totalRakats,
    required ContentRecitation niyyat,
    ContentFazilat? fazilat,
    @Default(<ContentPrayerStepDetail>[]) List<ContentPrayerStepDetail> steps,
    ContentGenderDifferences? genderDifferences,
    @Default(<String>[]) List<String> commonMistakes,
    @Default(<ContentPrayerFAQ>[]) List<ContentPrayerFAQ> faqs,
    @Default(<ContentReference>[]) List<ContentReference> references,
    List<String>? relatedPrayers,
    List<String>? relatedRulings,
    @Default('') String simulatorConfigId,
    List<ContentSpecialRule>? specialRules,
    @Default(ContentReviewStatus.verified) ContentReviewStatus? reviewStatus,
  }) = _ContentPrayerType;

  factory ContentPrayerType.fromJson(Map<String, dynamic> json) =>
      _$ContentPrayerTypeFromJson(json);
}

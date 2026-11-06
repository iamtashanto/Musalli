import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/prayer_type.dart';
import 'package:musalli/shared/content/recitation.dart';
import 'package:musalli/shared/content/reference.dart';

part 'taharat_section.freezed.dart';
part 'taharat_section.g.dart';

/// Itemized rule item for Farz, Sunnah, or Breakers in Taharat.
@freezed
abstract class TaharatItem with _$TaharatItem {
  const factory TaharatItem({
    required String title,
    required String description,
    ContentReference? reference,
  }) = _TaharatItem;

  factory TaharatItem.fromJson(Map<String, dynamic> json) =>
      _$TaharatItemFromJson(json);
}

/// Step in Wudu, Ghusl, or Tayammum sequence.
@freezed
abstract class TaharatStep with _$TaharatStep {
  const factory TaharatStep({
    required int stepNumber,
    required String titleBn,
    @Default('') String titleEn,
    required String descriptionBn,
    @Default(false) bool isFard,
    @Default(false) bool isSunnah,
    required String illustrationKey,
    String? recitationId,
    ContentRecitation? recitationCustom,
    String? tipsBn,
    ContentReference? reference,
  }) = _TaharatStep;

  factory TaharatStep.fromJson(Map<String, dynamic> json) =>
      _$TaharatStepFromJson(json);
}

/// Special purification case (e.g. wounds, bandages).
@freezed
abstract class TaharatSpecialCase with _$TaharatSpecialCase {
  const factory TaharatSpecialCase({
    required String title,
    required String bodyBn,
    ContentReference? reference,
  }) = _TaharatSpecialCase;

  factory TaharatSpecialCase.fromJson(Map<String, dynamic> json) =>
      _$TaharatSpecialCaseFromJson(json);
}

/// Complete guide section for Wudu, Ghusl, Tayammum, Najasat, or Masah on Socks.
@freezed
abstract class ContentTaharatSection with _$ContentTaharatSection {
  const factory ContentTaharatSection({
    required String slug,
    required String titleBn,
    required String titleAr,
    required String titleEn,
    required String summaryBn,
    List<TaharatItem>? farzList,
    List<TaharatItem>? sunnahList,
    List<String>? mustahabList,
    List<String>? makruhList,
    List<TaharatItem>? breakersList,
    List<TaharatStep>? steps,
    List<TaharatSpecialCase>? specialCases,
    @Default(<ContentPrayerFAQ>[]) List<ContentPrayerFAQ> faqs,
    @Default(<ContentReference>[]) List<ContentReference> references,
    @Default(ContentReviewStatus.verified) ContentReviewStatus? reviewStatus,
  }) = _ContentTaharatSection;

  factory ContentTaharatSection.fromJson(Map<String, dynamic> json) =>
      _$ContentTaharatSectionFromJson(json);
}

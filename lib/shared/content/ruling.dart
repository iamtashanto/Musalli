import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/prayer_type.dart';
import 'package:musalli/shared/content/reference.dart';

part 'ruling.freezed.dart';
part 'ruling.g.dart';

/// Islamic Fiqh ruling on prayers, mistakes, and purification.
@freezed
abstract class ContentRuling with _$ContentRuling {
  const factory ContentRuling({
    required String id,
    required String slug,
    required String titleBn,
    @Default('') String titleEn,
    required String summaryBn,
    required String category,
    required ContentRulingStatus status,
    required AppliesToGender appliesTo,
    required String bodyBn,
    ContentGenderDifferences? genderDifferences,
    List<ContentPrayerFAQ>? faqs,
    @Default(<ContentReference>[]) List<ContentReference> references,
    List<String>? relatedTopics,
    List<String>? relatedPrayers,
    @Default(ContentReviewStatus.verified) ContentReviewStatus reviewStatus,
  }) = _ContentRuling;

  factory ContentRuling.fromJson(Map<String, dynamic> json) =>
      _$ContentRulingFromJson(json);
}


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/prayer_type.dart';

part 'shikhun_article.freezed.dart';
part 'shikhun_article.g.dart';

/// Section within an educational Salah article.
@freezed
abstract class ContentSection with _$ContentSection {
  const factory ContentSection({
    required String title,
    @Default(<String>[]) List<String> paragraphs,
    List<String>? keyPoints,
  }) = _ContentSection;

  factory ContentSection.fromJson(Map<String, dynamic> json) =>
      _$ContentSectionFromJson(json);
}

/// Educational article from the Shikhun hub.
@freezed
abstract class ContentShikhunArticle with _$ContentShikhunArticle {
  const factory ContentShikhunArticle({
    required String slug,
    required String titleBn,
    @Default('') String titleEn,
    required String summaryBn,
    required String category,
    required String categoryLabelBn,
    @Default(5) int readTimeMinutes,
    @Default('') String publishedDate,
    @Default(<ContentSection>[]) List<ContentSection> contentSections,
    @Default(<ContentPrayerFAQ>[]) List<ContentPrayerFAQ> faqs,
    List<String>? relatedPrayers,
    List<String>? relatedMasail,
  }) = _ContentShikhunArticle;

  factory ContentShikhunArticle.fromJson(Map<String, dynamic> json) =>
      _$ContentShikhunArticleFromJson(json);
}

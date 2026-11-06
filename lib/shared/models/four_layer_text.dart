import 'package:freezed_annotation/freezed_annotation.dart';

part 'four_layer_text.freezed.dart';
part 'four_layer_text.g.dart';

/// Ruling categories for prayers and actions in Hanafi fiqh.
enum RulingCategory {
  /// Obligatory by decisive proof (ফরজ).
  fard,

  /// Necessary by strong proof in Hanafi fiqh (ওয়াজিব).
  wajib,

  /// Emphasized or regular Sunnah (সুন্নাত).
  sunnah,

  /// Voluntary / supererogatory (নফল).
  nafl,

  /// Special situational prayer or ruling (বিশেষ).
  special,
}

/// Editorial verification status for religious content items.
enum ReviewStatus {
  /// Verified against primary sources.
  @JsonValue('verified')
  verified,

  /// Flagged for qualified scholar / Mufti review.
  @JsonValue('needs-review')
  needsReview,
}

/// Hadith authenticity grading.
enum HadithGrade {
  /// Authentic (সহীহ).
  sahih,

  /// Sound / good (হাসান).
  hasan,

  /// Weak chain (যঈফ).
  daif,
}

/// Canonical 4-layer representation of every Quranic verse, dua, or recitation
/// in Musalli.
@freezed
abstract class FourLayerText with _$FourLayerText {
  /// Creates an immutable [FourLayerText].
  const factory FourLayerText({
    required String id,
    required String titleBn,
    required String titleEn,
    required String arabic,
    required String uccharonBn,
    required String banglish,
    required String meaningBn,
    required String meaningEn,
    String? audioAsset,
    String? referenceTextBn,
    String? referenceTextEn,
    HadithGrade? grade,
    @Default(ReviewStatus.verified) ReviewStatus reviewStatus,
  }) = _FourLayerText;

  /// Deserializes a [FourLayerText] from JSON.
  factory FourLayerText.fromJson(Map<String, dynamic> json) =>
      _$FourLayerTextFromJson(json);
}


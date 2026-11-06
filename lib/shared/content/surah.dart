import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';
import 'package:musalli/shared/content/recitation.dart';
import 'package:musalli/shared/content/reference.dart';

part 'surah.freezed.dart';
part 'surah.g.dart';

/// Fazilat note with reference citation.
@freezed
abstract class ContentFazilat with _$ContentFazilat {
  const factory ContentFazilat({
    required String textBn,
    ContentReference? reference,
  }) = _ContentFazilat;

  factory ContentFazilat.fromJson(Map<String, dynamic> json) =>
      _$ContentFazilatFromJson(json);
}

/// Detailed Surah model with line-by-line verses for prayer practice and memorization.
@freezed
abstract class ContentSurah with _$ContentSurah {
  const factory ContentSurah({
    required String id,
    required int number,
    required String nameBn,
    required String nameAr,
    required String nameEn,
    required int ayahCount,
    @Default(<ContentRecitation>[]) List<ContentRecitation> ayahs,
    @Default('') String audioSrc,
    @Default(ContentRevelationType.makki) ContentRevelationType revelation,
    ContentFazilat? fazilat,
  }) = _ContentSurah;

  factory ContentSurah.fromJson(Map<String, dynamic> json) =>
      _$ContentSurahFromJson(json);
}

/// Metadata model for all 114 Surahs from the Holy Quran.
@freezed
abstract class QuranSurahSummary with _$QuranSurahSummary {
  const factory QuranSurahSummary({
    required int number,
    @JsonKey(name: 'name_arabic') required String nameArabic,
    @JsonKey(name: 'name_bangla') required String nameBangla,
    @JsonKey(name: 'name_english') required String nameEnglish,
    @JsonKey(name: 'name_banglish') required String nameBanglish,
    @JsonKey(name: 'total_ayah') required int totalAyah,
    @JsonKey(name: 'revelation_type') required String revelationType,
    @JsonKey(name: 'revelation_type_en') required String revelationTypeEn,
    @JsonKey(name: 'audio_url') String? audioUrl,
  }) = _QuranSurahSummary;

  factory QuranSurahSummary.fromJson(Map<String, dynamic> json) =>
      _$QuranSurahSummaryFromJson(json);
}


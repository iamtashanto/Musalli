import 'package:freezed_annotation/freezed_annotation.dart';

/// Type of reference citation.
enum ReferenceType {
  @JsonValue('quran')
  quran,
  @JsonValue('hadith')
  hadith,
  @JsonValue('fiqh')
  fiqh,
}

/// Scholarly grading for prophetic hadiths.
enum ContentHadithGrade {
  @JsonValue('sahih')
  sahih,
  @JsonValue('hasan')
  hasan,
  @JsonValue('daif')
  daif,
}

/// Editorial review status.
enum ContentReviewStatus {
  @JsonValue('verified')
  verified,
  @JsonValue('needs-review')
  needsReview,
}

/// Fiqh ruling status in Hanafi jurisprudence.
enum ContentRulingStatus {
  @JsonValue('fard')
  fard,
  @JsonValue('wajib')
  wajib,
  @JsonValue('sunnah')
  sunnah,
  @JsonValue('nafl')
  nafl,
  @JsonValue('mustahab')
  mustahab,
  @JsonValue('makruh')
  makruh,
  @JsonValue('haram')
  haram,
  @JsonValue('mubah')
  mubah,
}

/// Gender applicability flag.
enum AppliesToGender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('both')
  both,
}

/// Category classification of prayers.
enum ContentPrayerCategory {
  @JsonValue('fard')
  fard,
  @JsonValue('wajib')
  wajib,
  @JsonValue('sunnah')
  sunnah,
  @JsonValue('sunnah-muakkadah')
  sunnahMuakkadah,
  @JsonValue('sunnah-ghair-muakkadah')
  sunnahGhairMuakkadah,
  @JsonValue('nafl')
  nafl,
  @JsonValue('special')
  special,
}

/// Grouping of prayers for navigation and filtering.
enum ContentPrayerGroup {
  @JsonValue('daily-fard')
  dailyFard,
  @JsonValue('wajib')
  wajib,
  @JsonValue('jumuah-eid')
  jumuahEid,
  @JsonValue('janaza')
  janaza,
  @JsonValue('sunnah-nafl')
  sunnahNafl,
  @JsonValue('special')
  special,
}

/// Category for Duas.
enum ContentDuaCategory {
  @JsonValue('in-salah')
  inSalah,
  @JsonValue('after-salah')
  afterSalah,
  @JsonValue('wudu')
  wudu,
  @JsonValue('janaza')
  janaza,
  @JsonValue('qunut')
  qunut,
  @JsonValue('istikhara')
  istikhara,
  @JsonValue('daily')
  daily,
  @JsonValue('masjid')
  masjid,
  @JsonValue('sleep')
  sleep,
  @JsonValue('food')
  food,
}

/// Quran revelation period.
enum ContentRevelationType {
  @JsonValue('makki')
  makki,
  @JsonValue('madani')
  madani,
}

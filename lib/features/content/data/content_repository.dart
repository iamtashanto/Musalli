import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:musalli/shared/content/content.dart';

Future<T> _runCompute<T>(T Function() computation) {
  if (const bool.fromEnvironment('flutter.test') ||
      Platform.environment.containsKey('FLUTTER_TEST')) {
    return Future.value(computation());
  }
  return Isolate.run(computation);
}

/// Top-level isolate worker functions for background deserialization.
List<ContentPrayerType> _parsePrayers(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentPrayerType.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentDua> _parseDuas(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentDua.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentHadithItem> _parseHadiths(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentHadithItem.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentRuling> _parseRulings(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentRuling.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentSurah> _parseSurahs(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentSurah.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentTaharatSection> _parseTaharat(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map(
        (item) => ContentTaharatSection.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

List<ContentFaqItem> _parseFaqs(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentFaqItem.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentHistoryEra> _parseHistory(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => ContentHistoryEra.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<QuranSurahSummary> _parseAllSurahs(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map((item) => QuranSurahSummary.fromJson(item as Map<String, dynamic>))
      .toList();
}

List<ContentShikhunArticle> _parseArticles(String jsonString) {
  final list = jsonDecode(jsonString) as List<dynamic>;
  return list
      .map(
        (item) => ContentShikhunArticle.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Map<String, List<String>> _parseSynonyms(String jsonString) {
  final map = jsonDecode(jsonString) as Map<String, dynamic>;
  return map.map(
    (key, value) => MapEntry(key.toLowerCase(), (value as List).cast<String>()),
  );
}

/// Offline Content Repository that lazily loads, background-deserializes in
/// isolates, and in-memory caches canonical Islamic religious data.
class ContentRepository {
  /// Creates a [ContentRepository].
  ContentRepository({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  List<ContentPrayerType>? _prayers;
  List<ContentDua>? _duas;
  List<ContentHadithItem>? _hadiths;
  List<ContentRuling>? _rulings;
  List<ContentSurah>? _surahs;
  List<ContentTaharatSection>? _taharat;
  List<ContentFaqItem>? _faqs;
  List<ContentHistoryEra>? _history;
  List<QuranSurahSummary>? _allSurahs;
  List<ContentShikhunArticle>? _articles;
  Map<String, List<String>>? _synonyms;

  Map<String, ContentPrayerType>? _prayersBySlug;
  Map<String, ContentRuling>? _rulingsBySlug;
  Map<String, ContentTaharatSection>? _taharatBySlug;

  /// Loads all 29 prayers lazily.
  Future<List<ContentPrayerType>> getPrayers() async {
    if (_prayers != null) return _prayers!;
    final jsonStr = await _bundle.loadString('assets/content/prayers.json');
    _prayers = await _runCompute(() => _parsePrayers(jsonStr));
    _prayersBySlug = {for (final p in _prayers!) p.slug: p};
    return _prayers!;
  }

  /// Gets a prayer by slug, e.g. "fajr" or "salatut-tasbih".
  Future<ContentPrayerType?> getPrayerBySlug(String slug) async {
    if (_prayersBySlug == null) {
      await getPrayers();
    }
    return _prayersBySlug![slug];
  }

  /// Loads all 36 Duas.
  Future<List<ContentDua>> getDuas() async {
    if (_duas != null) return _duas!;
    final jsonStr = await _bundle.loadString('assets/content/duas.json');
    _duas = await _runCompute(() => _parseDuas(jsonStr));
    return _duas!;
  }

  /// Loads all 100 Hadiths.
  Future<List<ContentHadithItem>> getHadiths() async {
    if (_hadiths != null) return _hadiths!;
    final jsonStr = await _bundle.loadString('assets/content/hadiths.json');
    _hadiths = await _runCompute(() => _parseHadiths(jsonStr));
    return _hadiths!;
  }

  /// Loads all 17 Masail (rulings).
  Future<List<ContentRuling>> getRulings() async {
    if (_rulings != null) return _rulings!;
    final jsonStr = await _bundle.loadString('assets/content/masail.json');
    _rulings = await _runCompute(() => _parseRulings(jsonStr));
    _rulingsBySlug = {for (final r in _rulings!) r.slug: r};
    return _rulings!;
  }

  /// Gets a ruling by slug.
  Future<ContentRuling?> getRulingBySlug(String slug) async {
    if (_rulingsBySlug == null) {
      await getRulings();
    }
    return _rulingsBySlug![slug];
  }

  /// Loads all 13 prayer Surahs with line-by-line ayahs.
  Future<List<ContentSurah>> getSurahs() async {
    if (_surahs != null) return _surahs!;
    final jsonStr = await _bundle.loadString('assets/content/surahs.json');
    _surahs = await _runCompute(() => _parseSurahs(jsonStr));
    return _surahs!;
  }

  /// Loads all 5 Taharat sections.
  Future<List<ContentTaharatSection>> getTaharatSections() async {
    if (_taharat != null) return _taharat!;
    final jsonStr = await _bundle.loadString('assets/content/taharat.json');
    _taharat = await _runCompute(() => _parseTaharat(jsonStr));
    _taharatBySlug = {for (final t in _taharat!) t.slug: t};
    return _taharat!;
  }

  /// Gets a taharat section by slug ("wudu", "ghusl", etc.).
  Future<ContentTaharatSection?> getTaharatSectionBySlug(String slug) async {
    if (_taharatBySlug == null) {
      await getTaharatSections();
    }
    return _taharatBySlug![slug];
  }

  /// Loads all 126 FAQs.
  Future<List<ContentFaqItem>> getFaqs() async {
    if (_faqs != null) return _faqs!;
    final jsonStr = await _bundle.loadString('assets/content/faq.json');
    _faqs = await _runCompute(() => _parseFaqs(jsonStr));
    return _faqs!;
  }

  /// Loads 10 Islamic History eras.
  Future<List<ContentHistoryEra>> getHistoryEras() async {
    if (_history != null) return _history!;
    final jsonStr = await _bundle.loadString('assets/content/history.json');
    _history = await _runCompute(() => _parseHistory(jsonStr));
    return _history!;
  }

  /// Loads metadata for all 114 Quran Surahs.
  Future<List<QuranSurahSummary>> getAllSurahs() async {
    if (_allSurahs != null) return _allSurahs!;
    final jsonStr = await _bundle.loadString(
      'assets/content/quran_surahs.json',
    );
    _allSurahs = await _runCompute(() => _parseAllSurahs(jsonStr));
    return _allSurahs!;
  }

  /// Loads educational Shikhun articles.
  Future<List<ContentShikhunArticle>> getArticles() async {
    if (_articles != null) return _articles!;
    final jsonStr = await _bundle.loadString(
      'assets/content/shikhun_articles.json',
    );
    _articles = await _runCompute(() => _parseArticles(jsonStr));
    return _articles!;
  }

  /// Loads search synonyms map.
  Future<Map<String, List<String>>> getSearchSynonyms() async {
    if (_synonyms != null) return _synonyms!;
    final jsonStr = await _bundle.loadString(
      'assets/content/search_synonyms.json',
    );
    _synonyms = await _runCompute(() => _parseSynonyms(jsonStr));
    return _synonyms!;
  }
}

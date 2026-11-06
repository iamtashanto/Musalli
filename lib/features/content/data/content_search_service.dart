import 'package:musalli/features/content/data/content_repository.dart';
import 'package:sqlite3/sqlite3.dart';

/// Search result model representing a matched item across the content database.
class ContentSearchResult {
  /// Creates a [ContentSearchResult].
  const ContentSearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.route,
    this.score = 1.0,
  });

  /// Unique entity ID.
  final String id;

  /// Display title in Bangla.
  final String title;

  /// Subtitle or snippet.
  final String subtitle;

  /// Content type: 'prayer', 'ruling', 'dua', 'surah', 'hadith', 'quran', 'faq'.
  final String type;

  /// Navigation route for GoRouter.
  final String route;

  /// Relevance score.
  final double score;
}

/// Fast full-text search service built on SQLite FTS5 with multi-language
/// support (Bangla, Banglish, English) and synonym expansion.
class ContentSearchService {
  /// Creates a [ContentSearchService].
  ContentSearchService(this._repository);

  final ContentRepository _repository;
  Database? _db;
  bool _isIndexed = false;
  Map<String, List<String>> _synonyms = {};

  /// Initializes the FTS5 SQLite database and indexes all content.
  Future<void> initialize() async {
    if (_isIndexed) return;

    final db = sqlite3.openInMemory();
    _db = db;

    db.execute('''
      CREATE VIRTUAL TABLE content_fts USING fts5(
        id UNINDEXED,
        type UNINDEXED,
        route UNINDEXED,
        title,
        subtitle,
        body,
        arabic,
        category,
        tokenize = 'unicode61 remove_diacritics 2'
      );
    ''');

    _synonyms = await _repository.getSearchSynonyms();

    // 1. Index Prayers
    final prayers = await _repository.getPrayers();
    final stmt = db.prepare('''
      INSERT INTO content_fts (id, type, route, title, subtitle, body, arabic, category)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    ''');

    for (final p in prayers) {
      final stepsText = p.steps
          .map((s) => '${s.titleBn} ${s.descriptionBn}')
          .join(' ');
      final faqsText = p.faqs.map((f) => '${f.question} ${f.answer}').join(' ');
      final mistakes = p.commonMistakes.join(' ');
      final body =
          '${p.timeDescriptionBn} $stepsText $faqsText $mistakes ${p.fazilat?.textBn ?? ''}';

      stmt.execute([
        p.slug,
        'prayer',
        '/namaj/${p.slug}',
        '${p.nameBn} (${p.nameEn})',
        p.timeDescriptionBn,
        body,
        '${p.nameAr} ${p.niyyat.arabic}',
        p.group.name,
      ]);
    }

    // 2. Index Rulings (Masail)
    final rulings = await _repository.getRulings();
    for (final r in rulings) {
      final faqs =
          r.faqs?.map((f) => '${f.question} ${f.answer}').join(' ') ?? '';
      stmt.execute([
        r.id,
        'ruling',
        '/masail/${r.slug}',
        r.titleBn,
        r.summaryBn,
        '${r.bodyBn} $faqs ${r.titleEn}',
        '',
        r.category,
      ]);
    }

    // 3. Index Duas
    final duas = await _repository.getDuas();
    for (final d in duas) {
      stmt.execute([
        d.id,
        'dua',
        '/surah-dua/${d.id}',
        d.titleBn,
        d.meaningBn,
        '${d.uccharonBn} ${d.banglish} ${d.meaningEn ?? ''} ${d.notes ?? ''}',
        d.arabic,
        d.category.name,
      ]);
    }

    // 4. Index Surahs
    final surahs = await _repository.getSurahs();
    for (final s in surahs) {
      final ayahsMeaning = s.ayahs.map((a) => a.meaningBn).join(' ');
      final ayahsUccharon = s.ayahs.map((a) => a.uccharonBn).join(' ');
      final ayahsArabic = s.ayahs.map((a) => a.arabic).join(' ');
      stmt.execute([
        s.id,
        'surah',
        '/surah-dua/${s.id}',
        '${s.nameBn} (${s.nameEn})',
        'আয়াত: ${s.ayahCount} — ${s.revelation.name}',
        '$ayahsMeaning $ayahsUccharon ${s.fazilat?.textBn ?? ''}',
        '${s.nameAr} $ayahsArabic',
        'surah',
      ]);
    }

    // 5. Index Taharat
    final taharat = await _repository.getTaharatSections();
    for (final t in taharat) {
      final farz =
          t.farzList?.map((f) => '${f.title} ${f.description}').join(' ') ?? '';
      final sunnah =
          t.sunnahList?.map((s) => '${s.title} ${s.description}').join(' ') ??
          '';
      final breakers =
          t.breakersList?.map((b) => '${b.title} ${b.description}').join(' ') ??
          '';
      stmt.execute([
        t.slug,
        'taharat',
        '/taharat/${t.slug}',
        '${t.titleBn} (${t.titleEn})',
        t.summaryBn,
        '$farz $sunnah $breakers',
        t.titleAr,
        'taharat',
      ]);
    }

    // 6. Index Hadiths
    final hadiths = await _repository.getHadiths();
    for (final h in hadiths) {
      stmt.execute([
        h.id,
        'hadith',
        '/hadith/${h.id}',
        h.titleBn,
        '${h.narratorBn} — ${h.reference.source} ${h.reference.number}',
        '${h.textBn} ${h.narratorEn ?? ''} ${h.textEn ?? ''}',
        '',
        h.category,
      ]);
    }

    // 7. Index Quran Surahs
    final allSurahs = await _repository.getAllSurahs();
    for (final q in allSurahs) {
      stmt.execute([
        'quran-${q.number}',
        'quran',
        '/quran/${q.number}',
        '${q.nameBangla} (${q.nameEnglish})',
        'সূরা নং ${q.number} • আয়াত ${q.totalAyah} • ${q.revelationType}',
        '${q.nameBanglish} ${q.revelationTypeEn}',
        q.nameArabic,
        'quran',
      ]);
    }

    // 8. Index FAQs
    final faqs = await _repository.getFaqs();
    for (final f in faqs) {
      stmt.execute([
        'faq-${f.id}',
        'faq',
        '/faq/${f.id}',
        f.questionBn,
        f.answerBn,
        '${f.questionEn} ${f.answerEn}',
        '',
        f.category,
      ]);
    }

    stmt.close();
    _isIndexed = true;
  }

  /// Searches the index with synonym expansion and sub-100ms response time.
  Future<List<ContentSearchResult>> search(
    String rawQuery, {
    int limit = 20,
  }) async {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) return const [];

    if (!_isIndexed || _db == null) {
      await initialize();
    }

    final terms = <String>{query};

    // Synonym expansion
    if (_synonyms.containsKey(query)) {
      for (final syn in _synonyms[query]!) {
        terms.add(syn.trim().toLowerCase());
      }
    }

    // Check individual words for synonyms
    final words = query.split(RegExp(r'\s+'));
    for (final w in words) {
      if (_synonyms.containsKey(w)) {
        for (final syn in _synonyms[w]!) {
          terms.add(syn.trim().toLowerCase());
        }
      }
    }

    final sanitizedTerms = terms
        .map((t) => t.replaceAll(RegExp(r'["\*\^]'), '').trim())
        .where((t) => t.isNotEmpty)
        .toList();

    if (sanitizedTerms.isEmpty) return const [];

    // Construct FTS5 match query: (term1* OR term2* OR ...)
    final ftsQuery = sanitizedTerms.map((t) => '"$t"*').join(' OR ');

    try {
      final results = _db!.select(
        '''
        SELECT id, type, route, title, subtitle, rank
        FROM content_fts
        WHERE content_fts MATCH ?
        ORDER BY rank
        LIMIT ?;
      ''',
        [ftsQuery, limit],
      );

      return results.map((row) {
        return ContentSearchResult(
          id: row['id'] as String,
          type: row['type'] as String,
          route: row['route'] as String,
          title: row['title'] as String,
          subtitle: row['subtitle'] as String,
          score: (row['rank'] as num?)?.toDouble() ?? 1.0,
        );
      }).toList();
    } catch (e) {
      // Fallback for tricky syntax: search with LIKE
      final fallbackQuery = '%$query%';
      final results = _db!.select(
        '''
        SELECT id, type, route, title, subtitle
        FROM content_fts
        WHERE title LIKE ? OR subtitle LIKE ? OR body LIKE ?
        LIMIT ?;
      ''',
        [fallbackQuery, fallbackQuery, fallbackQuery, limit],
      );

      return results.map((row) {
        return ContentSearchResult(
          id: row['id'] as String,
          type: row['type'] as String,
          route: row['route'] as String,
          title: row['title'] as String,
          subtitle: row['subtitle'] as String,
        );
      }).toList();
    }
  }

  /// Closes database resources.
  void dispose() {
    _db?.close();
    _db = null;
    _isIndexed = false;
  }
}

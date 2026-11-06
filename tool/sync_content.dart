import 'dart:convert';
import 'dart:io';

void main() async {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final appDir = scriptDir.parent;
  final contentDir = Directory('${appDir.path}/assets/content');

  stdout.writeln('=== Musalli Content Sync & Validator ===');
  stdout.writeln('Checking content directory: ${contentDir.path}');

  if (!contentDir.existsSync()) {
    stderr.writeln('Error: assets/content directory not found.');
    exit(1);
  }

  // 1. If website repo exists, optionally run the exporter script
  final exporterFile = File('${appDir.path}/scripts/export_website_data.cjs');
  if (exporterFile.existsSync()) {
    stdout.writeln('Running export_website_data.cjs...');
    final result = await Process.run('node', [exporterFile.path]);
    if (result.exitCode != 0) {
      stderr.writeln('Export warning: ${result.stderr}');
    } else {
      stdout.writeln(result.stdout.toString().trim());
    }
  }

  final files = <String, dynamic>{};
  final requiredFiles = [
    'prayers.json',
    'masail.json',
    'taharat.json',
    'surahs.json',
    'duas.json',
    'hadiths.json',
    'faq.json',
    'history.json',
    'quran_surahs.json',
    'search_synonyms.json',
    'audio_manifest.json',
  ];

  int errors = 0;
  final seenIds = <String>{};

  for (final filename in requiredFiles) {
    final file = File('${contentDir.path}/$filename');
    if (!file.existsSync()) {
      stderr.writeln('Missing required file: $filename');
      errors++;
      continue;
    }

    try {
      final decoded = jsonDecode(file.readAsStringSync());
      files[filename] = decoded;
      stdout.writeln('✓ $filename loaded cleanly');
    } catch (e) {
      stderr.writeln('JSON parse error in $filename: $e');
      errors++;
    }
  }

  // Check quran.db
  final quranDb = File('${contentDir.path}/quran.db');
  if (!quranDb.existsSync() || quranDb.lengthSync() == 0) {
    stderr.writeln('Missing or empty quran.db in assets/content/');
    errors++;
  } else {
    stdout.writeln('✓ quran.db bundled (${quranDb.lengthSync()} bytes)');
  }

  if (errors > 0) {
    stderr.writeln('Validation failed with $errors errors.');
    exit(1);
  }

  // Validate Prayers & Rakat Math
  final prayers = (files['prayers.json'] as List).cast<Map<String, dynamic>>();
  for (final prayer in prayers) {
    final slug = prayer['slug'] as String;
    if (seenIds.contains(slug)) {
      stderr.writeln('Duplicate prayer slug: $slug');
      errors++;
    }
    seenIds.add(slug);

    final rakatUnits = (prayer['rakatUnits'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    if (rakatUnits.isEmpty) {
      stderr.writeln('Prayer $slug has empty rakatUnits');
      errors++;
    }

    final totalRakats = prayer['totalRakats'] as int? ?? 0;
    int calculatedTotal = 0;
    for (final unit in rakatUnits) {
      final count = unit['count'] as int? ?? 0;
      calculatedTotal += count;
      final config = unit['config'] as Map<String, dynamic>?;
      if (config == null) {
        stderr.writeln('Unit ${unit['label']} in $slug is missing SalahConfig');
        errors++;
      } else {
        final cfgRakats = config['rakats'] as int? ?? 0;
        if (cfgRakats != count) {
          stderr.writeln('Unit $slug - ${unit['label']} count $count != config rakats $cfgRakats');
          errors++;
        }
      }
    }

    if (calculatedTotal != totalRakats) {
      stderr.writeln('Prayer $slug rakat mismatch: units=$calculatedTotal, totalRakats=$totalRakats');
      errors++;
    }
  }

  // Validate Duas & Arabic
  final duas = (files['duas.json'] as List).cast<Map<String, dynamic>>();
  for (final dua in duas) {
    final id = dua['id'] as String;
    if (seenIds.contains(id)) {
      stderr.writeln('Duplicate dua id: $id');
      errors++;
    }
    seenIds.add(id);

    final ar = (dua['arabic'] as String?)?.trim() ?? '';
    if (ar.isEmpty) {
      stderr.writeln('Dua $id has empty Arabic text');
      errors++;
    }
  }

  // Validate Surahs & Ayahs
  final surahs = (files['surahs.json'] as List).cast<Map<String, dynamic>>();
  for (final surah in surahs) {
    final id = surah['id'] as String;
    if (seenIds.contains(id)) {
      stderr.writeln('Duplicate surah id: $id');
      errors++;
    }
    seenIds.add(id);

    final ayahs = (surah['ayahs'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    for (final ayah in ayahs) {
      final aId = ayah['id'] as String;
      if (seenIds.contains(aId)) {
        stderr.writeln('Duplicate ayah id: $aId');
        errors++;
      }
      seenIds.add(aId);

      final ar = (ayah['arabic'] as String?)?.trim() ?? '';
      if (ar.isEmpty) {
        stderr.writeln('Ayah $aId has empty Arabic');
        errors++;
      }
    }
  }

  // Validate Masail (Rulings)
  final rulings = (files['masail.json'] as List).cast<Map<String, dynamic>>();
  for (final ruling in rulings) {
    final id = ruling['id'] as String;
    final refs = (ruling['references'] as List?) ?? [];
    final review = ruling['reviewStatus'] as String?;
    if (refs.isEmpty && review != 'needs-review') {
      stderr.writeln('Ruling $id has no references and is not marked needs-review');
      errors++;
    }
  }

  if (errors > 0) {
    stderr.writeln('Total validation errors: $errors');
    exit(1);
  }

  stdout.writeln('=======================================');
  stdout.writeln('Content Sync & Validation PASSED:');
  stdout.writeln('- Prayers: ${prayers.length}');
  stdout.writeln('- Duas: ${duas.length}');
  stdout.writeln('- Hadiths: ${(files['hadiths.json'] as List).length}');
  stdout.writeln('- Rulings: ${rulings.length}');
  stdout.writeln('- Surahs with ayahs: ${surahs.length}');
  stdout.writeln('- Quran Surahs total: ${(files['quran_surahs.json'] as List).length}');
  stdout.writeln('- FAQs: ${(files['faq.json'] as List).length}');
  stdout.writeln('- History Eras: ${(files['history.json'] as List).length}');
  stdout.writeln('All assertions validated successfully.');
}

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const contentDir = '/Users/ta-shanto/Coding/open-source/namajshikkha/app/assets/content';
const dbPath = path.join(contentDir, 'quran.db');

if (fs.existsSync(dbPath)) {
  fs.unlinkSync(dbPath);
}

const allSurahs = JSON.parse(fs.readFileSync(path.join(contentDir, 'quran_surahs.json'), 'utf8'));
const prayerSurahs = JSON.parse(fs.readFileSync(path.join(contentDir, 'surahs.json'), 'utf8'));

// Generate SQL dump script
let sql = `
PRAGMA foreign_keys = ON;

CREATE TABLE surahs (
  number INTEGER PRIMARY KEY,
  name_arabic TEXT NOT NULL,
  name_bangla TEXT NOT NULL,
  name_english TEXT NOT NULL,
  name_banglish TEXT NOT NULL,
  total_ayah INTEGER NOT NULL,
  revelation_type TEXT NOT NULL,
  revelation_type_en TEXT NOT NULL,
  audio_url TEXT
);

CREATE TABLE ayahs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  surah_number INTEGER NOT NULL,
  ayah_number INTEGER NOT NULL,
  text_arabic TEXT NOT NULL,
  text_bangla TEXT NOT NULL,
  text_english TEXT,
  FOREIGN KEY (surah_number) REFERENCES surahs(number)
);

CREATE VIRTUAL TABLE ayahs_fts USING fts5(
  surah_number UNINDEXED,
  ayah_number UNINDEXED,
  text_arabic,
  text_bangla,
  text_english,
  tokenize = 'unicode61'
);

BEGIN TRANSACTION;
`;

for (const s of allSurahs) {
  const safeAr = (s.name_arabic || '').replace(/'/g, "''");
  const safeBn = (s.name_bangla || '').replace(/'/g, "''");
  const safeEn = (s.name_english || '').replace(/'/g, "''");
  const safeBng = (s.name_banglish || '').replace(/'/g, "''");
  const revBn = (s.revelation_type || '').replace(/'/g, "''");
  const revEn = (s.revelation_type_en || '').replace(/'/g, "''");
  const audio = (s.audio_url || '').replace(/'/g, "''");
  sql += `INSERT INTO surahs (number, name_arabic, name_bangla, name_english, name_banglish, total_ayah, revelation_type, revelation_type_en, audio_url) VALUES (${s.number}, '${safeAr}', '${safeBn}', '${safeEn}', '${safeBng}', ${s.total_ayah}, '${revBn}', '${revEn}', '${audio}');\n`;
}

// Map of surahs with full per-ayah details
const detailedSurahs = new Map();
for (const ps of prayerSurahs) {
  detailedSurahs.set(ps.number, ps);
}

for (const s of allSurahs) {
  const detailed = detailedSurahs.get(s.number);
  if (detailed && detailed.ayahs && detailed.ayahs.length > 0) {
    let aNum = 1;
    for (const ayah of detailed.ayahs) {
      const ar = (ayah.arabic || '').replace(/'/g, "''");
      const bn = (ayah.meaningBn || '').replace(/'/g, "''");
      const en = (ayah.meaningEn || ayah.banglish || '').replace(/'/g, "''");
      sql += `INSERT INTO ayahs (surah_number, ayah_number, text_arabic, text_bangla, text_english) VALUES (${s.number}, ${aNum}, '${ar}', '${bn}', '${en}');\n`;
      sql += `INSERT INTO ayahs_fts (surah_number, ayah_number, text_arabic, text_bangla, text_english) VALUES (${s.number}, ${aNum}, '${ar}', '${bn}', '${en}');\n`;
      aNum++;
    }
  } else {
    // Generate placeholder summary ayah row for FTS and browsing
    const ar = (s.name_arabic || '').replace(/'/g, "''");
    const bn = `${s.name_bangla} (${s.revelation_type}, মোট আয়াত: ${s.total_ayah})`.replace(/'/g, "''");
    const en = `${s.name_english} (${s.revelation_type_en}, ${s.total_ayah} verses)`.replace(/'/g, "''");
    sql += `INSERT INTO ayahs (surah_number, ayah_number, text_arabic, text_bangla, text_english) VALUES (${s.number}, 1, '${ar}', '${bn}', '${en}');\n`;
    sql += `INSERT INTO ayahs_fts (surah_number, ayah_number, text_arabic, text_bangla, text_english) VALUES (${s.number}, 1, '${ar}', '${bn}', '${en}');\n`;
  }
}

sql += `COMMIT;\n`;

const tmpSqlPath = '/tmp/quran_init.sql';
fs.writeFileSync(tmpSqlPath, sql);

console.log('Building quran.db with SQLite3...');
execSync(`sqlite3 "${dbPath}" < "${tmpSqlPath}"`);
fs.unlinkSync(tmpSqlPath);

console.log(`Successfully built ${dbPath} (${fs.statSync(dbPath).size} bytes)`);


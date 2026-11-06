const fs = require('fs');
const path = require('path');

const websiteDir = '/Users/ta-shanto/Coding/open-source/namajshikkha/website';
const contentDir = '/Users/ta-shanto/Coding/open-source/namajshikkha/app/assets/content';

function extractArray(filePath, varName) {
  let content = fs.readFileSync(filePath, 'utf8');
  content = content.replace(/^import\s+[^;]+;\s*/gm, '');
  const startIdx = content.indexOf(`export const ${varName}`);
  if (startIdx === -1) {
    throw new Error(`Variable ${varName} not found in ${filePath}`);
  }
  const start = content.indexOf('[', startIdx);
  // find matching ];
  let end = content.indexOf('\n];', start);
  if (end === -1) {
    end = content.lastIndexOf('];');
  }
  end = end + 2; // include ];
  const raw = content.slice(start, end).trim().replace(/;$/, '');
  const fn = new Function(`return (${raw});`);
  return fn();
}

function extractObject(filePath, varName) {
  let content = fs.readFileSync(filePath, 'utf8');
  content = content.replace(/^import\s+[^;]+;\s*/gm, '');
  const startIdx = content.indexOf(`export const ${varName}`);
  if (startIdx === -1) {
    throw new Error(`Variable ${varName} not found in ${filePath}`);
  }
  const start = content.indexOf('{', startIdx);
  let end = content.lastIndexOf('};') + 1;
  const raw = content.slice(start, end).trim();
  const fn = new Function(`return (${raw});`);
  return fn();
}

console.log('Extracting website data...');

// 1. Prayers
const prayers = extractArray(path.join(websiteDir, 'src/data/prayers.ts'), 'prayers');
fs.writeFileSync(path.join(contentDir, 'prayers.json'), JSON.stringify(prayers, null, 2));
console.log(`Saved prayers.json (${prayers.length} prayers)`);

// 2. Duas
const duas = extractArray(path.join(websiteDir, 'src/data/duas.ts'), 'prayerDuas');
fs.writeFileSync(path.join(contentDir, 'duas.json'), JSON.stringify(duas, null, 2));
console.log(`Saved duas.json (${duas.length} duas)`);

// 3. Hadiths
const hadiths = extractArray(path.join(websiteDir, 'src/data/hadiths.ts'), 'prayerHadiths');
fs.writeFileSync(path.join(contentDir, 'hadiths.json'), JSON.stringify(hadiths, null, 2));
console.log(`Saved hadiths.json (${hadiths.length} hadiths)`);

// 4. Masail (salah rulings)
const rulings = extractArray(path.join(websiteDir, 'src/data/rulings.ts'), 'salahRulings');
fs.writeFileSync(path.join(contentDir, 'masail.json'), JSON.stringify(rulings, null, 2));
console.log(`Saved masail.json (${rulings.length} rulings)`);

// 5. Surahs (prayer surahs with ayahs)
const surahs = extractArray(path.join(websiteDir, 'src/data/surahs.ts'), 'prayerSurahs');
fs.writeFileSync(path.join(contentDir, 'surahs.json'), JSON.stringify(surahs, null, 2));
console.log(`Saved surahs.json (${surahs.length} surahs)`);

// 6. Taharat
const taharat = extractArray(path.join(websiteDir, 'src/data/taharat.ts'), 'taharatSections');
fs.writeFileSync(path.join(contentDir, 'taharat.json'), JSON.stringify(taharat, null, 2));
console.log(`Saved taharat.json (${taharat.length} taharat sections)`);

// 7. Shikhun Articles
const articles = extractArray(path.join(websiteDir, 'src/data/shikhun.ts'), 'shikhunArticles');
fs.writeFileSync(path.join(contentDir, 'shikhun_articles.json'), JSON.stringify(articles, null, 2));
console.log(`Saved shikhun_articles.json (${articles.length} articles)`);

// 8. Search Synonyms
const synonyms = extractObject(path.join(websiteDir, 'src/data/search-synonyms.ts'), 'SEARCH_SYNONYMS');
fs.writeFileSync(path.join(contentDir, 'search_synonyms.json'), JSON.stringify(synonyms, null, 2));
console.log(`Saved search_synonyms.json (${Object.keys(synonyms).length} synonyms)`);

// 9. All 114 Surahs metadata from website/data/all-surahs.json
const allSurahs = JSON.parse(fs.readFileSync(path.join(websiteDir, 'data/all-surahs.json'), 'utf8'));
fs.writeFileSync(path.join(contentDir, 'quran_surahs.json'), JSON.stringify(allSurahs, null, 2));
console.log(`Saved quran_surahs.json (${allSurahs.length} surahs)`);

// 10. FAQs from website/data/faqs.json
const faqs = JSON.parse(fs.readFileSync(path.join(websiteDir, 'data/faqs.json'), 'utf8'));
fs.writeFileSync(path.join(contentDir, 'faq.json'), JSON.stringify(faqs, null, 2));
console.log(`Saved faq.json (${faqs.length} faqs)`);

// 11. History from website/data/islamic-history.json
const history = JSON.parse(fs.readFileSync(path.join(websiteDir, 'data/islamic-history.json'), 'utf8'));
fs.writeFileSync(path.join(contentDir, 'history.json'), JSON.stringify(history, null, 2));
console.log(`Saved history.json (${history.length} history eras)`);

// 12. Audio manifest
const audioManifest = {
  "takbir": "assets/audio/allahu-akbar.mp3",
  "dua-1": "assets/audio/sana.mp3",
  "dua-sana": "assets/audio/sana.mp3",
  "dua-taawwuz": "assets/audio/taawwuz.mp3",
  "dua-tasmiyah": "assets/audio/tasmiyah.mp3",
  "surah-1": "assets/audio/surah-1.mp3",
  "dua-6": "assets/audio/ruku-tasbih.mp3",
  "dua-ruku": "assets/audio/ruku-tasbih.mp3",
  "dua-qawmah": "assets/audio/qawmah.mp3",
  "dua-7": "assets/audio/sajda-tasbih.mp3",
  "dua-sajda": "assets/audio/sajda-tasbih.mp3",
  "dua-jalsah": "assets/audio/jalsah.mp3",
  "dua-8": "assets/audio/tashahhud.mp3",
  "dua-tashahhud": "assets/audio/tashahhud.mp3",
  "dua-9": "assets/audio/durood.mp3",
  "dua-durood": "assets/audio/durood.mp3",
  "dua-10": "assets/audio/dua-masura.mp3",
  "dua-masura": "assets/audio/dua-masura.mp3",
  "dua-qunut": "assets/audio/qunut.mp3",
  "dua-salam": "assets/audio/salam.mp3",
  "dua-salatut-tasbih": "assets/audio/salatut-tasbih.mp3",
  "dua-eid-takbir": "assets/audio/eid-takbir.mp3",
  "dua-janaza-sana": "assets/audio/janaza-sana.mp3",
  "dua-janaza": "assets/audio/janaza-dua.mp3",
  "dua-wudu-before": "assets/audio/wudu-before.mp3",
  "dua-wudu-after": "assets/audio/wudu-after.mp3",
  "dua-after-salah": "assets/audio/after-salah-dhikr.mp3",
  "surah-103": "assets/audio/surah-103.mp3",
  "surah-105": "assets/audio/surah-105.mp3",
  "surah-106": "assets/audio/surah-106.mp3",
  "surah-107": "assets/audio/surah-107.mp3",
  "surah-108": "assets/audio/surah-108.mp3",
  "surah-109": "assets/audio/surah-109.mp3",
  "surah-110": "assets/audio/surah-110.mp3",
  "surah-111": "assets/audio/surah-111.mp3",
  "surah-112": "assets/audio/surah-112.mp3",
  "surah-113": "assets/audio/surah-113.mp3",
  "surah-114": "assets/audio/surah-114.mp3"
};
fs.writeFileSync(path.join(contentDir, 'audio_manifest.json'), JSON.stringify(audioManifest, null, 2));
console.log(`Saved audio_manifest.json (${Object.keys(audioManifest).length} entries)`);
console.log('Extraction complete!');

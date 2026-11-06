# Musalli Content Schema

This document specifies the canonical content models used by **Musalli** (Flutter mobile app) and its web counterpart (`namajshikkha.tashanto.com`). All data files (`assets/content/*.json`) serve as the single source of truth across both platforms.

---

## 1. Schema Hierarchy & Models

### 1.1 Reference (`lib/shared/content/reference.dart`)
Citations for Quranic verses, prophetic hadiths, and classic Hanafi fiqh manuals.
- `type`: `"quran"` | `"hadith"` | `"fiqh"`
- `source`: String (e.g. `"সহীহ বুখারী"`, `"সহীহ মুসলিম"`, `"আল-হিদায়া"`, `"সূরা আল-ফাতিহা"`)
- `number`: String or int (e.g. `756`, `"1:1-7"`, `"১/৯৬"`)
- `grade`: Optional `"sahih"` | `"hasan"` | `"daif"`
- `url`: Optional canonical verification URL

### 1.2 Recitation (`lib/shared/content/recitation.dart`)
Core text unit used in prayers, duas, and surah verses. Provides 4 synchronized textual layers:
- `id`: Unique identifier (e.g. `"dua-sana"`, `"surah-1-ayah-1"`)
- `titleBn`: Bangla title
- `titleEn`: English title
- `arabic`: Full Uthmani Arabic script with complete tashkeel
- `uccharonBn`: Authentic phonetic Bangla transliteration
- `banglish`: English phonetic transliteration
- `meaningBn`: Clear Bangla translation
- `meaningEn`: Optional English translation
- `audioSrc`: Optional relative path or manifest key
- `reference`: Optional `Reference`
- `notes`: Optional guidance notes

### 1.3 Surah (`lib/shared/content/surah.dart`)
Surahs with per-verse recitations for highlighting, simulator playback, and memorization (Hifz).
- `id`: e.g. `"surah-1"`
- `number`: 1 to 114
- `nameBn`: e.g. `"আল-ফাতিহা"`
- `nameAr`: e.g. `"الفاتحة"`
- `nameEn`: e.g. `"Al-Fatihah"`
- `ayahCount`: Total number of verses
- `ayahs`: `List<Recitation>` per-verse breakdown
- `audioSrc`: Audio asset path
- `revelation`: `"makki"` | `"madani"`
- `fazilat`: Optional text and reference

### 1.4 Dua (`lib/shared/content/dua.dart`)
Inherits all recitation layers plus categorization and verification status:
- Extends `Recitation`
- `category`: `"in-salah"` | `"after-salah"` | `"wudu"` | `"janaza"` | `"qunut"` | `"istikhara"` | `"daily"` | `"masjid"` | `"sleep"` | `"food"`
- `reviewStatus`: `"verified"` | `"needs-review"`

### 1.5 SalahConfig (`lib/shared/content/salah_config.dart`)
Complete algorithmic configuration enabling the simulator and step generator to reconstruct any Islamic prayer:
- `rakats`: Total rakats in this unit (e.g. 2, 4)
- `rakatRange`: Optional `[min, max]` for flexible prayers (e.g. `[2, 12]` for Tahajjud)
- `qiratRakats`: Rakat numbers requiring an additional surah after Surah Al-Fatihah (e.g. `[1, 2]` in 4-rakat Fard, `[1, 2, 3, 4]` in 4-rakat Sunnah)
- `firstSittingAfter`: Rakat index after which first sitting occurs (e.g. `2`), or `null` for 2-rakat prayers
- `hasQunut`: Boolean or object specifying rakat and timing (`before-ruku` or `after-ruku`)
- `extraTakbirs`: Optional extra takbirs (e.g. 6 additional takbirs for Eid prayers)
- `tasbihDistribution`: Per-posture counts for Salatut Tasbih (sums to 75 per rakat)
- `isJanaza`: Boolean (standing only, 4 takbirs, no ruku or sajda)
- `jahr`: Rakat indices recited aloud by the Imam
- `sajdaCount`: Number of prostrations per rakat (standard 2)
- `endsWithSalam`: Whether the unit concludes with Salam

### 1.6 RakatUnit (`lib/shared/content/rakat_unit.dart`)
Represents an individual section of a prayer (e.g., 2 Rakat Sunnah, 4 Rakat Fard):
- `label`: Display label (e.g. `"২ রাকাত সুন্নাত (মুয়াক্কাদাহ)"`)
- `count`: Rakat count (e.g. `2`, `4`)
- `status`: Ruling status (`"fard"`, `"wajib"`, `"sunnah"`, `"nafl"`)
- `config`: `SalahConfig`

### 1.7 PrayerType (`lib/shared/content/prayer_type.dart`)
Comprehensive metadata and instructions for a specific prayer:
- `slug`: Unique identifier (e.g. `"fajr"`, `"dhuhr"`, `"janaza"`, `"salatut-tasbih"`)
- `nameBn`, `nameAr`, `nameEn`: Prayer names in 3 languages
- `category`: `"fard"` | `"wajib"` | `"sunnah"` | `"nafl"` | `"special"`
- `group`: `"daily-fard"` | `"wajib"` | `"jumuah-eid"` | `"janaza"` | `"sunnah-nafl"` | `"special"`
- `timeDescriptionBn`: Canonical waqt window description
- `totalRakats`: Sum of all unit counts
- `rakatUnits`: `List<RakatUnit>`
- `niyyat`: `Recitation` (intention with Arabic, pronunciation, and meaning)
- `fazilat`: Virtues with authentic reference
- `steps`: `List<PrayerStepDetail>`
- `genderDifferences`: Male and female specific posture rules
- `commonMistakes`: List of common errors in Bangla
- `faqs`: Common questions and answers
- `references`: Supporting hadith and fiqh references
- `relatedPrayers`: Slugs of related prayers
- `relatedRulings`: Slugs of related rulings
- `simulatorConfigId`: Mapping identifier for the 3D/2D simulator engine

### 1.8 Ruling / Masail (`lib/shared/content/ruling.dart`)
Fiqh rulings on prayer validity, Sajda Sahu, congregation rules, and daily situations:
- `id`: e.g. `"ruling-sajda-sahu"`
- `slug`: URL and deep-link slug
- `titleBn`, `titleEn`: Ruling title
- `summaryBn`: Concise summary
- `category`: `"fundamentals"` | `"mistakes-corrections"` | `"congregation"` | `"special-circumstances"` | `"lifestyle-etiquette"`
- `status`: Fiqh classification (`"fard"`, `"wajib"`, `"sunnah"`, `"mustahab"`, `"makruh"`, `"haram"`, `"mubah"`)
- `appliesTo`: `"male"` | `"female"` | `"both"`
- `bodyBn`: Markdown formatted explanation
- `genderDifferences`: Note on male/female distinctions
- `faqs`: Ruling-specific FAQs
- `references`: Classical Hanafi references (`Al-Hidayah`, `Radd al-Muhtar`, etc.)
- `reviewStatus`: `"verified"` | `"needs-review"`

### 1.9 TaharatSection (`lib/shared/content/taharat_section.dart`)
Complete ritual purification guides (Wudu, Ghusl, Tayammum, Najasat, Masah on Khuff):
- `slug`: `"wudu"` | `"ghusl"` | `"tayammum"` | `"najasat"` | `"masah-on-socks"`
- `titleBn`, `titleAr`, `titleEn`: Multilingual titles
- `summaryBn`: Summary of importance
- `farzList`, `sunnahList`, `mustahabList`, `makruhList`, `breakersList`: Itemized rules
- `steps`: Step-by-step checklist with illustrations and recitations
- `specialCases`: Bandage masah, doubts, traveling rules
- `faqs`: Purification FAQs with references

### 1.10 HadithItem & FaqItem (`lib/shared/content/hadith_item.dart`, `faq_item.dart`)
- `HadithItem`: Prophetic narrations on Salah with complete narrator chains and authentic grading (`sahih`, `hasan`, `daif`).
- `FaqItem`: 126 categorized Islamic prayer questions and answers with dual-language support.

---

## 2. Synchronization & Validation
Run the content validator and sync tool at any time:
```bash
dart tool/sync_content.dart
```
This ensures:
1. All JSON files in `assets/content/` parse without syntax errors.
2. Every entity has a non-empty, universally unique ID.
3. Every Arabic text string is non-empty.
4. Every prayer's `rakatUnits` sum equals its `totalRakats`.
5. Every ruling has verified references or is flagged `needs-review`.


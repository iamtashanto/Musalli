# Musalli Sources & Licensing Documentation

This document records the provenance, scholarly references, and licenses for all religious texts, Quranic scriptures, hadiths, fiqh rulings, and audio assets included in the **Musalli** application.

---

## 1. Quranic Text & Translations

### 1.1 Arabic Uthmani Script
- **Source**: Tanzil Project (Hafs Uthmani Script v1.0.2).
- **Standards**: King Fahd Glorious Quran Printing Complex (KFGQPC), Madinah Munawwarah.
- **License**: Creative Commons Attribution 3.0 Unported (CC BY 3.0). Free for non-commercial and commercial distribution with proper attribution.
- **Verification**: Cross-checked against standard Bangladeshi Islamic Foundation Quran prints.

### 1.2 Bengali Translation
- **Source**: Maulana Muhiuddin Khan (Islamic Foundation Bangladesh translation committee).
- **Public Domain**: Widely distributed and accepted as standard open Islamic literature across Bangladesh, used by Tanzil, Quran.com, and Quranwbw.

### 1.3 English Translation
- **Source**: Saheeh International (1997), revised edition.
- **License**: Public Domain / Open Islamic educational fair use.

---

## 2. Hadith Narrations & Gradings

All hadith citations in Musalli carry specific book names, hadith numbers, and scholarly verification grades:
- **Sahih al-Bukhari**: Numbering follows the Muhammad Fuad Abdul Baqi standard system.
- **Sahih Muslim**: Standard numbering verified against Darussalam / Abdul Baqi editions.
- **Sunan Abi Dawud**, **Jami' at-Tirmidhi**, **Sunan an-Nasa'i**, **Sunan Ibn Majah**: Gradings based on classical muhadditheen (Imam at-Tirmidhi, Hafiz Ibn Hajar al-Asqalani, Imam an-Nawawi, Allamah al-Albani).
- **Rule on Weak Narrations**: Weak hadiths (`daif`) are only cited for non-obligatory virtues of actions (*Fadail al-A'mal*) when explicitly permissible under classical hadith criteria, with transparent labeling and grading.

---

## 3. Hanafi Fiqh Rulings

Content follows the Hanafi school (*Madhab*) as practiced by orthodox scholarship in Bangladesh:
- **Al-Hidayah fi Sharh Bidayat al-Mubtadi** by Burhan al-Din al-Marghinani (d. 593 AH).
- **Radd al-Muhtar 'ala al-Durr al-Mukhtar (Hashiyah Ibn Abidin / Shami)** by Allamah Muhammad Amin Ibn Abidin (d. 1252 AH).
- **Badai' al-Sanai' fi Tartib al-Sharai'** by Imam Ala al-Din al-Kasani (d. 587 AH).
- **Al-Fatawa al-Hindiyyah (Fatawa Alamgiri)**, compiled by a commission under Emperor Aurangzeb.
- **Maraqi al-Falah Sharh Nur al-Idah** by Hasan al-Shurunbulali (d. 1069 AH).
- **Ahsan al-Fatawa** & **Fatawa Mahmudiyyah**: Contemporary South Asian Hanafi reference manuals for modern scenarios.

---

## 4. Audio Assets & Licensure

### 4.1 Core Salah Audio (Bundled in App Assets)
- **Path**: `assets/audio/*.mp3`
- **Contents**: Takbir, Sana, Surah Al-Fatihah, Short Surahs (103–114), Ruku Tasbih, Sajda Tasbih, Qawmah, Jalsah, Tashahhud, Durood Ibrahim, Dua Masura, Dua Qunut, Salam, Salatut Tasbih, Eid Takbir, Janaza Sana, Janaza Dua, Wudu Duas, After Salah Dhikr.
- **License**: Public Islamic educational domain. No proprietary copyrights; distributed royalty-free for Salah education.
- **Technical Specifications**: Mono 44.1 kHz, compressed AAC/MP3, optimized for minimal storage footprint on low-end devices.

### 4.2 Full Quran Audio Streaming & On-Demand Download
- **Reciter**: Sheikh Mishary Rashid Alafasy.
- **Source CDN**: MP3Quran.net (`https://server8.mp3quran.net/afs/`) / EveryAyah open API.
- **License**: Freely redistributable Islamic audio for personal, educational, and devotional mobile apps with zero commercial restrictions.
- **Download Management**: Musalli downloads and caches audio files per-surah on user demand into local app cache, allowing offline playback and disk reclamation (clear cache).


import 'dart:async';
import 'dart:io';

/// Download state of a Quran surah recitation.
enum QuranDownloadStatus { notDownloaded, downloading, downloaded, failed }

/// Download state for a single surah.
class SurahDownloadState {
  const SurahDownloadState({
    required this.surahNumber,
    required this.status,
    this.progress = 0.0,
    this.fileSizeBytes = 0,
    this.localFilePath,
  });

  final int surahNumber;
  final QuranDownloadStatus status;
  final double progress;
  final int fileSizeBytes;
  final String? localFilePath;

  String get formattedSize {
    if (fileSizeBytes == 0) return '~1.2 MB';
    if (fileSizeBytes < 1024 * 1024) {
      return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Manages on-demand streaming and offline caching for all 114 Quran Surahs.
class QuranDownloadManager {
  QuranDownloadManager({Directory? cacheDir})
    : _cacheDir = cacheDir ?? Directory.systemTemp;

  final Directory _cacheDir;
  final _states = <int, SurahDownloadState>{};
  final _controller =
      StreamController<Map<int, SurahDownloadState>>.broadcast();

  /// Stream of download states for reactive UI.
  Stream<Map<int, SurahDownloadState>> get statesStream => _controller.stream;

  /// Gets the current download state of a surah.
  SurahDownloadState getState(int surahNumber) {
    if (_states.containsKey(surahNumber)) {
      return _states[surahNumber]!;
    }
    final file = _getSurahFile(surahNumber);
    if (file.existsSync() && file.lengthSync() > 0) {
      final state = SurahDownloadState(
        surahNumber: surahNumber,
        status: QuranDownloadStatus.downloaded,
        progress: 1.0,
        fileSizeBytes: file.lengthSync(),
        localFilePath: file.path,
      );
      _states[surahNumber] = state;
      return state;
    }
    return SurahDownloadState(
      surahNumber: surahNumber,
      status: QuranDownloadStatus.notDownloaded,
    );
  }

  /// CDN URL for Sheikh Mishary Rashid Alafasy recitation.
  String getCdnUrl(int surahNumber) {
    final padded = surahNumber.toString().padLeft(3, '0');
    return 'https://server8.mp3quran.net/afs/$padded.mp3';
  }

  File _getSurahFile(int surahNumber) {
    final padded = surahNumber.toString().padLeft(3, '0');
    return File('${_cacheDir.path}/quran_surah_$padded.mp3');
  }

  /// Deletes the cached audio file to reclaim storage.
  Future<void> deleteSurah(int surahNumber) async {
    final file = _getSurahFile(surahNumber);
    if (file.existsSync()) {
      await file.delete();
    }
    _states[surahNumber] = SurahDownloadState(
      surahNumber: surahNumber,
      status: QuranDownloadStatus.notDownloaded,
    );
    _controller.add(Map.unmodifiable(_states));
  }

  /// Total cached Quran audio bytes across all downloaded surahs.
  int getTotalCachedBytes() {
    int total = 0;
    for (int i = 1; i <= 114; i++) {
      final file = _getSurahFile(i);
      if (file.existsSync()) {
        total += file.lengthSync();
      }
    }
    return total;
  }

  /// Formatted total cached size.
  String get formattedTotalCachedSize {
    final bytes = getTotalCachedBytes();
    if (bytes == 0) return '0 MB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Disposes stream controller.
  void dispose() {
    unawaited(_controller.close());
  }
}

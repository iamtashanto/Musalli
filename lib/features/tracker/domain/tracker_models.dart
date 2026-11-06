enum PrayerStatus {
  ontime('সময়মতো', '✅', 0xFF10B981),
  jamaat('জামাতে', '👥', 0xFF3B82F6),
  qaza('কাযা', '⏳', 0xFFF59E0B),
  missed('বাকি', '⭕', 0xFF94A3B8);

  const PrayerStatus(this.labelBn, this.emoji, this.colorValue);
  final String labelBn;
  final String emoji;
  final int colorValue;
}

class DayPrayerRecord {
  const DayPrayerRecord({
    required this.dateStr,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.witr,
  });

  final String dateStr;
  final PrayerStatus fajr;
  final PrayerStatus dhuhr;
  final PrayerStatus asr;
  final PrayerStatus maghrib;
  final PrayerStatus isha;
  final PrayerStatus witr;

  int get completedCount {
    int count = 0;
    if (fajr == PrayerStatus.ontime || fajr == PrayerStatus.jamaat) count++;
    if (dhuhr == PrayerStatus.ontime || dhuhr == PrayerStatus.jamaat) count++;
    if (asr == PrayerStatus.ontime || asr == PrayerStatus.jamaat) count++;
    if (maghrib == PrayerStatus.ontime || maghrib == PrayerStatus.jamaat) count++;
    if (isha == PrayerStatus.ontime || isha == PrayerStatus.jamaat) count++;
    return count;
  }

  bool get isAllFardCompleted => completedCount == 5;

  Map<String, dynamic> toJson() => {
    'fajr': fajr.name,
    'dhuhr': dhuhr.name,
    'asr': asr.name,
    'maghrib': maghrib.name,
    'isha': isha.name,
    'witr': witr.name,
  };

  factory DayPrayerRecord.fromJson(String dateStr, Map<String, dynamic> json) {
    PrayerStatus parse(String? key) {
      if (key == null) return PrayerStatus.missed;
      return PrayerStatus.values.firstWhere(
        (e) => e.name == key,
        orElse: () => PrayerStatus.missed,
      );
    }

    return DayPrayerRecord(
      dateStr: dateStr,
      fajr: parse(json['fajr'] as String?),
      dhuhr: parse(json['dhuhr'] as String?),
      asr: parse(json['asr'] as String?),
      maghrib: parse(json['maghrib'] as String?),
      isha: parse(json['isha'] as String?),
      witr: parse(json['witr'] as String?),
    );
  }

  static DayPrayerRecord empty(String dateStr) => DayPrayerRecord(
    dateStr: dateStr,
    fajr: PrayerStatus.missed,
    dhuhr: PrayerStatus.missed,
    asr: PrayerStatus.missed,
    maghrib: PrayerStatus.missed,
    isha: PrayerStatus.missed,
    witr: PrayerStatus.missed,
  );
}

class QazaRecord {
  const QazaRecord({
    this.fajr = 0,
    this.dhuhr = 0,
    this.asr = 0,
    this.maghrib = 0,
    this.isha = 0,
    this.witr = 0,
  });

  final int fajr;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;
  final int witr;

  int get total => fajr + dhuhr + asr + maghrib + isha + witr;

  Map<String, dynamic> toJson() => {
    'fajr': fajr,
    'dhuhr': dhuhr,
    'asr': asr,
    'maghrib': maghrib,
    'isha': isha,
    'witr': witr,
  };

  factory QazaRecord.fromJson(Map<String, dynamic> json) {
    return QazaRecord(
      fajr: (json['fajr'] as num?)?.toInt() ?? 0,
      dhuhr: (json['dhuhr'] as num?)?.toInt() ?? 0,
      asr: (json['asr'] as num?)?.toInt() ?? 0,
      maghrib: (json['maghrib'] as num?)?.toInt() ?? 0,
      isha: (json['isha'] as num?)?.toInt() ?? 0,
      witr: (json['witr'] as num?)?.toInt() ?? 0,
    );
  }
}


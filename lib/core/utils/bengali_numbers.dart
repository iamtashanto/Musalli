/// Pure Dart utility for converting ASCII digits (`0-9`) to Bengali numerals
/// (`০-৯`) and formatting numbers/durations according to locale.
class BengaliNumberFormatter {
  const BengaliNumberFormatter._();

  static const List<String> _bengaliDigits = <String>[
    '০',
    '১',
    '২',
    '৩',
    '৪',
    '৫',
    '৬',
    '৭',
    '৮',
    '৯',
  ];

  /// Converts all ASCII digits (`0`–`9`) inside [input] to Bengali digits (`০`–`৯`).
  ///
  /// If [isBangla] is `false`, returns [input] unchanged.
  static String formatString(String input, {bool isBangla = true}) {
    if (!isBangla || input.isEmpty) {
      return input;
    }
    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final code = input.codeUnitAt(i);
      if (code >= 48 && code <= 57) {
        buffer.write(_bengaliDigits[code - 48]);
      } else {
        buffer.writeCharCode(code);
      }
    }
    return buffer.toString();
  }

  /// Formats an integer [value] into Bengali digits when [isBangla] is `true`.
  static String formatInt(int value, {bool isBangla = true, int padLeft = 0}) {
    final raw = padLeft > 0
        ? value.toString().padLeft(padLeft, '0')
        : value.toString();
    return formatString(raw, isBangla: isBangla);
  }

  /// Convenience helper to convert numbers or strings to Bengali digits.
  static String toBengali(dynamic value) {
    if (value == null) return '';
    return formatString(value.toString());
  }

  /// Formats a [Duration] as `MM:SS` or `HH:MM:SS` in Bengali or ASCII digits.
  static String formatDuration(
    Duration duration, {
    bool isBangla = true,
    bool includeHours = false,
  }) {
    final totalSeconds = duration.inSeconds.abs();
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (includeHours || hours > 0) {
      final raw =
          '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
      return formatString(raw, isBangla: isBangla);
    }
    final raw =
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
    return formatString(raw, isBangla: isBangla);
  }

  /// Converts Bengali digits (`০`–`৯`) back into ASCII digits (`0`–`9`).
  static String toAsciiDigits(String input) {
    if (input.isEmpty) return input;
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      // Bengali digit zero '০' is U+09E6 (2534) through '৯' U+09EF (2543).
      if (rune >= 0x09E6 && rune <= 0x09EF) {
        buffer.writeCharCode(48 + (rune - 0x09E6));
      } else {
        buffer.writeCharCode(rune);
      }
    }
    return buffer.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/times/domain/models/prayer_times_models.dart';

class PrayerTimesSettingsSheet extends StatefulWidget {
  const PrayerTimesSettingsSheet({
    required this.initialSettings,
    required this.onSaveSettings,
    super.key,
  });

  final PrayerTimesSettings initialSettings;
  final ValueChanged<PrayerTimesSettings> onSaveSettings;

  @override
  State<PrayerTimesSettingsSheet> createState() =>
      _PrayerTimesSettingsSheetState();
}

class _PrayerTimesSettingsSheetState extends State<PrayerTimesSettingsSheet> {
  late CalculationMethodOption _method;
  late AsrMadhabOption _madhab;
  late HighLatitudeRuleOption _highLat;
  late int _hijriOffset;
  late int _fajrAdj;
  late int _dhuhrAdj;
  late int _asrAdj;
  late int _maghribAdj;
  late int _ishaAdj;

  @override
  void initState() {
    super.initState();
    _method = widget.initialSettings.method;
    _madhab = widget.initialSettings.madhab;
    _highLat = widget.initialSettings.highLatitudeRule;
    _hijriOffset = widget.initialSettings.hijriOffsetDays;
    _fajrAdj = widget.initialSettings.adjustments.fajr;
    _dhuhrAdj = widget.initialSettings.adjustments.dhuhr;
    _asrAdj = widget.initialSettings.adjustments.asr;
    _maghribAdj = widget.initialSettings.adjustments.maghrib;
    _ishaAdj = widget.initialSettings.adjustments.isha;
  }

  void _save() {
    final updated = widget.initialSettings.copyWith(
      method: _method,
      madhab: _madhab,
      highLatitudeRule: _highLat,
      hijriOffsetDays: _hijriOffset,
      adjustments: WaqtAdjustment(
        fajr: _fajrAdj,
        dhuhr: _dhuhrAdj,
        asr: _asrAdj,
        maghrib: _maghribAdj,
        isha: _ishaAdj,
      ),
    );
    widget.onSaveSettings(updated);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      padding: EdgeInsets.all(tokens.spacing.md),
      decoration: BoxDecoration(
        color: colors.backgroundMiddle,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'নামাজের সময় সেটিংস',
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          Expanded(
            child: ListView(
              children: [
                // 1. Madhab
                Text(
                  'আসর নামাজের মাযহাব',
                  style: typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primaryEmerald,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                GlassSegmentedControl<AsrMadhabOption>(
                  segments: const {
                    AsrMadhabOption.hanafi: 'হানাফি (দ্বিগুণ ছায়া)',
                    AsrMadhabOption.shafi: 'শাফিয়ী / মালিকি / হাম্বলি',
                  },
                  selectedValue: _madhab,
                  onValueChanged: (val) => setState(() => _madhab = val),
                ),

                SizedBox(height: tokens.spacing.md),

                // 2. Calculation Method
                Text(
                  'হিসাব পদ্ধতি (Calculation Method)',
                  style: typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primaryEmerald,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                DropdownButtonFormField<CalculationMethodOption>(
                  initialValue: _method,
                  dropdownColor: colors.backgroundMiddle,
                  style: typography.bodyMedium.copyWith(
                    color: colors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colors.surfaceGlassTint,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: tokens.radii.borderMd,
                      borderSide: BorderSide(color: colors.borderSubtle),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: CalculationMethodOption.karachi,
                      child: Text('করাচি (ইসলামিক ফাউন্ডেশন বাংলাদেশ ডিফল্ট)'),
                    ),
                    DropdownMenuItem(
                      value: CalculationMethodOption.muslimWorldLeague,
                      child: Text('মুসলিম ওয়ার্ল্ড লীগ (MWL)'),
                    ),
                    DropdownMenuItem(
                      value: CalculationMethodOption.ummAlQura,
                      child: Text('উম্মুল কুরা (মক্কা, সৌদি আরব)'),
                    ),
                    DropdownMenuItem(
                      value: CalculationMethodOption.egyptian,
                      child: Text('মিশরীয় জরিপ কর্তৃপক্ষ'),
                    ),
                    DropdownMenuItem(
                      value: CalculationMethodOption.dubai,
                      child: Text('দুবাই (সংযুক্ত আরব আমিরাত)'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _method = val);
                  },
                ),

                SizedBox(height: tokens.spacing.md),

                // 3. Hijri Date Offset
                Text(
                  'চাঁদ দেখার উপর ভিত্তি করে হিজরি তারিখ সমন্বয়',
                  style: typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primaryEmerald,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                GlassSegmentedControl<int>(
                  segments: const {
                    -1: '-১ দিন',
                    0: 'স্বাভাবিক (০)',
                    1: '+১ দিন',
                  },
                  selectedValue: _hijriOffset,
                  onValueChanged: (val) => setState(() => _hijriOffset = val),
                ),

                SizedBox(height: tokens.spacing.md),

                // 4. Minute Adjustments
                Text(
                  'ওয়াক্তভিত্তিক মিনিট সমন্বয় (লোকাল মসজিদ মিলানোর জন্য)',
                  style: typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primaryEmerald,
                  ),
                ),
                SizedBox(height: tokens.spacing.xs),
                _MinuteAdjRow(
                  nameBn: 'ফজর',
                  value: _fajrAdj,
                  onChanged: (v) => setState(() => _fajrAdj = v),
                ),
                _MinuteAdjRow(
                  nameBn: 'যোহর',
                  value: _dhuhrAdj,
                  onChanged: (v) => setState(() => _dhuhrAdj = v),
                ),
                _MinuteAdjRow(
                  nameBn: 'আসর',
                  value: _asrAdj,
                  onChanged: (v) => setState(() => _asrAdj = v),
                ),
                _MinuteAdjRow(
                  nameBn: 'মাগরিব',
                  value: _maghribAdj,
                  onChanged: (v) => setState(() => _maghribAdj = v),
                ),
                _MinuteAdjRow(
                  nameBn: 'এশা',
                  value: _ishaAdj,
                  onChanged: (v) => setState(() => _ishaAdj = v),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.sm),

          GlassButton(
            label: 'সেটিংস সংরক্ষণ করুন',
            icon: Icons.check_rounded,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

class _MinuteAdjRow extends StatelessWidget {
  const _MinuteAdjRow({
    required this.nameBn,
    required this.value,
    required this.onChanged,
  });

  final String nameBn;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final valStr = value == 0
        ? '০ মি.'
        : value > 0
        ? '+${BengaliNumbers.toBengali(value)} মি.'
        : '${BengaliNumbers.toBengali(value)} মি.';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameBn,
            style: typography.bodyMedium.copyWith(color: colors.textPrimary),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline_rounded),
                color: colors.textSecondary,
                onPressed: () => onChanged(value - 1),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  valStr,
                  textAlign: TextAlign.center,
                  style: typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.goldAccent,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded),
                color: colors.textSecondary,
                onPressed: () => onChanged(value + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

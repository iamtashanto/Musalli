import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/features/hifz/data/hifz_repository.dart';
import 'package:musalli/features/hifz/domain/hifz_models.dart';
import 'package:musalli/shared/content/surah.dart';

class HifzPracticeScreen extends ConsumerStatefulWidget {
  const HifzPracticeScreen({required this.surahNumber, super.key});
  final int surahNumber;

  @override
  ConsumerState<HifzPracticeScreen> createState() => _HifzPracticeScreenState();
}

class _HifzPracticeScreenState extends ConsumerState<HifzPracticeScreen> {
  HifzHideMode _hideMode = HifzHideMode.none;
  int _repeatTarget = 3;
  int _currentRepeat = 0;
  bool _isAudioPlaying = false;
  AudioPlayer? _player;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  Future<void> _playSurahAudio() async {
    try {
      setState(() => _isAudioPlaying = true);
      final assetPath = 'assets/audio/surah-${widget.surahNumber}.mp3';
      await _player?.setAsset(assetPath);
      await _player?.play();
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isAudioPlaying = false);
    }
  }

  String _formatHiddenArabic(String arabic) {
    if (_revealed || _hideMode == HifzHideMode.none) return arabic;

    switch (_hideMode) {
      case HifzHideMode.fullyHidden:
        return '•••••••••••••••••••••••••• (আলতো চেপে দেখুন)';
      case HifzHideMode.hideEveryOther:
        final words = arabic.split(' ');
        return words.asMap().entries.map((e) => e.key.isEven ? e.value : '••••').join(' ');
      case HifzHideMode.firstLettersOnly:
        final words = arabic.split(' ');
        return words.map((w) => w.isNotEmpty ? '${w[0]}••' : '').join(' ');
      case HifzHideMode.none:
        return arabic;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final allSurahs = ref.watch(allSurahsListProvider).value ?? [];
    final surah = allSurahs.firstWhere(
      (s) => s.number == widget.surahNumber,
      orElse: () => ContentSurah(
        id: 'surah-${widget.surahNumber}',
        number: widget.surahNumber,
        nameAr: 'سورة',
        nameBn: 'সূরা ${BengaliNumbers.toBengali(widget.surahNumber)}',
        nameEn: 'Surah ${widget.surahNumber}',
        ayahCount: 7,
        revelationType: 'meccan',
        verses: const [],
      ),
    );

    final repo = ref.watch(hifzRepositoryProvider);

    return Scaffold(
      backgroundColor: colors.backgroundStart,
      appBar: AppBar(
        title: Text('হিফজ মোড: ${surah.nameBn}', style: typography.titleLarge),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Hide Mode Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: HifzHideMode.values.map((mode) {
                final isSelected = mode == _hideMode;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(mode.labelBn, style: typography.label.copyWith(
                      color: isSelected ? Colors.white : colors.textPrimary,
                    )),
                    selected: isSelected,
                    selectedColor: const Color(0xFF10B981),
                    backgroundColor: colors.surfaceGlassTint,
                    onSelected: (val) {
                      if (val) setState(() {
                        _hideMode = mode;
                        _revealed = false;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: tokens.spacing.md),

          // Ayahs Display
          ...surah.verses.map((ayah) {
            return Padding(
              padding: EdgeInsets.only(bottom: tokens.spacing.sm),
              child: GestureDetector(
                onTap: () {
                  setState(() => _revealed = !_revealed);
                  unawaited(HapticFeedback.lightImpact());
                },
                child: GlassCard(
                  padding: EdgeInsets.all(tokens.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.15),
                              borderRadius: tokens.radii.borderSm,
                            ),
                            child: Text('আয়াত ${BengaliNumbers.toBengali(ayah.numberInSurah)}', style: typography.label.copyWith(color: const Color(0xFF10B981))),
                          ),
                          if (_hideMode != HifzHideMode.none)
                            Text(_revealed ? 'লুকান 👁️' : 'দেখুন 🙈', style: typography.label),
                        ],
                      ),
                      SizedBox(height: tokens.spacing.sm),
                      Text(
                        _formatHiddenArabic(ayah.textAr),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: typography.arabicLarge.copyWith(color: colors.textPrimary),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      Text(ayah.textBn, style: typography.bodyMedium),
                    ],
                  ),
                ),
              ),
            );
          }),

          SizedBox(height: tokens.spacing.md),

          // Audio Repeat Loop Controls
          GlassCard(
            padding: EdgeInsets.all(tokens.spacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('অডিও পুনরাবৃত্তি (${BengaliNumbers.toBengali(_repeatTarget)} বার)', style: typography.titleMedium),
                    Text('সহজে মুখস্থের জন্য প্রতি আয়াত বারংবার শুনুন', style: typography.label),
                  ],
                ),
                FloatingActionButton.small(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  onPressed: _isAudioPlaying ? () => _player?.stop() : _playSurahAudio,
                  child: Icon(_isAudioPlaying ? Icons.stop : Icons.play_arrow),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),

          // Spaced Repetition Self Check
          Text('আত্মমূল্যায়ন (Spaced Repetition)', style: typography.titleMedium),
          SizedBox(height: tokens.spacing.xs),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    unawaited(HapticFeedback.lightImpact());
                    final rec = HifzItemRecord.createNew(widget.surahNumber).markReviewed(success: false);
                    await repo.saveRecord(rec);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('পরবর্তী রিভিউ আগামীকাল নির্ধারণ করা হলো')),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEF4444),
                    side: const BorderSide(color: Color(0xFFEF4444)),
                    padding: EdgeInsets.symmetric(vertical: tokens.spacing.sm),
                    shape: RoundedRectangleBorder(borderRadius: tokens.radii.borderMd),
                  ),
                  child: const Text('আবার অনুশীলন 🔄'),
                ),
              ),
              SizedBox(width: tokens.spacing.sm),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    unawaited(HapticFeedback.lightImpact());
                    final rec = HifzItemRecord.createNew(widget.surahNumber).markReviewed(success: true);
                    await repo.saveRecord(rec);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('মাশাআল্লাহ! পরবর্তী রিভিশন ${BengaliNumbers.toBengali(rec.intervalDays)} দিন পর')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: tokens.spacing.sm),
                    shape: RoundedRectangleBorder(borderRadius: tokens.radii.borderMd),
                  ),
                  child: const Text('পেরেছি! ✅'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

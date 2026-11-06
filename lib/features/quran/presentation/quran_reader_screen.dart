import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/shared/content/content.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reading theme modes for the Quran reader.
enum QuranReaderTheme { system, sepia, night }

/// Premium Quran Reader Screen with Uthmani script, adjustable font size,
/// Bangla translation toggle, reading modes (sepia/night), and last-read resume.
class QuranReaderScreen extends ConsumerStatefulWidget {
  const QuranReaderScreen({required this.surahNumber, super.key});

  final int surahNumber;

  @override
  ConsumerState<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends ConsumerState<QuranReaderScreen> {
  double _arabicFontSize = 24.0;
  bool _showTranslation = true;
  QuranReaderTheme _readerTheme = QuranReaderTheme.system;
  int? _activeAudioAyahIndex;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _saveLastRead();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _saveLastRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_read_surah', widget.surahNumber);
    } catch (_) {
      // Non-fatal if SharedPreferences is restricted.
    }
  }

  void _onToggleTranslation() {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _showTranslation = !_showTranslation);
  }

  void _onCycleTheme() {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _readerTheme = switch (_readerTheme) {
        QuranReaderTheme.system => QuranReaderTheme.sepia,
        QuranReaderTheme.sepia => QuranReaderTheme.night,
        QuranReaderTheme.night => QuranReaderTheme.system,
      };
    });
  }

  void _onPlayAyahAudio(int index) {
    unawaited(HapticFeedback.lightImpact());
    setState(() {
      if (_activeAudioAyahIndex == index) {
        _activeAudioAyahIndex = null;
      } else {
        _activeAudioAyahIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final allSurahsAsync = ref.watch(allSurahsListProvider);
    final detailedSurahsAsync = ref.watch(surahsListProvider);

    // Resolve reader background & text colors based on selected theme
    final (
      Color readerBg,
      Color textColor,
      Color arabicColor,
    ) = switch (_readerTheme) {
      QuranReaderTheme.sepia => (
        const Color(0xFFFBF0D9),
        const Color(0xFF433422),
        const Color(0xFF1E3A2F),
      ),
      QuranReaderTheme.night => (
        const Color(0xFF0A0F0D),
        const Color(0xFFE2E8F0),
        colors.primaryEmerald,
      ),
      QuranReaderTheme.system => (
        Colors.transparent,
        colors.textPrimary,
        colors.primaryEmerald,
      ),
    };

    return Scaffold(
      backgroundColor: readerBg,
      body: allSurahsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('ত্রুটি: $err')),
        data: (surahSummaries) {
          final summary = surahSummaries.cast<QuranSurahSummary?>().firstWhere(
            (s) => s?.number == widget.surahNumber,
            orElse: () => null,
          );

          if (summary == null) {
            return Center(
              child: EmptyState(
                title: 'সূরা পাওয়া যায়নি',
                message: 'সূরা নম্বর ${widget.surahNumber} খুঁজে পাওয়া যায়নি।',
              ),
            );
          }

          // Check if we have detailed line-by-line ayahs in detailedSurahsAsync
          final detailedSurah = detailedSurahsAsync.value
              ?.cast<ContentSurah?>()
              .firstWhere(
                (ContentSurah? s) => s?.number == widget.surahNumber,
                orElse: () => null,
              );

          final List<ContentRecitation> ayahs =
              detailedSurah?.ayahs ?? const <ContentRecitation>[];

          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              // Glass Top Bar with Controls
              GlassSliverAppBar(
                title: 'সূরা ${summary.nameBangla}',
                actions: <Widget>[
                  // Theme switch button
                  IconButton(
                    icon: Icon(
                      _readerTheme == QuranReaderTheme.sepia
                          ? Icons.auto_stories_rounded
                          : _readerTheme == QuranReaderTheme.night
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: colors.primaryEmerald,
                    ),
                    tooltip: 'থিম পরিবর্তন',
                    onPressed: _onCycleTheme,
                  ),
                  // Translation toggle button
                  IconButton(
                    icon: Icon(
                      _showTranslation
                          ? Icons.translate_rounded
                          : Icons.g_translate_rounded,
                      color: _showTranslation
                          ? colors.primaryEmerald
                          : colors.textSecondary,
                    ),
                    tooltip: 'অর্থ চালু/বন্ধ',
                    onPressed: _onToggleTranslation,
                  ),
                ],
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: tokens.spacing.md,
                  vertical: tokens.spacing.sm,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Surah Header Banner
                    GlassCard(
                      borderGlow: true,
                      padding: EdgeInsets.all(tokens.spacing.lg),
                      child: Column(
                        children: <Widget>[
                          Text(
                            summary.nameArabic,
                            style: typography.arabicLarge.copyWith(
                              fontSize: 32,
                              color: arabicColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'সূরা ${summary.nameBangla} (${summary.nameEnglish})',
                            style: typography.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'অবতীর্ণ: ${summary.revelationType} • মোট আয়াত: ${BengaliNumberFormatter.toBengali(summary.totalAyah)}',
                            style: typography.label.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),

                          // Bismillah (except for Surah At-Tawbah #9)
                          if (widget.surahNumber != 9) ...[
                            const Divider(height: 24),
                            Text(
                              'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                              textAlign: TextAlign.center,
                              style: typography.arabicLarge.copyWith(
                                fontSize: _arabicFontSize + 2,
                                color: arabicColor,
                              ),
                            ),
                            if (_showTranslation) ...[
                              const SizedBox(height: 4),
                              Text(
                                'পরম করুণাময়, অসীম দয়ালু আল্লাহর নামে শুরু করছি।',
                                textAlign: TextAlign.center,
                                style: typography.bodyMedium.copyWith(
                                  color: colors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // Font Size Slider
                    GlassCard(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.format_size_rounded,
                            size: 18,
                            color: colors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'আরবি ফন্ট সাইজ:',
                            style: typography.label.copyWith(color: textColor),
                          ),
                          Expanded(
                            child: Slider(
                              value: _arabicFontSize,
                              min: 18,
                              max: 38,
                              divisions: 10,
                              activeColor: colors.primaryEmerald,
                              inactiveColor: colors.borderSubtle,
                              onChanged: (val) {
                                setState(() => _arabicFontSize = val);
                              },
                            ),
                          ),
                          Text(
                            '${BengaliNumberFormatter.toBengali(_arabicFontSize.round())}pt',
                            style: typography.label.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primaryEmerald,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: tokens.spacing.md),

                    // Ayah List
                    if (ayahs.isNotEmpty) ...[
                      ...ayahs.asMap().entries.map((
                        MapEntry<int, ContentRecitation> entry,
                      ) {
                        final int idx = entry.key;
                        final ContentRecitation ayah = entry.value;
                        final isPlaying = _activeAudioAyahIndex == idx;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassCard(
                            borderGlow: isPlaying,
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // Top row: Ayah badge and audio button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: colors.primaryEmerald.withValues(
                                          alpha: 0.15,
                                        ),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: colors.primaryEmerald
                                              .withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          BengaliNumberFormatter.toBengali(
                                            idx + 1,
                                          ),
                                          style: typography.label.copyWith(
                                            color: colors.primaryEmerald,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause_circle_filled_rounded
                                            : Icons.play_circle_outline_rounded,
                                        color: colors.primaryEmerald,
                                        size: 24,
                                      ),
                                      tooltip: 'অডিও শুনুন',
                                      onPressed: () => _onPlayAyahAudio(idx),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Arabic Text
                                Text(
                                  ayah.arabic,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: typography.arabicLarge.copyWith(
                                    fontSize: _arabicFontSize,
                                    height: 1.8,
                                    color: isPlaying
                                        ? colors.primaryEmerald
                                        : arabicColor,
                                  ),
                                ),

                                // Bangla Pronunciation (Uccharon)
                                const SizedBox(height: 6),
                                Text(
                                  ayah.uccharonBn,
                                  style: typography.bodyMedium.copyWith(
                                    color: colors.textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),

                                // Bangla Meaning
                                if (_showTranslation) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    ayah.meaningBn,
                                    style: typography.bodyMedium.copyWith(
                                      color: textColor,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                    ] else ...[
                      // Generic Ayahs display for remaining surahs
                      ...List.generate(summary.totalAyah, (i) {
                        final ayahNum = i + 1;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GlassCard(
                            padding: EdgeInsets.all(tokens.spacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: colors.primaryEmerald.withValues(
                                          alpha: 0.12,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          BengaliNumberFormatter.toBengali(
                                            ayahNum,
                                          ),
                                          style: typography.label.copyWith(
                                            color: colors.primaryEmerald,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.volume_up_outlined,
                                      size: 20,
                                      color: colors.textSecondary,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'আয়াত নম্বর ${BengaliNumberFormatter.toBengali(ayahNum)}',
                                  style: typography.bodyMedium.copyWith(
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],

                    SizedBox(height: tokens.spacing.xl),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

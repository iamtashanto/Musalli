import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';
import 'package:musalli/shared/models/four_layer_text.dart';

/// Semantic badge displaying Hanafi fiqh ruling status (`fard`, `wajib`,
/// `sunnah`, `nafl`, `special`).
class RulingBadge extends StatelessWidget {
  /// Creates a [RulingBadge].
  const RulingBadge({
    required this.category,
    this.customLabel,
    this.isBangla = true,
    super.key,
  });

  /// Ruling category.
  final RulingCategory category;

  /// Optional custom label override.
  final String? customLabel;

  /// Whether to render the default label in Bangla (`true`) or English (`false`).
  final bool isBangla;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    final (
      Color fg,
      Color bg,
      String defaultBn,
      String defaultEn,
    ) = switch (category) {
      RulingCategory.fard => (
        colors.fardColor,
        colors.fardContainer,
        'ফরজ',
        'Fard',
      ),
      RulingCategory.wajib => (
        colors.wajibColor,
        colors.wajibContainer,
        'ওয়াজিব',
        'Wajib',
      ),
      RulingCategory.sunnah => (
        colors.sunnahColor,
        colors.sunnahContainer,
        'সুন্নাত',
        'Sunnah',
      ),
      RulingCategory.nafl => (
        colors.naflColor,
        colors.naflContainer,
        'নফল',
        'Nafl',
      ),
      RulingCategory.special => (
        colors.goldAccent,
        colors.goldSoft,
        'বিশেষ',
        'Special',
      ),
    };

    final label = customLabel ?? (isBangla ? defaultBn : defaultEn);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.sm,
        vertical: tokens.spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.88),
        borderRadius: tokens.radii.borderFull,
        border: Border.all(color: fg.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: tokens.typography.label.copyWith(
                color: fg,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact citation chip displaying a Quranic, Hadith, or Fiqh reference
/// (e.g. `"সহীহ বুখারী ৭৫৭"`) with optional authenticity grade badge.
class ReferenceChip extends StatelessWidget {
  /// Creates a [ReferenceChip].
  const ReferenceChip({
    required this.citation,
    this.grade,
    this.isBangla = true,
    super.key,
  });

  /// Citation text (e.g. `"সহীহ বুখারী ৭৫৭"`).
  final String citation;

  /// Optional hadith authenticity grade.
  final HadithGrade? grade;

  /// Whether grade labels should be rendered in Bangla.
  final bool isBangla;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    final gradeText = switch (grade) {
      HadithGrade.sahih => isBangla ? 'সহীহ' : 'Sahih',
      HadithGrade.hasan => isBangla ? 'হাসান' : 'Hasan',
      HadithGrade.daif => isBangla ? 'যঈফ' : 'Daif',
      null => null,
    };

    final gradeColor = switch (grade) {
      HadithGrade.sahih => colors.success,
      HadithGrade.hasan => colors.sunnahColor,
      HadithGrade.daif => colors.warning,
      null => colors.primaryEmerald,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.sm,
        vertical: tokens.spacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceGlassTint.withValues(alpha: 0.16),
        borderRadius: tokens.radii.borderFull,
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.menu_book_rounded, size: 14, color: colors.primaryEmerald),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              citation,
              style: tokens.typography.label.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
          if (gradeText != null) ...<Widget>[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: gradeColor.withValues(alpha: 0.18),
                borderRadius: tokens.radii.borderFull,
              ),
              child: Text(
                gradeText,
                style: tokens.typography.label.copyWith(
                  fontSize: 10,
                  color: gradeColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Visual variants for [Callout].
enum CalloutVariant {
  /// Helpful tip or sunnah guidance.
  tip,

  /// Important caution or makruh/invalidating warning.
  warning,

  /// Scholarly note or madhab comparison reference.
  reference,
}

/// Highlighted callout box (`tip`, `warning`, `reference`) for fiqh notes,
/// gender differences, and scholarly reminders.
class Callout extends StatelessWidget {
  /// Creates a [Callout].
  const Callout({
    required this.title,
    required this.message,
    this.variant = CalloutVariant.tip,
    super.key,
  });

  /// Callout title.
  final String title;

  /// Callout body text.
  final String message;

  /// Callout visual variant.
  final CalloutVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    final (Color accent, IconData icon) = switch (variant) {
      CalloutVariant.tip => (
        colors.primaryEmerald,
        Icons.lightbulb_outline_rounded,
      ),
      CalloutVariant.warning => (colors.warning, Icons.warning_amber_rounded),
      CalloutVariant.reference => (
        colors.sunnahColor,
        Icons.auto_stories_outlined,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: tokens.radii.borderMd,
        border: Border.all(color: accent.withValues(alpha: 0.38)),
      ),
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: accent, size: 22),
            SizedBox(width: tokens.spacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: tokens.typography.titleMedium.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: tokens.spacing.xxs),
                  Text(
                    message,
                    style: tokens.typography.bodyMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Consistent section header with title, optional subtitle, and trailing action.
class SectionHeader extends StatelessWidget {
  /// Creates a [SectionHeader].
  const SectionHeader({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionTap,
    super.key,
  });

  /// Section title.
  final String title;

  /// Optional subtitle.
  final String? subtitle;

  /// Optional trailing action label.
  final String? actionLabel;

  /// Callback when trailing action is tapped.
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: tokens.typography.titleLarge),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: 2),
                Text(subtitle!, style: tokens.typography.bodyMedium),
              ],
            ],
          ),
        ),
        if (actionLabel != null && onActionTap != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(
              actionLabel!,
              style: tokens.typography.label.copyWith(
                color: colors.primaryEmerald,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

/// Circular progress ring indicator with centered percentage or custom widget.
class ProgressRing extends StatelessWidget {
  /// Creates a [ProgressRing].
  const ProgressRing({
    required this.progress,
    this.size = 64,
    this.strokeWidth = 6,
    this.centerChild,
    this.isBangla = true,
    super.key,
  });

  /// Progress fraction (`0.0` to `1.0`).
  final double progress;

  /// Ring outer diameter in logical pixels.
  final double size;

  /// Ring stroke width.
  final double strokeWidth;

  /// Optional custom center widget (defaults to formatted percentage).
  final Widget? centerChild;

  /// Whether default percentage uses Bangla digits.
  final bool isBangla;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final clamped = progress.clamp(0.0, 1.0);
    final percent = (clamped * 100).round();

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ProgressRingPainter(
          progress: clamped,
          trackColor: colors.borderSubtle,
          activeColor: colors.primaryEmerald,
          goldColor: colors.goldAccent,
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.all(strokeWidth + 2),
              child:
                  centerChild ??
                  Text(
                    '${BengaliNumberFormatter.formatInt(percent, isBangla: isBangla)}%',
                    style: tokens.typography.label.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  const _ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.activeColor,
    required this.goldColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color activeColor;
  final Color goldColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final activePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: <Color>[activeColor, goldColor, activeColor],
      ).createShader(rect);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.trackColor != trackColor;
  }
}

/// Friendly empty state card with icon, title, subtitle, and optional CTA.
class EmptyState extends StatelessWidget {
  /// Creates an [EmptyState].
  const EmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Empty state title.
  final String title;

  /// Explanatory message.
  final String message;

  /// Leading icon.
  final IconData icon;

  /// Optional action button label.
  final String? actionLabel;

  /// Optional action callback.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return GlassCard(
      padding: EdgeInsets.all(tokens.spacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.primaryEmerald.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: colors.primaryEmerald),
          ),
          SizedBox(height: tokens.spacing.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: tokens.typography.titleMedium,
          ),
          SizedBox(height: tokens.spacing.xs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: tokens.typography.bodyMedium,
          ),
          if (actionLabel != null && onAction != null) ...<Widget>[
            SizedBox(height: tokens.spacing.md),
            GlassButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}

/// Shimmer / skeleton placeholder loader that respects reduced-motion settings.
class GlassShimmerLoader extends StatefulWidget {
  /// Creates a [GlassShimmerLoader].
  const GlassShimmerLoader({
    this.height = 72,
    this.width = double.infinity,
    this.radius,
    super.key,
  });

  /// Skeleton box height.
  final double height;

  /// Skeleton box width.
  final double width;

  /// Corner radius override.
  final double? radius;

  @override
  State<GlassShimmerLoader> createState() => _GlassShimmerLoaderState();
}

class _GlassShimmerLoaderState extends State<GlassShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.isReducedMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final borderRadius = BorderRadius.circular(
      widget.radius ?? tokens.radii.md,
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? _) {
        final slide = -1.0 + (2.0 * _controller.value);
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: colors.borderSubtle),
            gradient: LinearGradient(
              begin: Alignment(slide - 1, 0),
              end: Alignment(slide + 1, 0),
              colors: <Color>[
                colors.surfaceGlassTint.withValues(alpha: 0.12),
                colors.primaryEmerald.withValues(alpha: 0.22),
                colors.surfaceGlassTint.withValues(alpha: 0.12),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Rich 4-layer Islamic recitation component (`ArabicBlock`).
///
/// Supports:
/// - Toggleable visibility for each of the 4 layers: Uthmani Arabic,
///   Bangla pronunciation (`uccharonBn`), Banglish, and meaning (`meaningBn` / `meaningEn`).
/// - Interactive Arabic font-size control (`-` / `+`).
/// - Audio play/pause button with progress bar.
/// - Word/token highlight driven by an optional [highlightWordIndexStream] or
///   [activeWordIndex].
/// - Copy & share actions with haptic feedback.
class ArabicBlock extends StatefulWidget {
  /// Creates an [ArabicBlock].
  const ArabicBlock({
    required this.data,
    this.isBanglaLocale = true,
    this.initialShowArabic = true,
    this.initialShowUccharon = true,
    this.initialShowBanglish = false,
    this.initialShowMeaning = true,
    this.activeWordIndex,
    this.highlightWordIndexStream,
    this.onPlayAudio,
    this.onShare,
    super.key,
  });

  /// Canonical 4-layer recitation data.
  final FourLayerText data;

  /// Whether the active UI language is Bangla (`true`) or English (`false`).
  final bool isBanglaLocale;

  /// Initial visibility of the Arabic layer.
  final bool initialShowArabic;

  /// Initial visibility of the Bangla pronunciation (`uccharon`) layer.
  final bool initialShowUccharon;

  /// Initial visibility of the Banglish transliteration layer.
  final bool initialShowBanglish;

  /// Initial visibility of the translation/meaning layer.
  final bool initialShowMeaning;

  /// Optional synchronous word index to highlight in the Arabic text.
  final int? activeWordIndex;

  /// Optional stream of word indices for real-time audio sync highlighting.
  final Stream<int>? highlightWordIndexStream;

  /// Optional callback when the audio play button is pressed.
  final VoidCallback? onPlayAudio;

  /// Optional share callback.
  final ValueChanged<String>? onShare;

  @override
  State<ArabicBlock> createState() => _ArabicBlockState();
}

class _ArabicBlockState extends State<ArabicBlock> {
  late bool _showArabic;
  late bool _showUccharon;
  late bool _showBanglish;
  late bool _showMeaning;
  double _arabicFontScale = 1;
  bool _isPlayingSimulated = false;
  double _audioProgress = 0;
  bool _copied = false;
  Timer? _simulatedAudioTimer;

  @override
  void initState() {
    super.initState();
    _showArabic = widget.initialShowArabic;
    _showUccharon = widget.initialShowUccharon;
    _showBanglish = widget.initialShowBanglish;
    _showMeaning = widget.initialShowMeaning;
  }

  @override
  void dispose() {
    _simulatedAudioTimer?.cancel();
    super.dispose();
  }

  void _toggleAudioPlayback() {
    unawaited(HapticFeedback.lightImpact());
    widget.onPlayAudio?.call();

    if (_isPlayingSimulated) {
      _simulatedAudioTimer?.cancel();
      setState(() => _isPlayingSimulated = false);
      return;
    }

    setState(() {
      _isPlayingSimulated = true;
      if (_audioProgress >= 1.0) {
        _audioProgress = 0;
      }
    });

    _simulatedAudioTimer?.cancel();
    _simulatedAudioTimer = Timer.periodic(const Duration(milliseconds: 120), (
      Timer timer,
    ) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _audioProgress = (_audioProgress + 0.08).clamp(0.0, 1.0);
        if (_audioProgress >= 1.0) {
          _isPlayingSimulated = false;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _copyToClipboard() async {
    await HapticFeedback.selectionClick();
    final meaning = widget.isBanglaLocale
        ? widget.data.meaningBn
        : widget.data.meaningEn;
    final payload =
        '${widget.data.titleBn}\n'
        '${widget.data.arabic}\n'
        'উচ্চারণ: ${widget.data.uccharonBn}\n'
        'অর্থ: $meaning';
    await Clipboard.setData(ClipboardData(text: payload));
    if (!mounted) return;
    setState(() => _copied = true);
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final words = widget.data.arabic
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList(growable: false);

    final title = widget.isBanglaLocale
        ? widget.data.titleBn
        : widget.data.titleEn;
    final meaning = widget.isBanglaLocale
        ? widget.data.meaningBn
        : widget.data.meaningEn;
    final refText = widget.isBanglaLocale
        ? widget.data.referenceTextBn
        : (widget.data.referenceTextEn ?? widget.data.referenceTextBn);

    return GlassCard(
      padding: EdgeInsets.all(tokens.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header: Title + Audio & Font Size Controls
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: tokens.spacing.xs,
            runSpacing: tokens.spacing.xs,
            children: <Widget>[
              Text(
                title,
                style: tokens.typography.titleMedium.copyWith(
                  color: colors.primaryEmerald,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _arabicFontScale = (_arabicFontScale - 0.1).clamp(
                          0.8,
                          1.5,
                        );
                      });
                    },
                    icon: const Icon(Icons.text_decrease_rounded, size: 18),
                    tooltip: 'Decrease Arabic font size',
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _arabicFontScale = (_arabicFontScale + 0.1).clamp(
                          0.8,
                          1.5,
                        );
                      });
                    },
                    icon: const Icon(Icons.text_increase_rounded, size: 18),
                    tooltip: 'Increase Arabic font size',
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: _copyToClipboard,
                    icon: Icon(
                      _copied ? Icons.check_rounded : Icons.copy_rounded,
                      size: 18,
                      color: _copied ? colors.success : colors.textSecondary,
                    ),
                    tooltip: 'Copy recitation',
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: _toggleAudioPlayback,
                    icon: Icon(
                      _isPlayingSimulated
                          ? Icons.pause_circle_filled_rounded
                          : Icons.play_circle_fill_rounded,
                      size: 28,
                      color: colors.primaryEmerald,
                    ),
                    tooltip: _isPlayingSimulated ? 'Pause audio' : 'Play audio',
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),

          // Audio Progress Bar when active
          if (_isPlayingSimulated || _audioProgress > 0) ...<Widget>[
            SizedBox(height: tokens.spacing.xs),
            ClipRRect(
              borderRadius: tokens.radii.borderFull,
              child: LinearProgressIndicator(
                value: _audioProgress,
                minHeight: 4,
                backgroundColor: colors.borderSubtle,
                valueColor: AlwaysStoppedAnimation<Color>(
                  colors.primaryEmerald,
                ),
              ),
            ),
          ],

          SizedBox(height: tokens.spacing.xs),

          // Layer Toggle Chips
          Wrap(
            spacing: tokens.spacing.xs,
            runSpacing: tokens.spacing.xs,
            children: <Widget>[
              GlassChip(
                label: widget.isBanglaLocale ? 'আরবি' : 'Arabic',
                selected: _showArabic,
                onTap: () => setState(() => _showArabic = !_showArabic),
              ),
              GlassChip(
                label: widget.isBanglaLocale ? 'উচ্চারণ' : 'Uccharon',
                selected: _showUccharon,
                onTap: () => setState(() => _showUccharon = !_showUccharon),
              ),
              GlassChip(
                label: 'Banglish',
                selected: _showBanglish,
                onTap: () => setState(() => _showBanglish = !_showBanglish),
              ),
              GlassChip(
                label: widget.isBanglaLocale ? 'অর্থ' : 'Meaning',
                selected: _showMeaning,
                onTap: () => setState(() => _showMeaning = !_showMeaning),
              ),
            ],
          ),

          // Layer 1: Uthmani Arabic (RTL) with word highlight stream
          if (_showArabic) ...<Widget>[
            SizedBox(height: tokens.spacing.md),
            StreamBuilder<int>(
              stream: widget.highlightWordIndexStream,
              initialData: widget.activeWordIndex,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                final highlightedIndex =
                    snapshot.data ??
                    (_isPlayingSimulated && words.isNotEmpty
                        ? ((_audioProgress * words.length).floor().clamp(
                            0,
                            words.length - 1,
                          ))
                        : null);

                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.all(tokens.spacing.md),
                    decoration: BoxDecoration(
                      color: colors.primaryEmerald.withValues(alpha: 0.08),
                      borderRadius: tokens.radii.borderMd,
                      border: Border.all(color: colors.borderSubtle),
                    ),
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        style: tokens.typography.arabicLarge.copyWith(
                          fontSize:
                              tokens.typography.arabicLarge.fontSize! *
                              _arabicFontScale,
                        ),
                        children: List<InlineSpan>.generate(words.length, (
                          int i,
                        ) {
                          final isHighlighted = highlightedIndex == i;
                          return TextSpan(
                            text:
                                '${words[i]}${i < words.length - 1 ? ' ' : ''}',
                            style: isHighlighted
                                ? TextStyle(
                                    color: colors.goldAccent,
                                    backgroundColor: colors.goldAccent
                                        .withValues(alpha: 0.18),
                                  )
                                : null,
                          );
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],

          // Layer 2: Bangla Pronunciation (Uccharon)
          if (_showUccharon) ...<Widget>[
            SizedBox(height: tokens.spacing.sm),
            _LayerSection(
              badgeLabel: widget.isBanglaLocale ? 'উচ্চারণ' : 'Pronunciation',
              text: widget.data.uccharonBn,
              accentColor: colors.primaryEmerald,
            ),
          ],

          // Layer 3: Banglish Transliteration
          if (_showBanglish) ...<Widget>[
            SizedBox(height: tokens.spacing.sm),
            _LayerSection(
              badgeLabel: 'Banglish',
              text: widget.data.banglish,
              accentColor: colors.sunnahColor,
            ),
          ],

          // Layer 4: Meaning (Bangla / English)
          if (_showMeaning) ...<Widget>[
            SizedBox(height: tokens.spacing.sm),
            _LayerSection(
              badgeLabel: widget.isBanglaLocale ? 'অর্থ' : 'Meaning',
              text: meaning,
              accentColor: colors.goldAccent,
            ),
          ],

          if (refText != null) ...<Widget>[
            SizedBox(height: tokens.spacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: ReferenceChip(
                citation: refText,
                grade: widget.data.grade,
                isBangla: widget.isBanglaLocale,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LayerSection extends StatelessWidget {
  const _LayerSection({
    required this.badgeLabel,
    required this.text,
    required this.accentColor,
  });

  final String badgeLabel;
  final String text;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          badgeLabel,
          style: tokens.typography.label.copyWith(
            color: accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: tokens.typography.bodyLarge.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

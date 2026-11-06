import 'package:flutter/material.dart';

/// Semantic and surface color tokens for Musalli in light and dark modes.
@immutable
class MusalliColorTokens {
  /// Creates a [MusalliColorTokens] palette.
  const MusalliColorTokens({
    required this.brightness,
    required this.primaryEmerald,
    required this.emeraldLight,
    required this.emeraldDark,
    required this.tealDeep,
    required this.goldAccent,
    required this.goldSoft,
    required this.backgroundStart,
    required this.backgroundMiddle,
    required this.backgroundEnd,
    required this.surfaceGlassTint,
    required this.surfaceLowRamFallback,
    required this.borderHighlight,
    required this.borderSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.fardColor,
    required this.fardContainer,
    required this.wajibColor,
    required this.wajibContainer,
    required this.sunnahColor,
    required this.sunnahContainer,
    required this.naflColor,
    required this.naflContainer,
    required this.success,
    required this.warning,
    required this.error,
  });

  /// Light palette inspired by soft morning courtyard light over emerald & pearl.
  factory MusalliColorTokens.light() => const MusalliColorTokens(
        brightness: Brightness.light,
        primaryEmerald: Color(0xFF059669),
        emeraldLight: Color(0xFF34D399),
        emeraldDark: Color(0xFF065F46),
        tealDeep: Color(0xFF0F766E),
        goldAccent: Color(0xFFD97706),
        goldSoft: Color(0xFFFEF3C7),
        backgroundStart: Color(0xFFECFDF5),
        backgroundMiddle: Color(0xFFF0FDFA),
        backgroundEnd: Color(0xFFF8FAFC),
        surfaceGlassTint: Color(0xFFFFFFFF),
        surfaceLowRamFallback: Color(0xF5FFFFFF),
        borderHighlight: Color(0xCCFFFFFF),
        borderSubtle: Color(0x26059669),
        textPrimary: Color(0xFF062C22),
        textSecondary: Color(0xFF335C50),
        textMuted: Color(0xFF648279),
        fardColor: Color(0xFF047857),
        fardContainer: Color(0xFFD1FAE5),
        wajibColor: Color(0xFFB45309),
        wajibContainer: Color(0xFFFEF3C7),
        sunnahColor: Color(0xFF0369A1),
        sunnahContainer: Color(0xFFE0F2FE),
        naflColor: Color(0xFF6D28D9),
        naflContainer: Color(0xFFEDE9FE),
        success: Color(0xFF059669),
        warning: Color(0xFFD97706),
        error: Color(0xFFDC2626),
      );

  /// Dark palette inspired by serene Tahajjud night emerald and warm gold lantern accents.
  factory MusalliColorTokens.dark() => const MusalliColorTokens(
        brightness: Brightness.dark,
        primaryEmerald: Color(0xFF10B981),
        emeraldLight: Color(0xFF6EE7B7),
        emeraldDark: Color(0xFF047857),
        tealDeep: Color(0xFF115E59),
        goldAccent: Color(0xFFFBBF24),
        goldSoft: Color(0xFF451A03),
        backgroundStart: Color(0xFF021E1A),
        backgroundMiddle: Color(0xFF042F2E),
        backgroundEnd: Color(0xFF061A17),
        surfaceGlassTint: Color(0xFF0B3B34),
        surfaceLowRamFallback: Color(0xF2082B26),
        borderHighlight: Color(0x406EE7B7),
        borderSubtle: Color(0x2434D399),
        textPrimary: Color(0xFFECFDF5),
        textSecondary: Color(0xFFA7F3D0),
        textMuted: Color(0xFF6EE7B7),
        fardColor: Color(0xFF34D399),
        fardContainer: Color(0xFF064E3B),
        wajibColor: Color(0xFFFBBF24),
        wajibContainer: Color(0xFF451A03),
        sunnahColor: Color(0xFF38BDF8),
        sunnahContainer: Color(0xFF0C4A6E),
        naflColor: Color(0xFFC084FC),
        naflContainer: Color(0xFF3B0764),
        success: Color(0xFF34D399),
        warning: Color(0xFFFBBF24),
        error: Color(0xFFF87171),
      );

  /// Theme brightness.
  final Brightness brightness;

  /// Primary emerald brand color (`#059669` in light mode).
  final Color primaryEmerald;

  /// Lighter emerald tint.
  final Color emeraldLight;

  /// Darker emerald shade.
  final Color emeraldDark;

  /// Deep teal secondary accent.
  final Color tealDeep;

  /// Warm gold highlight accent (used sparingly).
  final Color goldAccent;

  /// Soft gold container fill.
  final Color goldSoft;

  /// Top-left gradient background color.
  final Color backgroundStart;

  /// Center gradient background color.
  final Color backgroundMiddle;

  /// Bottom-right gradient background color.
  final Color backgroundEnd;

  /// Base tint for frosted glass surfaces.
  final Color surfaceGlassTint;

  /// Opaque/translucent fallback surface when `GlassQuality.low` is active.
  final Color surfaceLowRamFallback;

  /// Top-left specular highlight border color for glass surfaces.
  final Color borderHighlight;

  /// Bottom-right subtle border color for glass surfaces.
  final Color borderSubtle;

  /// Primary high-contrast body and heading color.
  final Color textPrimary;

  /// Secondary readable text color.
  final Color textSecondary;

  /// Muted caption/label text color.
  final Color textMuted;

  /// Semantic Fard (ফরজ) foreground color.
  final Color fardColor;

  /// Semantic Fard (ফরজ) container fill.
  final Color fardContainer;

  /// Semantic Wajib (ওয়াজিব) foreground color.
  final Color wajibColor;

  /// Semantic Wajib (ওয়াজিব) container fill.
  final Color wajibContainer;

  /// Semantic Sunnah (সুন্নাত) foreground color.
  final Color sunnahColor;

  /// Semantic Sunnah (সুন্নাত) container fill.
  final Color sunnahContainer;

  /// Semantic Nafl (নফল) foreground color.
  final Color naflColor;

  /// Semantic Nafl (নফল) container fill.
  final Color naflContainer;

  /// Success state color.
  final Color success;

  /// Warning state color.
  final Color warning;

  /// Error state color.
  final Color error;

  /// Linearly interpolates between two [MusalliColorTokens] palettes.
  static MusalliColorTokens lerp(
    MusalliColorTokens a,
    MusalliColorTokens b,
    double t,
  ) {
    return MusalliColorTokens(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      primaryEmerald: Color.lerp(a.primaryEmerald, b.primaryEmerald, t)!,
      emeraldLight: Color.lerp(a.emeraldLight, b.emeraldLight, t)!,
      emeraldDark: Color.lerp(a.emeraldDark, b.emeraldDark, t)!,
      tealDeep: Color.lerp(a.tealDeep, b.tealDeep, t)!,
      goldAccent: Color.lerp(a.goldAccent, b.goldAccent, t)!,
      goldSoft: Color.lerp(a.goldSoft, b.goldSoft, t)!,
      backgroundStart: Color.lerp(a.backgroundStart, b.backgroundStart, t)!,
      backgroundMiddle: Color.lerp(a.backgroundMiddle, b.backgroundMiddle, t)!,
      backgroundEnd: Color.lerp(a.backgroundEnd, b.backgroundEnd, t)!,
      surfaceGlassTint: Color.lerp(a.surfaceGlassTint, b.surfaceGlassTint, t)!,
      surfaceLowRamFallback:
          Color.lerp(a.surfaceLowRamFallback, b.surfaceLowRamFallback, t)!,
      borderHighlight: Color.lerp(a.borderHighlight, b.borderHighlight, t)!,
      borderSubtle: Color.lerp(a.borderSubtle, b.borderSubtle, t)!,
      textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t)!,
      textSecondary: Color.lerp(a.textSecondary, b.textSecondary, t)!,
      textMuted: Color.lerp(a.textMuted, b.textMuted, t)!,
      fardColor: Color.lerp(a.fardColor, b.fardColor, t)!,
      fardContainer: Color.lerp(a.fardContainer, b.fardContainer, t)!,
      wajibColor: Color.lerp(a.wajibColor, b.wajibColor, t)!,
      wajibContainer: Color.lerp(a.wajibContainer, b.wajibContainer, t)!,
      sunnahColor: Color.lerp(a.sunnahColor, b.sunnahColor, t)!,
      sunnahContainer: Color.lerp(a.sunnahContainer, b.sunnahContainer, t)!,
      naflColor: Color.lerp(a.naflColor, b.naflColor, t)!,
      naflContainer: Color.lerp(a.naflContainer, b.naflContainer, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
      error: Color.lerp(a.error, b.error, t)!,
    );
  }
}

/// Typography tokens pairing Hind Siliguri (Bangla & Latin) and Amiri (Uthmani Arabic).
@immutable
class MusalliTypographyTokens {
  /// Creates a [MusalliTypographyTokens] scale for the given [textPrimary] and [textSecondary].
  factory MusalliTypographyTokens.fromColors({
    required Color textPrimary,
    required Color textSecondary,
  }) {
    const banglaFamily = 'HindSiliguri';
    const arabicFamily = 'Amiri';

    return MusalliTypographyTokens(
      display: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 30,
        height: 1.28,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 22,
        height: 1.32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 17,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 16,
        height: 1.55,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      label: TextStyle(
        fontFamily: banglaFamily,
        fontSize: 12,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: textSecondary,
      ),
      arabicLarge: TextStyle(
        fontFamily: arabicFamily,
        fontSize: 28,
        height: 1.95,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      arabicBody: TextStyle(
        fontFamily: arabicFamily,
        fontSize: 23,
        height: 1.85,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
    );
  }

  /// Creates a [MusalliTypographyTokens] instance.
  const MusalliTypographyTokens({
    required this.display,
    required this.titleLarge,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.label,
    required this.arabicLarge,
    required this.arabicBody,
  });

  /// Large display headline (30sp).
  final TextStyle display;

  /// Section or screen title (22sp).
  final TextStyle titleLarge;

  /// Card or subsection title (17sp).
  final TextStyle titleMedium;

  /// Primary Bangla/English body copy (16sp).
  final TextStyle bodyLarge;

  /// Secondary body copy (14sp).
  final TextStyle bodyMedium;

  /// Compact badge/chip/tab label (12sp).
  final TextStyle label;

  /// Large Uthmani Arabic display text (28sp, 1.95 line height).
  final TextStyle arabicLarge;

  /// Standard Uthmani Arabic recitation text (23sp, 1.85 line height).
  final TextStyle arabicBody;

  /// Linearly interpolates between two [MusalliTypographyTokens].
  static MusalliTypographyTokens lerp(
    MusalliTypographyTokens a,
    MusalliTypographyTokens b,
    double t,
  ) {
    return MusalliTypographyTokens(
      display: TextStyle.lerp(a.display, b.display, t)!,
      titleLarge: TextStyle.lerp(a.titleLarge, b.titleLarge, t)!,
      titleMedium: TextStyle.lerp(a.titleMedium, b.titleMedium, t)!,
      bodyLarge: TextStyle.lerp(a.bodyLarge, b.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(a.bodyMedium, b.bodyMedium, t)!,
      label: TextStyle.lerp(a.label, b.label, t)!,
      arabicLarge: TextStyle.lerp(a.arabicLarge, b.arabicLarge, t)!,
      arabicBody: TextStyle.lerp(a.arabicBody, b.arabicBody, t)!,
    );
  }
}

/// 4pt spatial grid tokens.
@immutable
class MusalliSpacingTokens {
  /// Creates constant 4pt grid spacing tokens.
  const MusalliSpacingTokens();

  /// 4pt extra-extra-small spacing.
  final double xxs = 4;

  /// 8pt extra-small spacing.
  final double xs = 8;

  /// 12pt small spacing.
  final double sm = 12;

  /// 16pt medium default spacing.
  final double md = 16;

  /// 20pt large-medium spacing.
  final double lg = 20;

  /// 24pt extra-large spacing.
  final double xl = 24;

  /// 32pt 2x extra-large spacing.
  final double xxl = 32;

  /// 48pt section spacing.
  final double xxxl = 48;
}

/// Corner radius tokens (`12`, `20`, `28`, `full`).
@immutable
class MusalliRadiusTokens {
  /// Creates constant radius tokens.
  const MusalliRadiusTokens();

  /// Small radius (12pt) for chips, inputs, and buttons.
  final double sm = 12;

  /// Medium radius (20pt) for standard GlassCards and tiles.
  final double md = 20;

  /// Large radius (28pt) for sheets, dialogs, and hero cards.
  final double lg = 28;

  /// Full pill radius (999pt).
  final double full = 999;

  /// BorderRadius helper for [sm].
  BorderRadius get borderSm => BorderRadius.circular(sm);

  /// BorderRadius helper for [md].
  BorderRadius get borderMd => BorderRadius.circular(md);

  /// BorderRadius helper for [lg].
  BorderRadius get borderLg => BorderRadius.circular(lg);

  /// BorderRadius helper for [full].
  BorderRadius get borderFull => BorderRadius.circular(full);
}

/// Motion duration, curve, and spring physics tokens.
@immutable
class MusalliMotionTokens {
  /// Creates constant motion tokens.
  const MusalliMotionTokens();

  /// Fast micro-interaction duration (150ms).
  final Duration fast = const Duration(milliseconds: 150);

  /// Standard UI transition duration (250ms).
  final Duration normal = const Duration(milliseconds: 250);

  /// Emphasized route/modal transition duration (400ms).
  final Duration emphasized = const Duration(milliseconds: 400);

  /// Slow ambient or figure transition duration (600ms).
  final Duration slow = const Duration(milliseconds: 600);

  /// Standard Material 3 / iOS ease curve.
  final Curve standardCurve = Curves.easeOutCubic;

  /// Emphasized decelerate curve for route and sheet transitions.
  final Curve emphasizedCurve = Curves.easeInOutCubicEmphasized;

  /// Snappy spring curve for sliding indicators and press release.
  final Curve springCurve = Curves.elasticOut;

  /// Spring physics description for interactive sliding pills and press release.
  SpringDescription get interactiveSpring => const SpringDescription(
        mass: 1,
        stiffness: 380,
        damping: 28,
      );
}

/// Unified [ThemeExtension] exposing all Musalli design tokens on `Theme.of(context)`.
@immutable
class MusalliDesignTokens extends ThemeExtension<MusalliDesignTokens> {
  /// Creates a [MusalliDesignTokens] extension.
  const MusalliDesignTokens({
    required this.colors,
    required this.typography,
    this.spacing = const MusalliSpacingTokens(),
    this.radii = const MusalliRadiusTokens(),
    this.motion = const MusalliMotionTokens(),
  });

  /// Creates the light theme token set.
  factory MusalliDesignTokens.light() {
    final colors = MusalliColorTokens.light();
    return MusalliDesignTokens(
      colors: colors,
      typography: MusalliTypographyTokens.fromColors(
        textPrimary: colors.textPrimary,
        textSecondary: colors.textSecondary,
      ),
    );
  }

  /// Creates the dark theme token set.
  factory MusalliDesignTokens.dark() {
    final colors = MusalliColorTokens.dark();
    return MusalliDesignTokens(
      colors: colors,
      typography: MusalliTypographyTokens.fromColors(
        textPrimary: colors.textPrimary,
        textSecondary: colors.textSecondary,
      ),
    );
  }

  /// Color tokens.
  final MusalliColorTokens colors;

  /// Typography tokens.
  final MusalliTypographyTokens typography;

  /// 4pt grid spacing tokens.
  final MusalliSpacingTokens spacing;

  /// Corner radius tokens.
  final MusalliRadiusTokens radii;

  /// Animation duration, curve, and spring tokens.
  final MusalliMotionTokens motion;

  /// Soft elevation shadow for floating glass surfaces.
  List<BoxShadow> get glassShadows => <BoxShadow>[
        BoxShadow(
          color: colors.brightness == Brightness.dark
              ? const Color(0x66000000)
              : const Color(0x14047857),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];

  @override
  MusalliDesignTokens copyWith({
    MusalliColorTokens? colors,
    MusalliTypographyTokens? typography,
    MusalliSpacingTokens? spacing,
    MusalliRadiusTokens? radii,
    MusalliMotionTokens? motion,
  }) {
    return MusalliDesignTokens(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radii: radii ?? this.radii,
      motion: motion ?? this.motion,
    );
  }

  @override
  MusalliDesignTokens lerp(
    covariant ThemeExtension<MusalliDesignTokens>? other,
    double t,
  ) {
    if (other is! MusalliDesignTokens) return this;
    return MusalliDesignTokens(
      colors: MusalliColorTokens.lerp(colors, other.colors, t),
      typography: MusalliTypographyTokens.lerp(typography, other.typography, t),
      spacing: spacing,
      radii: radii,
      motion: motion,
    );
  }
}

/// Convenience extension on [BuildContext] to access [MusalliDesignTokens]
/// and reduced-motion accessibility status.
extension MusalliThemeContext on BuildContext {
  /// Returns the active [MusalliDesignTokens] from the nearest [Theme].
  MusalliDesignTokens get tokens =>
      Theme.of(this).extension<MusalliDesignTokens>() ??
      MusalliDesignTokens.light();

  /// Returns `true` when the user has enabled OS-level reduced motion /
  /// disabled animations.
  bool get isReducedMotion =>
      MediaQuery.maybeDisableAnimationsOf(this) ?? false;
}

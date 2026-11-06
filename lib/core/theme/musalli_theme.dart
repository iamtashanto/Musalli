import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Builds the Material 3 [ThemeData] paired with [MusalliDesignTokens] for
/// light and dark modes.
class MusalliTheme {
  const MusalliTheme._();

  /// Light [ThemeData] with emerald primary and glass tokens.
  static ThemeData light() {
    final tokens = MusalliDesignTokens.light();
    final colors = tokens.colors;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: colors.primaryEmerald,
      primary: colors.primaryEmerald,
      secondary: colors.tealDeep,
      tertiary: colors.goldAccent,
      surface: colors.backgroundMiddle,
      error: colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: 'HindSiliguri',
      scaffoldBackgroundColor: colors.backgroundEnd,
      extensions: <ThemeExtension<dynamic>>[tokens],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: tokens.typography.titleLarge,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Dark [ThemeData] with deep night emerald and gold accents.
  static ThemeData dark() {
    final tokens = MusalliDesignTokens.dark();
    final colors = tokens.colors;

    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: colors.primaryEmerald,
      primary: colors.primaryEmerald,
      secondary: colors.tealDeep,
      tertiary: colors.goldAccent,
      surface: colors.backgroundMiddle,
      error: colors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: 'HindSiliguri',
      scaffoldBackgroundColor: colors.backgroundEnd,
      extensions: <ThemeExtension<dynamic>>[tokens],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: tokens.typography.titleLarge,
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}

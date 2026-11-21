import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Mirrors the Figma text styles (title/*, body/*) onto Flutter's Material
/// text roles. Sizes and line heights are the Figma values times [scale].
///
///   Figma            -> Flutter role
///   title/3xl  48/48 -> displayLarge
///   title/2xl  40/48 -> displayMedium
///   title/xl   32/40 -> displaySmall, headlineLarge
///   title/large 24/32 -> headlineMedium, titleLarge
///   title/medium 18/24 -> headlineSmall, titleMedium
///   title/base 16/24 -> titleSmall
///   body/base  16/24 -> bodyLarge
///   body/xmd   14/16 -> bodyMedium
///   body/small 12/16 -> bodySmall
///   title/xmd  14/16 -> labelLarge
///   title/small 12/16 -> labelMedium
///   title/xsmall 10/16 -> labelSmall
/// Figma styles with no Flutter role live in [AppTextStyles].
abstract final class MovifyTextTheme {
  static TextStyle style(
    double size,
    FontWeight weight,
    double lineHeight, {
    double scale = 1,
  }) => GoogleFonts.montserrat(
    fontSize: size * scale,
    fontWeight: weight,
    height: lineHeight / size,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextTheme build({double scale = 1}) {
    TextStyle b(double s, double lh) =>
        style(s, FontWeight.w700, lh, scale: scale);
    TextStyle r(double s, double lh) =>
        style(s, FontWeight.w400, lh, scale: scale);

    return TextTheme(
      displayLarge: b(48, 48),
      displayMedium: b(40, 48),
      displaySmall: b(32, 40),
      headlineLarge: b(32, 40),
      headlineMedium: b(24, 32),
      headlineSmall: b(18, 24),
      titleLarge: b(24, 32),
      titleMedium: b(18, 24),
      titleSmall: b(16, 24),
      bodyLarge: r(16, 24),
      bodyMedium: r(14, 16),
      bodySmall: r(12, 16),
      labelLarge: b(14, 16),
      labelMedium: b(12, 16),
      labelSmall: b(10, 16),
    );
  }
}

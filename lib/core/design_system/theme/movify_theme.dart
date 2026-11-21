import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movify/core/design_system/tokens/app_tokens.dart';

/// Token-driven theme. Lives next to the old `AppTheme`; nothing uses it
/// until `CustomMaterialApp` is pointed at it.
abstract final class MovifyTheme {
  static ThemeData dark() {
    const c = AppColors.dark;

    final scheme = ColorScheme.dark(
      primary: c.primaryDefault,
      onPrimary: c.textPrimary,
      primaryContainer: c.primaryDefault,
      onPrimaryContainer: c.textPrimary,
      secondary: c.buttonSecondary,
      onSecondary: c.textPrimary,
      surface: c.surfacePrimary,
      onSurface: c.textPrimary,
      onSurfaceVariant: c.textContrast,
      surfaceContainerHighest: c.surfaceGenre,
      outline: c.surfaceDivider,
      outlineVariant: c.surfaceDivider,
      error: c.surfaceError,
      onError: c.textPrimary,
      inverseSurface: c.textPrimary,
      onInverseSurface: c.textInvert,
    );

    final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: c.surfacePrimary,
      canvasColor: c.surfacePrimary,
      cardColor: c.surfaceGenre,
      dividerColor: c.surfaceDivider,
      dividerTheme: DividerThemeData(color: c.surfaceDivider, thickness: 1),
      dialogTheme: DialogThemeData(backgroundColor: c.surfaceBottomSheet),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surfaceBottomSheet,
        modalBackgroundColor: c.surfaceBottomSheet,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.surfacePrimary,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      iconTheme: IconThemeData(color: c.iconPrimary),
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme).apply(
        bodyColor: c.textPrimary,
        displayColor: c.textPrimary,
      ),
      extensions: const <ThemeExtension<dynamic>>[AppColors.dark],
    );
  }
}

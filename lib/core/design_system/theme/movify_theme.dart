import 'package:flutter/material.dart';
import 'package:movify/core/design_system/primitives/brand_colors.dart';
import 'package:movify/core/design_system/theme/movify_text_theme.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/app_text_styles.dart';

/// Token-driven themes. They live next to the old `AppTheme`; nothing uses
/// them until `CustomMaterialApp` is pointed at them.
abstract final class MovifyTheme {
  /// [textScale] comes from `TextScale.of(context)`; 1.0 matches Figma.
  static ThemeData light({double textScale = 1}) =>
      _build(AppColors.light, Brightness.light, textScale);
  static ThemeData dark({double textScale = 1}) =>
      _build(AppColors.dark, Brightness.dark, textScale);

  static ThemeData _build(
    AppColors c,
    Brightness brightness,
    double textScale,
  ) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.primaryDefault,
      onPrimary: BrandColors.neutral0,
      primaryContainer: c.primaryDefault,
      onPrimaryContainer: BrandColors.neutral0,
      secondary: c.buttonSecondary,
      onSecondary: BrandColors.neutral0,
      surface: c.surfacePrimary,
      onSurface: c.textPrimary,
      onSurfaceVariant: c.textContrast,
      surfaceContainerHighest: c.surfaceGenre,
      outline: c.surfaceDivider,
      outlineVariant: c.surfaceDivider,
      error: c.surfaceError,
      onError: BrandColors.neutral0,
      inverseSurface: c.textPrimary,
      onInverseSurface: c.textInvert,
    );

    final base = ThemeData(brightness: brightness, useMaterial3: true);

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: c.surfacePrimary,
      canvasColor: c.surfacePrimary,
      cardColor: c.surfaceContainerTonal,
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
      textTheme: MovifyTextTheme.build(scale: textScale).apply(
        bodyColor: c.textPrimary,
        displayColor: c.textPrimary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        c,
        AppTextStyles.build(scale: textScale),
      ],
    );
  }
}

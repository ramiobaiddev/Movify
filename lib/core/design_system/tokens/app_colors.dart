// Semantic colours. Mirrors the Figma "tokens" collection (light, dark).
// Source of truth: tokens.json next to this file. Edit both together.
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/primitives/brand_colors.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary50,
    required this.primary100,
    required this.primary200,
    required this.primary300,
    required this.primary400,
    required this.primaryDefault,
    required this.primary600,
    required this.primary700,
    required this.primary800,
    required this.primary900,
    required this.textPrimary,
    required this.textSecondary,
    required this.textContrast,
    required this.textInvert,
    required this.textOnImage,
    required this.surfacePrimary,
    required this.surfaceSuccess,
    required this.surfaceError,
    required this.surfaceCommentCard,
    required this.surfaceEpisodeNumber,
    required this.surfaceBottomSheet,
    required this.surfaceGenre,
    required this.surfaceGenreSelected,
    required this.surfaceDivider,
    required this.surfaceProfileRow,
    required this.surfaceProfileRowPressed,
    required this.surfaceBlurBackground,
    required this.surfaceReminderButton,
    required this.surfaceContainerTonal,
    required this.surfacePlaceholderImage,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconDefault,
    required this.iconInvert,
    required this.iconContrast,
    required this.buttonPrimary,
    required this.buttonPrimaryHover,
    required this.buttonPrimaryFocused,
    required this.buttonPrimaryPressed,
    required this.buttonDisabled,
    required this.buttonSecondary,
    required this.buttonSecondaryHover,
    required this.buttonSecondaryPressed,
    required this.buttonSecondaryFocused,
    required this.buttonAccent,
    required this.buttonAccentPressed,
    required this.buttonAccentHovered,
    required this.statusWarning,
    required this.statusWarningText,
  });

  final Color primary50;
  final Color primary100;
  final Color primary200;
  final Color primary300;
  final Color primary400;
  final Color primaryDefault;
  final Color primary600;
  final Color primary700;
  final Color primary800;
  final Color primary900;
  final Color textPrimary;
  final Color textSecondary;
  final Color textContrast;
  final Color textInvert;
  final Color textOnImage;
  final Color surfacePrimary;
  final Color surfaceSuccess;
  final Color surfaceError;
  final Color surfaceCommentCard;
  final Color surfaceEpisodeNumber;
  final Color surfaceBottomSheet;
  final Color surfaceGenre;
  final Color surfaceGenreSelected;
  final Color surfaceDivider;
  final Color surfaceProfileRow;
  final Color surfaceProfileRowPressed;
  final Color surfaceBlurBackground;
  final Color surfaceReminderButton;
  final Color surfaceContainerTonal;
  final Color surfacePlaceholderImage;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconDefault;
  final Color iconInvert;
  final Color iconContrast;
  final Color buttonPrimary;
  final Color buttonPrimaryHover;
  final Color buttonPrimaryFocused;
  final Color buttonPrimaryPressed;
  final Color buttonDisabled;
  final Color buttonSecondary;
  final Color buttonSecondaryHover;
  final Color buttonSecondaryPressed;
  final Color buttonSecondaryFocused;
  final Color buttonAccent;
  final Color buttonAccentPressed;
  final Color buttonAccentHovered;
  final Color statusWarning;
  final Color statusWarningText;

  static const AppColors light = AppColors(
    primary50: BrandColors.blue50,
    primary100: BrandColors.blue100,
    primary200: BrandColors.blue200,
    primary300: BrandColors.blue300,
    primary400: BrandColors.blue400,
    primaryDefault: BrandColors.blue500,
    primary600: BrandColors.blue600,
    primary700: BrandColors.blue700,
    primary800: BrandColors.blue800,
    primary900: BrandColors.blue900,
    textPrimary: BrandColors.neutral800,
    textSecondary: BrandColors.blue500,
    textContrast: BrandColors.neutral650,
    textInvert: BrandColors.neutral0,
    textOnImage: BrandColors.neutral0,
    surfacePrimary: BrandColors.neutral0,
    surfaceSuccess: BrandColors.green300,
    surfaceError: BrandColors.red500,
    surfaceCommentCard: BrandColors.neutral500,
    surfaceEpisodeNumber: Color(0x80000000),
    surfaceBottomSheet: BrandColors.neutral300,
    surfaceGenre: BrandColors.neutral500,
    surfaceGenreSelected: BrandColors.blue500,
    surfaceDivider: BrandColors.neutral400,
    surfaceProfileRow: BrandColors.neutral300,
    surfaceProfileRowPressed: BrandColors.neutral500,
    surfaceBlurBackground: Color(0x80000000),
    surfaceReminderButton: BrandColors.blue50,
    surfaceContainerTonal: BrandColors.neutral300,
    surfacePlaceholderImage: BrandColors.neutral700,
    iconPrimary: BrandColors.neutral750,
    iconSecondary: BrandColors.blue500,
    iconDefault: BrandColors.neutral0,
    iconInvert: BrandColors.neutral200,
    iconContrast: BrandColors.neutral650,
    buttonPrimary: BrandColors.blue500,
    buttonPrimaryHover: BrandColors.blue700,
    buttonPrimaryFocused: BrandColors.blue700,
    buttonPrimaryPressed: BrandColors.blue600,
    buttonDisabled: BrandColors.neutral300,
    buttonSecondary: BrandColors.neutral600,
    buttonSecondaryHover: BrandColors.neutral300,
    buttonSecondaryPressed: BrandColors.neutral500,
    buttonSecondaryFocused: BrandColors.neutral300,
    buttonAccent: BrandColors.orangeDefault,
    buttonAccentPressed: BrandColors.orange600,
    buttonAccentHovered: BrandColors.orange700,
    statusWarning: BrandColors.amber500,
    statusWarningText: BrandColors.amber700,
  );

  static const AppColors dark = AppColors(
    primary50: BrandColors.blue50,
    primary100: BrandColors.blue100,
    primary200: BrandColors.blue200,
    primary300: BrandColors.blue300,
    primary400: BrandColors.blue400,
    primaryDefault: BrandColors.blue500,
    primary600: BrandColors.blue600,
    primary700: BrandColors.blue700,
    primary800: BrandColors.blue800,
    primary900: BrandColors.blue900,
    textPrimary: BrandColors.neutral0,
    textSecondary: BrandColors.blue300,
    textContrast: BrandColors.neutral500,
    textInvert: BrandColors.neutral800,
    textOnImage: BrandColors.neutral0,
    surfacePrimary: BrandColors.neutral800,
    surfaceSuccess: BrandColors.green300,
    surfaceError: BrandColors.red500,
    surfaceCommentCard: BrandColors.neutral700,
    surfaceEpisodeNumber: Color(0x99FFFFFF),
    surfaceBottomSheet: BrandColors.blue950,
    surfaceGenre: BrandColors.neutral750,
    surfaceGenreSelected: BrandColors.blue500,
    surfaceDivider: BrandColors.neutral700,
    surfaceProfileRow: BrandColors.blue950,
    surfaceProfileRowPressed: BrandColors.blue800,
    surfaceBlurBackground: Color(0x80000000),
    surfaceReminderButton: BrandColors.blueTint,
    surfaceContainerTonal: BrandColors.neutral750,
    surfacePlaceholderImage: BrandColors.neutral500,
    iconPrimary: BrandColors.neutral0,
    iconSecondary: BrandColors.blue300,
    iconDefault: BrandColors.neutral0,
    iconInvert: BrandColors.neutral750,
    iconContrast: BrandColors.neutral500,
    buttonPrimary: BrandColors.blue500,
    buttonPrimaryHover: BrandColors.blue400,
    buttonPrimaryFocused: BrandColors.blue600,
    buttonPrimaryPressed: BrandColors.blue300,
    buttonDisabled: BrandColors.neutral750,
    buttonSecondary: BrandColors.neutral700,
    buttonSecondaryHover: BrandColors.neutral600,
    buttonSecondaryPressed: BrandColors.neutral600,
    buttonSecondaryFocused: BrandColors.neutral600,
    buttonAccent: BrandColors.orange800,
    buttonAccentPressed: BrandColors.orange300,
    buttonAccentHovered: BrandColors.orange400,
    statusWarning: BrandColors.amber500,
    statusWarningText: BrandColors.amber500,
  );

  @override
  AppColors copyWith({
    Color? primary50,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primaryDefault,
    Color? primary600,
    Color? primary700,
    Color? primary800,
    Color? primary900,
    Color? textPrimary,
    Color? textSecondary,
    Color? textContrast,
    Color? textInvert,
    Color? textOnImage,
    Color? surfacePrimary,
    Color? surfaceSuccess,
    Color? surfaceError,
    Color? surfaceCommentCard,
    Color? surfaceEpisodeNumber,
    Color? surfaceBottomSheet,
    Color? surfaceGenre,
    Color? surfaceGenreSelected,
    Color? surfaceDivider,
    Color? surfaceProfileRow,
    Color? surfaceProfileRowPressed,
    Color? surfaceBlurBackground,
    Color? surfaceReminderButton,
    Color? surfaceContainerTonal,
    Color? surfacePlaceholderImage,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? iconDefault,
    Color? iconInvert,
    Color? iconContrast,
    Color? buttonPrimary,
    Color? buttonPrimaryHover,
    Color? buttonPrimaryFocused,
    Color? buttonPrimaryPressed,
    Color? buttonDisabled,
    Color? buttonSecondary,
    Color? buttonSecondaryHover,
    Color? buttonSecondaryPressed,
    Color? buttonSecondaryFocused,
    Color? buttonAccent,
    Color? buttonAccentPressed,
    Color? buttonAccentHovered,
    Color? statusWarning,
    Color? statusWarningText,
  }) => AppColors(
    primary50: primary50 ?? this.primary50,
    primary100: primary100 ?? this.primary100,
    primary200: primary200 ?? this.primary200,
    primary300: primary300 ?? this.primary300,
    primary400: primary400 ?? this.primary400,
    primaryDefault: primaryDefault ?? this.primaryDefault,
    primary600: primary600 ?? this.primary600,
    primary700: primary700 ?? this.primary700,
    primary800: primary800 ?? this.primary800,
    primary900: primary900 ?? this.primary900,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textContrast: textContrast ?? this.textContrast,
    textInvert: textInvert ?? this.textInvert,
    textOnImage: textOnImage ?? this.textOnImage,
    surfacePrimary: surfacePrimary ?? this.surfacePrimary,
    surfaceSuccess: surfaceSuccess ?? this.surfaceSuccess,
    surfaceError: surfaceError ?? this.surfaceError,
    surfaceCommentCard: surfaceCommentCard ?? this.surfaceCommentCard,
    surfaceEpisodeNumber: surfaceEpisodeNumber ?? this.surfaceEpisodeNumber,
    surfaceBottomSheet: surfaceBottomSheet ?? this.surfaceBottomSheet,
    surfaceGenre: surfaceGenre ?? this.surfaceGenre,
    surfaceGenreSelected: surfaceGenreSelected ?? this.surfaceGenreSelected,
    surfaceDivider: surfaceDivider ?? this.surfaceDivider,
    surfaceProfileRow: surfaceProfileRow ?? this.surfaceProfileRow,
    surfaceProfileRowPressed:
        surfaceProfileRowPressed ?? this.surfaceProfileRowPressed,
    surfaceBlurBackground: surfaceBlurBackground ?? this.surfaceBlurBackground,
    surfaceReminderButton: surfaceReminderButton ?? this.surfaceReminderButton,
    surfaceContainerTonal: surfaceContainerTonal ?? this.surfaceContainerTonal,
    surfacePlaceholderImage:
        surfacePlaceholderImage ?? this.surfacePlaceholderImage,
    iconPrimary: iconPrimary ?? this.iconPrimary,
    iconSecondary: iconSecondary ?? this.iconSecondary,
    iconDefault: iconDefault ?? this.iconDefault,
    iconInvert: iconInvert ?? this.iconInvert,
    iconContrast: iconContrast ?? this.iconContrast,
    buttonPrimary: buttonPrimary ?? this.buttonPrimary,
    buttonPrimaryHover: buttonPrimaryHover ?? this.buttonPrimaryHover,
    buttonPrimaryFocused: buttonPrimaryFocused ?? this.buttonPrimaryFocused,
    buttonPrimaryPressed: buttonPrimaryPressed ?? this.buttonPrimaryPressed,
    buttonDisabled: buttonDisabled ?? this.buttonDisabled,
    buttonSecondary: buttonSecondary ?? this.buttonSecondary,
    buttonSecondaryHover: buttonSecondaryHover ?? this.buttonSecondaryHover,
    buttonSecondaryPressed:
        buttonSecondaryPressed ?? this.buttonSecondaryPressed,
    buttonSecondaryFocused:
        buttonSecondaryFocused ?? this.buttonSecondaryFocused,
    buttonAccent: buttonAccent ?? this.buttonAccent,
    buttonAccentPressed: buttonAccentPressed ?? this.buttonAccentPressed,
    buttonAccentHovered: buttonAccentHovered ?? this.buttonAccentHovered,
    statusWarning: statusWarning ?? this.statusWarning,
    statusWarningText: statusWarningText ?? this.statusWarningText,
  );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary50: Color.lerp(primary50, other.primary50, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      primary200: Color.lerp(primary200, other.primary200, t)!,
      primary300: Color.lerp(primary300, other.primary300, t)!,
      primary400: Color.lerp(primary400, other.primary400, t)!,
      primaryDefault: Color.lerp(primaryDefault, other.primaryDefault, t)!,
      primary600: Color.lerp(primary600, other.primary600, t)!,
      primary700: Color.lerp(primary700, other.primary700, t)!,
      primary800: Color.lerp(primary800, other.primary800, t)!,
      primary900: Color.lerp(primary900, other.primary900, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textContrast: Color.lerp(textContrast, other.textContrast, t)!,
      textInvert: Color.lerp(textInvert, other.textInvert, t)!,
      textOnImage: Color.lerp(textOnImage, other.textOnImage, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSuccess: Color.lerp(surfaceSuccess, other.surfaceSuccess, t)!,
      surfaceError: Color.lerp(surfaceError, other.surfaceError, t)!,
      surfaceCommentCard: Color.lerp(
        surfaceCommentCard,
        other.surfaceCommentCard,
        t,
      )!,
      surfaceEpisodeNumber: Color.lerp(
        surfaceEpisodeNumber,
        other.surfaceEpisodeNumber,
        t,
      )!,
      surfaceBottomSheet: Color.lerp(
        surfaceBottomSheet,
        other.surfaceBottomSheet,
        t,
      )!,
      surfaceGenre: Color.lerp(surfaceGenre, other.surfaceGenre, t)!,
      surfaceGenreSelected: Color.lerp(
        surfaceGenreSelected,
        other.surfaceGenreSelected,
        t,
      )!,
      surfaceDivider: Color.lerp(surfaceDivider, other.surfaceDivider, t)!,
      surfaceProfileRow: Color.lerp(
        surfaceProfileRow,
        other.surfaceProfileRow,
        t,
      )!,
      surfaceProfileRowPressed: Color.lerp(
        surfaceProfileRowPressed,
        other.surfaceProfileRowPressed,
        t,
      )!,
      surfaceBlurBackground: Color.lerp(
        surfaceBlurBackground,
        other.surfaceBlurBackground,
        t,
      )!,
      surfaceReminderButton: Color.lerp(
        surfaceReminderButton,
        other.surfaceReminderButton,
        t,
      )!,
      surfaceContainerTonal: Color.lerp(
        surfaceContainerTonal,
        other.surfaceContainerTonal,
        t,
      )!,
      surfacePlaceholderImage: Color.lerp(
        surfacePlaceholderImage,
        other.surfacePlaceholderImage,
        t,
      )!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconInvert: Color.lerp(iconInvert, other.iconInvert, t)!,
      iconContrast: Color.lerp(iconContrast, other.iconContrast, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonPrimaryHover: Color.lerp(
        buttonPrimaryHover,
        other.buttonPrimaryHover,
        t,
      )!,
      buttonPrimaryFocused: Color.lerp(
        buttonPrimaryFocused,
        other.buttonPrimaryFocused,
        t,
      )!,
      buttonPrimaryPressed: Color.lerp(
        buttonPrimaryPressed,
        other.buttonPrimaryPressed,
        t,
      )!,
      buttonDisabled: Color.lerp(buttonDisabled, other.buttonDisabled, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonSecondaryHover: Color.lerp(
        buttonSecondaryHover,
        other.buttonSecondaryHover,
        t,
      )!,
      buttonSecondaryPressed: Color.lerp(
        buttonSecondaryPressed,
        other.buttonSecondaryPressed,
        t,
      )!,
      buttonSecondaryFocused: Color.lerp(
        buttonSecondaryFocused,
        other.buttonSecondaryFocused,
        t,
      )!,
      buttonAccent: Color.lerp(buttonAccent, other.buttonAccent, t)!,
      buttonAccentPressed: Color.lerp(
        buttonAccentPressed,
        other.buttonAccentPressed,
        t,
      )!,
      buttonAccentHovered: Color.lerp(
        buttonAccentHovered,
        other.buttonAccentHovered,
        t,
      )!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      statusWarningText: Color.lerp(
        statusWarningText,
        other.statusWarningText,
        t,
      )!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

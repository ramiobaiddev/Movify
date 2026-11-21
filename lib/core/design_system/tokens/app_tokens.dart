// Hand-maintained mirror of the Figma "tokens" collection (dark mode).
// Source of truth: tokens.json next to this file. Edit both together.
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary900,
    required this.primary800,
    required this.primary700,
    required this.primary600,
    required this.primaryDefault,
    required this.primary400,
    required this.primary300,
    required this.primary200,
    required this.primary100,
    required this.primary50,
    required this.textPrimary,
    required this.textSecondary,
    required this.textContrast,
    required this.textInvert,
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
    required this.buttonSecondaryFocused,
    required this.buttonSecondaryPressed,
    required this.buttonAccent,
    required this.buttonAccentHovered,
    required this.buttonAccentPressed,
    required this.statusWarning,
  });

  final Color primary900;
  final Color primary800;
  final Color primary700;
  final Color primary600;
  final Color primaryDefault;
  final Color primary400;
  final Color primary300;
  final Color primary200;
  final Color primary100;
  final Color primary50;
  final Color textPrimary;
  final Color textSecondary;
  final Color textContrast;
  final Color textInvert;
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
  final Color buttonSecondaryFocused;
  final Color buttonSecondaryPressed;
  final Color buttonAccent;
  final Color buttonAccentHovered;
  final Color buttonAccentPressed;
  final Color statusWarning;

  static const AppColors dark = AppColors(
    primary900: Color(0xFF001133),
    primary800: Color(0xFF012266),
    primary700: Color(0xFF013499),
    primary600: Color(0xFF0145CC),
    primaryDefault: Color(0xFF0156FF),
    primary400: Color(0xFF3478FF),
    primary300: Color(0xFF679AFF),
    primary200: Color(0xFF9ABBFF),
    primary100: Color(0xFFCCDDFF),
    primary50: Color(0xFFE6EFFF),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF679AFF),
    textContrast: Color(0xFFA8A9B2),
    textInvert: Color(0xFF000000),
    surfacePrimary: Color(0xFF000000),
    surfaceSuccess: Color(0xFF29E682),
    surfaceError: Color(0xFFFF2B01),
    surfaceCommentCard: Color(0xFF323241),
    surfaceEpisodeNumber: Color(0x99FFFFFF),
    surfaceBottomSheet: Color(0xFF14151A),
    surfaceGenre: Color(0xFF1E2029),
    surfaceGenreSelected: Color(0xFF0156FF),
    surfaceDivider: Color(0xFF323241),
    surfaceProfileRow: Color(0xFF14151A),
    surfaceProfileRowPressed: Color(0xFF012266),
    surfaceBlurBackground: Color(0x80000000),
    surfaceReminderButton: Color(0xFF101A36),
    surfaceContainerTonal: Color(0xFF1E2029),
    surfacePlaceholderImage: Color(0xFFA8A9B2),
    iconPrimary: Color(0xFFFFFFFF),
    iconSecondary: Color(0xFF679AFF),
    iconDefault: Color(0xFFFFFFFF),
    iconInvert: Color(0xFF1E2029),
    iconContrast: Color(0xFFA8A9B2),
    buttonPrimary: Color(0xFF0156FF),
    buttonPrimaryHover: Color(0xFF3478FF),
    buttonPrimaryFocused: Color(0xFF0145CC),
    buttonPrimaryPressed: Color(0xFF679AFF),
    buttonDisabled: Color(0xFF1E2029),
    buttonSecondary: Color(0xFF323241),
    buttonSecondaryHover: Color(0xFF717188),
    buttonSecondaryFocused: Color(0xFF717188),
    buttonSecondaryPressed: Color(0xFF717188),
    buttonAccent: Color(0xFF664401),
    buttonAccentHovered: Color(0xFFFFBB34),
    buttonAccentPressed: Color(0xFFFFCC67),
    statusWarning: Color(0xFFF5C451),
  );

  @override
  AppColors copyWith({
    Color? primary900,
    Color? primary800,
    Color? primary700,
    Color? primary600,
    Color? primaryDefault,
    Color? primary400,
    Color? primary300,
    Color? primary200,
    Color? primary100,
    Color? primary50,
    Color? textPrimary,
    Color? textSecondary,
    Color? textContrast,
    Color? textInvert,
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
    Color? buttonSecondaryFocused,
    Color? buttonSecondaryPressed,
    Color? buttonAccent,
    Color? buttonAccentHovered,
    Color? buttonAccentPressed,
    Color? statusWarning,
  }) {
    return AppColors(
      primary900: primary900 ?? this.primary900,
      primary800: primary800 ?? this.primary800,
      primary700: primary700 ?? this.primary700,
      primary600: primary600 ?? this.primary600,
      primaryDefault: primaryDefault ?? this.primaryDefault,
      primary400: primary400 ?? this.primary400,
      primary300: primary300 ?? this.primary300,
      primary200: primary200 ?? this.primary200,
      primary100: primary100 ?? this.primary100,
      primary50: primary50 ?? this.primary50,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textContrast: textContrast ?? this.textContrast,
      textInvert: textInvert ?? this.textInvert,
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
      surfaceProfileRowPressed: surfaceProfileRowPressed ?? this.surfaceProfileRowPressed,
      surfaceBlurBackground: surfaceBlurBackground ?? this.surfaceBlurBackground,
      surfaceReminderButton: surfaceReminderButton ?? this.surfaceReminderButton,
      surfaceContainerTonal: surfaceContainerTonal ?? this.surfaceContainerTonal,
      surfacePlaceholderImage: surfacePlaceholderImage ?? this.surfacePlaceholderImage,
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
      buttonSecondaryFocused: buttonSecondaryFocused ?? this.buttonSecondaryFocused,
      buttonSecondaryPressed: buttonSecondaryPressed ?? this.buttonSecondaryPressed,
      buttonAccent: buttonAccent ?? this.buttonAccent,
      buttonAccentHovered: buttonAccentHovered ?? this.buttonAccentHovered,
      buttonAccentPressed: buttonAccentPressed ?? this.buttonAccentPressed,
      statusWarning: statusWarning ?? this.statusWarning,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary900: Color.lerp(primary900, other.primary900, t)!,
      primary800: Color.lerp(primary800, other.primary800, t)!,
      primary700: Color.lerp(primary700, other.primary700, t)!,
      primary600: Color.lerp(primary600, other.primary600, t)!,
      primaryDefault: Color.lerp(primaryDefault, other.primaryDefault, t)!,
      primary400: Color.lerp(primary400, other.primary400, t)!,
      primary300: Color.lerp(primary300, other.primary300, t)!,
      primary200: Color.lerp(primary200, other.primary200, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      primary50: Color.lerp(primary50, other.primary50, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textContrast: Color.lerp(textContrast, other.textContrast, t)!,
      textInvert: Color.lerp(textInvert, other.textInvert, t)!,
      surfacePrimary: Color.lerp(surfacePrimary, other.surfacePrimary, t)!,
      surfaceSuccess: Color.lerp(surfaceSuccess, other.surfaceSuccess, t)!,
      surfaceError: Color.lerp(surfaceError, other.surfaceError, t)!,
      surfaceCommentCard: Color.lerp(surfaceCommentCard, other.surfaceCommentCard, t)!,
      surfaceEpisodeNumber: Color.lerp(surfaceEpisodeNumber, other.surfaceEpisodeNumber, t)!,
      surfaceBottomSheet: Color.lerp(surfaceBottomSheet, other.surfaceBottomSheet, t)!,
      surfaceGenre: Color.lerp(surfaceGenre, other.surfaceGenre, t)!,
      surfaceGenreSelected: Color.lerp(surfaceGenreSelected, other.surfaceGenreSelected, t)!,
      surfaceDivider: Color.lerp(surfaceDivider, other.surfaceDivider, t)!,
      surfaceProfileRow: Color.lerp(surfaceProfileRow, other.surfaceProfileRow, t)!,
      surfaceProfileRowPressed: Color.lerp(surfaceProfileRowPressed, other.surfaceProfileRowPressed, t)!,
      surfaceBlurBackground: Color.lerp(surfaceBlurBackground, other.surfaceBlurBackground, t)!,
      surfaceReminderButton: Color.lerp(surfaceReminderButton, other.surfaceReminderButton, t)!,
      surfaceContainerTonal: Color.lerp(surfaceContainerTonal, other.surfaceContainerTonal, t)!,
      surfacePlaceholderImage: Color.lerp(surfacePlaceholderImage, other.surfacePlaceholderImage, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconInvert: Color.lerp(iconInvert, other.iconInvert, t)!,
      iconContrast: Color.lerp(iconContrast, other.iconContrast, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonPrimaryHover: Color.lerp(buttonPrimaryHover, other.buttonPrimaryHover, t)!,
      buttonPrimaryFocused: Color.lerp(buttonPrimaryFocused, other.buttonPrimaryFocused, t)!,
      buttonPrimaryPressed: Color.lerp(buttonPrimaryPressed, other.buttonPrimaryPressed, t)!,
      buttonDisabled: Color.lerp(buttonDisabled, other.buttonDisabled, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonSecondaryHover: Color.lerp(buttonSecondaryHover, other.buttonSecondaryHover, t)!,
      buttonSecondaryFocused: Color.lerp(buttonSecondaryFocused, other.buttonSecondaryFocused, t)!,
      buttonSecondaryPressed: Color.lerp(buttonSecondaryPressed, other.buttonSecondaryPressed, t)!,
      buttonAccent: Color.lerp(buttonAccent, other.buttonAccent, t)!,
      buttonAccentHovered: Color.lerp(buttonAccentHovered, other.buttonAccentHovered, t)!,
      buttonAccentPressed: Color.lerp(buttonAccentPressed, other.buttonAccentPressed, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

abstract final class Space {
  static const double none = 0;
  static const double xsm = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double x2xl = 24;
  static const double x3xl = 32;
  static const double x4xl = 40;
  static const double x5xl = 48;
  static const double x6xl = 56;
  static const double x7xl = 64;
  static const double x8xl = 72;
  static const double x9xl = 80;
  static const double x10xl = 96;
}

abstract final class Borders {
  static const double none = 0;
  static const double xsm = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
}

abstract final class Radii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
}

abstract final class Sizes {
  static const double navHeight = 64;
}

abstract final class Motion {
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationBase = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);
}

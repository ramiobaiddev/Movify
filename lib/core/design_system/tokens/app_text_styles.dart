import 'package:flutter/material.dart';
import 'package:movify/core/design_system/theme/movify_text_theme.dart';

/// Figma text styles that have no Material role:
///   body/large   20/24 Medium -> [bodyLg]
///   body/medium  18/24 Medium -> [bodyMd]
///   body/xxsmall 10/16 Regular -> [bodyXxs]
/// Colour is inherited from the surrounding DefaultTextStyle.
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.bodyLg,
    required this.bodyMd,
    required this.bodyXxs,
  });

  factory AppTextStyles.build({double scale = 1}) => AppTextStyles(
    bodyLg: MovifyTextTheme.style(20, FontWeight.w500, 24, scale: scale),
    bodyMd: MovifyTextTheme.style(18, FontWeight.w500, 24, scale: scale),
    bodyXxs: MovifyTextTheme.style(10, FontWeight.w400, 16, scale: scale),
  );

  final TextStyle bodyLg;
  final TextStyle bodyMd;
  final TextStyle bodyXxs;

  @override
  AppTextStyles copyWith({
    TextStyle? bodyLg,
    TextStyle? bodyMd,
    TextStyle? bodyXxs,
  }) => AppTextStyles(
    bodyLg: bodyLg ?? this.bodyLg,
    bodyMd: bodyMd ?? this.bodyMd,
    bodyXxs: bodyXxs ?? this.bodyXxs,
  );

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
      bodyMd: TextStyle.lerp(bodyMd, other.bodyMd, t)!,
      bodyXxs: TextStyle.lerp(bodyXxs, other.bodyXxs, t)!,
    );
  }
}

extension AppTextStylesContext on BuildContext {
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
}

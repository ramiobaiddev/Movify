import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Poster rows size themselves from the theme's text styles, so they follow
/// the fluid text scale on tablets instead of overflowing a fixed height.
abstract final class PosterRowMetrics {
  static const double posterWidth = 120;

  static double _line(TextStyle? style) =>
      (style?.fontSize ?? 14) * (style?.height ?? 1.2);

  /// Height of a PosterCard of [width]: 2:3 image, gap, title, gap, subtitle.
  static double height(BuildContext context, {double width = posterWidth}) {
    final text = Theme.of(context).textTheme;
    return width * 3 / 2 +
        Space.sm +
        _line(text.labelLarge) +
        2 +
        _line(text.bodySmall) +
        1; // rounding slack
  }
}

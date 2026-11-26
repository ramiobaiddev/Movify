import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';

/// Clean, predictable metrics for poster cards across horizontal rows and grids.
///
/// Scales dynamically with system accessibility / large font settings without
/// fragile manual typography arithmetic.
abstract final class PosterRowMetrics {
  static const double posterWidth = 120.0;

  /// Height of a poster card of [width] (2:3 aspect ratio), accounting for
  /// image height, spacing, and system font scaling.
  static double height(BuildContext context, {double width = posterWidth}) {
    final textScale =
        MediaQuery.textScalerOf(context).scale(1.0).clamp(1.0, 1.35);
    final imageHeight = width * 1.5;
    const metadataHeight = 48.0;

    return imageHeight + Space.sm + (metadataHeight * textScale);
  }
}

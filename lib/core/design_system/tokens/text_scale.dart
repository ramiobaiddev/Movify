import 'package:flutter/widgets.dart';

/// Fluid text scale. Phones render at exactly the Figma size (scale 1.0);
/// above the phone range the scale grows linearly and smoothly up to [max]
/// on tablets, with no jumps at breakpoints.
abstract final class TextScale {
  static const double phoneMaxWidth = 430;
  static const double tabletFullWidth = 840;
  static const double max = 1.3;

  static double forWidth(double width) {
    if (width <= phoneMaxWidth) {
      return 1;
    }
    final t = (width - phoneMaxWidth) / (tabletFullWidth - phoneMaxWidth);
    return 1 + (max - 1) * t.clamp(0.0, 1.0);
  }

  static double of(BuildContext context) =>
      forWidth(MediaQuery.widthOf(context));
}

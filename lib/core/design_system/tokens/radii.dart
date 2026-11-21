// Mirrors Figma tokens border/* and radius/*.
import 'package:movify/core/design_system/primitives/scale.dart';

abstract final class Borders {
  static const double none = Scale.s0;
  static const double xsm = Scale.s100;
  static const double sm = Scale.s200;
  static const double md = Scale.s300;
  static const double lg = Scale.s400;
}

abstract final class Radii {
  static const double sm = Scale.s200;
  static const double md = Scale.s300;
  static const double lg = Scale.s400;
  static const double xl = Scale.s600;
  static const double full = Scale.max;
}

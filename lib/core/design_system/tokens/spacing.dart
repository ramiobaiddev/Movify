// Mirrors Figma tokens spacing/spacing-*. (x2xl = spacing-2xl; Dart names can't start with a digit.)
import 'package:movify/core/design_system/primitives/scale.dart';

abstract final class Space {
  static const double none = Scale.s0;
  static const double xsm = Scale.s100;
  static const double sm = Scale.s200;
  static const double md = Scale.s300;
  static const double lg = Scale.s400;
  static const double xl = Scale.s500;
  static const double x2xl = Scale.s600;
  static const double x3xl = Scale.s800;
  static const double x4xl = Scale.s900;
  static const double x5xl = Scale.s1000;
  static const double x6xl = Scale.s1100;
  static const double x7xl = Scale.s1200;
  static const double x8xl = Scale.s1300;
  static const double x9xl = Scale.s1400;
  static const double x10xl = Scale.s1500;
}

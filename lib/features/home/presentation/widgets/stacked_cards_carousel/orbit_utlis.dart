import 'dart:math' as math;
import 'package:movify/core/design_system/tokens/spacing.dart';

int visibleCountForWidth(double w) {
  if (w >= 700) {
    return 7;
  }
  return 5;
}

/// Adaptive scale factor for tablets and wider screens (1.0 on phone, up to 1.35 on tablet)
double deckScale(double w) {
  if (w < 600) {
    return 1.0;
  }
  return (w / 600).clamp(1.0, 1.35);
}

/// Responsive height of the deck container so rotated and scaled cards never clip or overlap metadata
double deckHeight(double w) {
  final s = deckScale(w);
  if (w < 600) {
    return 320.0;
  }
  return 270 * s; // ~486px on tablet (fully encloses the 450px cards)
}

/// Natural semantic spacing between the deck and metadata
double deckSpacing(double w) {
  if (w < 600) {
    return Space.md; // 12px on phone
  }
  return Space.x8xl; // 32px on tablet (or Space.x4xl = 40px)
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;

double degToRad(double deg) => deg * math.pi / 180;

int orbitIndex(int current, int offset, int length) =>
    (current + offset + length) % length;

/// Calculates horizontal offset, scaled adaptively on tablets
double slotX(int o, double w) {
  if (o == 0) {
    return 0.0;
  }
  final s = deckScale(w);
  final sign = o.sign;
  final absO = o.abs();

  switch (absO) {
    case 1:
      return sign * (86.0 * s);
    case 2:
      return sign * (142.0 * s);
    case 3:
      return sign * (192.0 * s);
    default:
      return sign * ((192.0 + (absO - 3) * 44.0) * s);
  }
}

/// Calculates card tilt (rotation in radians)
double slotRotation(int o) {
  if (o == 0) {
    return 0.0;
  }
  final sign = o.sign;
  final absO = o.abs();
  if (absO == 1) {
    return degToRad(sign * 10.0);
  }
  if (absO == 2) {
    return degToRad(sign * 12.0);
  }
  return degToRad(sign * 14.0);
}

/// Calculates vertical step offset, scaled adaptively on tablets
double slotY(int o, double w) {
  final s = deckScale(w);
  final absO = o.abs();
  if (absO == 0) {
    return 0.0;
  }
  if (absO == 1) {
    return 25.0 * s;
  }
  if (absO == 2) {
    return 48.0 * s;
  }
  return (48.0 + (absO - 2) * 14.0) * s;
}

/// Calculates scale factor matching Figma proportions (196 -> 148 -> 120),
/// multiplied by the tablet deck scale.
double slotScale(int o, double w) {
  final s = deckScale(w);
  final absO = o.abs();
  if (absO == 0) {
    return 1.0 * s;
  }
  if (absO == 1) {
    return 0.757 * s;
  }
  if (absO == 2) {
    return 0.612 * s;
  }
  return ((0.612 - (absO - 2) * 0.08).clamp(0.40, 1.0)) * s;
}

/// Calculates subtle depth opacity
double slotOpacity(int o) {
  final absO = o.abs();
  if (absO <= 1) {
    return 1.0;
  }
  if (absO == 2) {
    return 0.90;
  }
  if (absO == 3) {
    return 0.65;
  }
  return 0.35;
}

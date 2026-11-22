import 'dart:math' as math;

int visibleCountForWidth(double w) {
  if (w >= 900) return 9;
  if (w >= 650) return 7;
  return 5;
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;

double degToRad(double deg) => deg * math.pi / 180;

int orbitIndex(int current, int offset, int length) =>
    (current + offset + length) % length;

/// Calculates horizontal offset based on Figma node `4:676`
double slotX(int o, double w) {
  if (o == 0) return 0.0;
  final sign = o.sign;
  final absO = o.abs();
  if (absO == 1) return sign * (w * 0.22).clamp(80.0, 95.0);
  if (absO == 2) return sign * (w * 0.36).clamp(135.0, 155.0);
  return sign * ((w * 0.36) + (absO - 2) * 45.0);
}

/// Calculates card tilt (rotation in radians) based on Figma node `4:676`
/// Left is negative tilt, right is positive tilt
double slotRotation(int o) {
  if (o == 0) return 0.0;
  final sign = o.sign;
  final absO = o.abs();
  if (absO == 1) return degToRad(sign * 10.0);
  return degToRad(sign * 12.0);
}

/// Calculates vertical step offset based on Figma node `4:676`
double slotY(int o) {
  final absO = o.abs();
  if (absO == 0) return 0.0;
  if (absO == 1) return 25.0;
  return 48.0 + (absO - 2) * 12.0;
}

/// Calculates scale factor matching Figma proportions (196 -> 148 -> 120)
double slotScale(int o) {
  final absO = o.abs();
  if (absO == 0) return 1.0;
  if (absO == 1) return 0.757; // 148.4 / 196
  return 0.612; // 120 / 196
}

/// Calculates subtle depth opacity
double slotOpacity(int o) {
  final absO = o.abs();
  if (absO <= 1) return 1.0;
  if (absO == 2) return 0.90;
  return 0.50;
}

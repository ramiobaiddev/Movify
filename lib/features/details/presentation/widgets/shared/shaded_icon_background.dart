import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

class ShadedIconBackground extends StatelessWidget {
  const ShadedIconBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(Radii.lg),
    ),
    child: child,
  );
}

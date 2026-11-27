import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

class CardContainerDecorator extends StatelessWidget {
  const CardContainerDecorator({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Space.lg,
        vertical: Space.lg,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceProfileRow,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(
          color: colors.surfaceDivider.withValues(alpha: 0.15),
        ),
      ),
      child: child,
    );
  }
}

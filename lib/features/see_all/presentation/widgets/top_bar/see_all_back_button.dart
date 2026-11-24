import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Squircle back button for See All screen matching design system.
class SeeAllBackButton extends StatelessWidget {
  const SeeAllBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        borderRadius: BorderRadius.circular(Radii.lg),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colors.surfaceContainerTonal,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.5),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colors.iconPrimary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

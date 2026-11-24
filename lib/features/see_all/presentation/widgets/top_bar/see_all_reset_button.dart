import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reset button on top-right of See All top bar matching Figma node 785:10103.
class SeeAllResetButton extends StatelessWidget {
  const SeeAllResetButton({super.key, required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: onReset,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.sm,
          vertical: Space.xsm,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        'Reset',
        style: textTheme.labelLarge?.copyWith(
          color: colors.primary300,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

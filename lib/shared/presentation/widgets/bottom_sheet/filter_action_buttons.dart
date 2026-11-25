import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Bottom action buttons (Reset and Apply) for the Filter Bottom Sheet.
class FilterActionButtons extends StatelessWidget {
  const FilterActionButtons({
    super.key,
    required this.onReset,
    required this.onApply,
  });

  final VoidCallback onReset;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: .center,
      spacing: Space.md,
      children: [
        const SizedBox(width: Space.md),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.buttonPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
              elevation: 0,
            ),
            child: Text(
              'Apply Filters',
              style: textTheme.labelLarge?.copyWith(
                color: colors.textOnImage,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 48,
          width: .infinity,
          child: OutlinedButton(
            onPressed: onReset,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.surfaceDivider),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
            ),
            child: Text(
              'Reset',
              style: textTheme.labelLarge?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

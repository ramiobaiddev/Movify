import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable selectable studio / network tile for the bottom sheet.
class StudioChipItem extends StatelessWidget {
  const StudioChipItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.sm + 2,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.buttonPrimary.withValues(alpha: 0.15)
                : colors.surfaceContainerTonal.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: isSelected ? colors.buttonPrimary : colors.surfaceDivider,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: colors.buttonPrimary,
                ),
                const SizedBox(width: Space.xsm),
              ],
              Text(
                name,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? colors.textPrimary : colors.textContrast,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

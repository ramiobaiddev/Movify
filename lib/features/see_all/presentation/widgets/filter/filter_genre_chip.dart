import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Single selectable genre chip matching Figma node 780:6894 / 780:7746.
class FilterGenreChip extends StatelessWidget {
  const FilterGenreChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
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
            vertical: Space.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? colors.surfaceGenreSelected : colors.surfaceGenre,
            borderRadius: BorderRadius.circular(Radii.md),
            border: isSelected
                ? null
                : Border.all(
                    color: colors.surfaceDivider.withValues(alpha: 0.3),
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : colors.textPrimary,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: Space.xsm),
                const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Selectable sort option tile matching Figma node 789:11321.
class FilterSortRadioTile extends StatelessWidget {
  const FilterSortRadioTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
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
            vertical: Space.md,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.surfaceCommentCard
                : colors.surfaceContainerTonal.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: isSelected
                  ? colors.surfaceGenreSelected.withValues(alpha: 0.5)
                  : colors.surfaceDivider.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? colors.textPrimary : colors.textContrast,
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_off_rounded,
                color: isSelected
                    ? colors.surfaceGenreSelected
                    : colors.iconContrast,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

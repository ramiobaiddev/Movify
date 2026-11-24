import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Filter chip in horizontal filter bar matching Figma node 785:10093 / 785:10096.
class SeeAllFilterChip extends StatelessWidget {
  const SeeAllFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClear;

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
            color: isSelected ? colors.surfaceGenreSelected : Colors.transparent,
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: isSelected
                  ? colors.surfaceGenreSelected
                  : colors.surfaceDivider.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : colors.textPrimary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: Space.xsm),
              if (isSelected && onClear != null)
                GestureDetector(
                  onTap: onClear,
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: isSelected ? Colors.white : colors.iconContrast,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

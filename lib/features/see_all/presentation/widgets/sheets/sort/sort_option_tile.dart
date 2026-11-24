import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable sort option tile with directional arrow toggle.
class SortOptionTile extends StatelessWidget {
  const SortOptionTile({
    super.key,
    required this.title,
    required this.directionLabel,
    required this.isSelected,
    required this.isAscending,
    required this.onTap,
  });

  final String title;
  final String directionLabel;
  final bool isSelected;
  final bool isAscending;
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.md,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.surfaceCommentCard
                : colors.surfaceContainerTonal.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: isSelected
                  ? colors.buttonPrimary.withValues(alpha: 0.5)
                  : colors.surfaceDivider,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? colors.textPrimary
                            : colors.textContrast,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      directionLabel,
                      style: textTheme.bodySmall?.copyWith(
                        color: isSelected
                            ? colors.buttonPrimary
                            : colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Space.sm),
              if (isSelected)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colors.buttonPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAscending
                        ? Icons.arrow_downward_rounded
                        : Icons.arrow_upward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              else
                const SizedBox(width: 36, height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

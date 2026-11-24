import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable radio option card for bottom sheets matching Figma node 789:11321 & 783:8290.
class AppBottomSheetRadioTile extends StatelessWidget {
  const AppBottomSheetRadioTile({
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.md,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.surfaceCommentCard
                : colors.surfaceContainerTonal.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(Radii.md),
            border: isSelected
                ? Border.all(
                    color: colors.surfaceGenreSelected.withValues(alpha: 0.4),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? colors.textPrimary : colors.textContrast,
                  ),
                ),
              ),
              const SizedBox(width: Space.sm),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colors.surfaceGenreSelected,
                  size: 22,
                )
              else
                const SizedBox(width: 22, height: 22),
            ],
          ),
        ),
      ),
    );
  }
}

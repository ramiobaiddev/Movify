import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';

class PillItem extends StatelessWidget {
  const PillItem({
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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: Space.sm),
        decoration: BoxDecoration(
          color: isSelected ? colors.surfaceGenreSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: textTheme.labelMedium?.copyWith(
            color: isSelected ? colors.textOnImage : colors.textContrast,
          ),
        ),
      ),
    );
  }
}

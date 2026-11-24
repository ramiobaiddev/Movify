import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';

/// Segmented pill switcher for Movies vs Series matching Figma node 785:10087.
class SeeAllMediaSwitcher extends StatelessWidget {
  const SeeAllMediaSwitcher({
    super.key,
    required this.selectedKind,
    required this.onKindChanged,
  });

  final ContentType selectedKind;
  final ValueChanged<ContentType> onKindChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 126,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colors.surfaceContainerTonal,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(
          color: colors.surfaceDivider.withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _PillItem(
              title: 'Movies',
              isSelected: selectedKind == ContentType.movies,
              onTap: () => onKindChanged(ContentType.movies),
            ),
          ),
          Expanded(
            child: _PillItem(
              title: 'Series',
              isSelected: selectedKind == ContentType.series,
              onTap: () => onKindChanged(ContentType.series),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillItem extends StatelessWidget {
  const _PillItem({
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
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : colors.textContrast,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/pill_item.dart';

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
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surfaceContainerTonal,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: colors.surfaceDivider.withValues(alpha: 0.6)),
      ),
      child: Row(
        spacing: Space.xsm,
        children: [
          Expanded(
            child: PillItem(
              title: 'Movies',
              isSelected: selectedKind == ContentType.movies,
              onTap: () => onKindChanged(ContentType.movies),
            ),
          ),
          Expanded(
            child: PillItem(
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

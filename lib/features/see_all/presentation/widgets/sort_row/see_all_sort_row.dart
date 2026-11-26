import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';

/// Right-aligned sort indicator matching Figma node 785:10104.
class SeeAllSortRow extends StatelessWidget {
  const SeeAllSortRow({super.key, required this.sort, required this.onTap});

  final DiscoverSort sort;
  final VoidCallback onTap;

  String get _label => switch (sort) {
    DiscoverSort.popularityDesc || DiscoverSort.popularityAsc => 'Popularity',
    DiscoverSort.ratingDesc || DiscoverSort.ratingAsc => 'Rating',
    DiscoverSort.releaseDateDesc => 'Release date (Newest)',
    DiscoverSort.releaseDateAsc => 'Release date (Oldest)',
    DiscoverSort.revenueDesc || DiscoverSort.revenueAsc => 'Revenue',
  };

  IconData get _icon => sort.isAscending
      ? Icons.arrow_downward_rounded
      : Icons.arrow_upward_rounded;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _label,
              style: textTheme.labelMedium?.copyWith(
                color: colors.textContrast,
              ),
            ),
            const SizedBox(width: Space.xsm),
            Icon(_icon, size: 16, color: colors.textContrast),
          ],
        ),
      ),
    );
  }
}

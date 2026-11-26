import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';

/// Column count and card shape for a full-width poster grid with `Space.lg`
/// screen padding. Shared by Search, See all and Favorites.
class PosterGridLayout {
  const PosterGridLayout._({
    required this.columns,
    required this.childAspectRatio,
  });

  factory PosterGridLayout.of(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    final columns = screenWidth >= 600 ? 4 : 3;
    final cardWidth =
        (screenWidth - (Space.lg * 2) - ((columns - 1) * Space.md)) / columns;
    final cardHeight = PosterRowMetrics.height(context, width: cardWidth);

    return PosterGridLayout._(
      columns: columns,
      childAspectRatio: cardWidth / cardHeight,
    );
  }

  final int columns;
  final double childAspectRatio;

  SliverGridDelegate get delegate => SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    crossAxisSpacing: Space.md,
    mainAxisSpacing: Space.lg,
    childAspectRatio: childAspectRatio,
  );
}

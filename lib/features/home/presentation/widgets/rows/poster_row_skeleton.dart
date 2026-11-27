import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';

/// Placeholder shown while a row's first page loads. Static boxes, no shimmer
/// animation per card.
class PosterRowSkeleton extends StatelessWidget {
  const PosterRowSkeleton({
    super.key,
    this.posterWidth = PosterRowMetrics.posterWidth,
  });

  final double posterWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: Space.md),
      itemBuilder: (_, _) => SizedBox(
        width: posterWidth,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfacePlaceholderImage,
              borderRadius: BorderRadius.circular(Radii.lg),
            ),
          ),
        ),
      ),
    );
  }
}

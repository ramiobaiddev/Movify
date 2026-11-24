import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Skeleton loader for responsive poster grid on first page load.
class SeeAllGridSkeleton extends StatelessWidget {
  const SeeAllGridSkeleton({
    super.key,
    required this.columns,
    required this.childAspectRatio,
    this.itemCount = 6,
  });

  final int columns;
  final double childAspectRatio;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: Space.md,
          mainAxisSpacing: Space.lg,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.surfacePlaceholderImage,
                  borderRadius: BorderRadius.circular(Radii.lg),
                ),
              ),
            ),
            const SizedBox(height: Space.sm),
            Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfacePlaceholderImage,
                borderRadius: BorderRadius.circular(Radii.sm),
              ),
            ),
            const SizedBox(height: Space.xsm),
            Container(
              height: 12,
              width: 60,
              decoration: BoxDecoration(
                color: colors.surfacePlaceholderImage,
                borderRadius: BorderRadius.circular(Radii.sm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/config/animations/widgets/shimmer_loading.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Skeleton placeholder for vertical list results (people and keywords).
class SearchListSkeleton extends StatelessWidget {
  const SearchListSkeleton({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ShimmerLoading(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        child: Column(
          children: List.generate(
            itemCount,
            (_) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.sm),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.surfaceGenre,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: Space.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 140,
                          height: 14,
                          decoration: BoxDecoration(
                            color: colors.surfaceGenre,
                            borderRadius: BorderRadius.circular(Radii.sm),
                          ),
                        ),
                        const SizedBox(height: Space.xsm),
                        Container(
                          width: 80,
                          height: 10,
                          decoration: BoxDecoration(
                            color: colors.surfaceGenre,
                            borderRadius: BorderRadius.circular(Radii.sm),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

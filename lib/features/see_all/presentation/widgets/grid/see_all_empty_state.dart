import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Empty state displayed when no items match the See All query or filters.
class SeeAllEmptyState extends StatelessWidget {
  const SeeAllEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.x2xl,
          vertical: Space.x4xl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.surfaceContainerTonal,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.movie_filter_outlined,
                size: 40,
                color: colors.iconSecondary,
              ),
            ),
            const SizedBox(height: Space.xl),
            Text(
              'No results found',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: Space.sm),
            Text(
              'Try adjusting your filters or search terms to find what you are looking for.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.textContrast,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

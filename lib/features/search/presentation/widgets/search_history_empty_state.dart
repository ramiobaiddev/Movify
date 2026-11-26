import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Empty state when user has no recent searches matching Figma node `784:9152`.
class SearchHistoryEmptyState extends StatelessWidget {
  const SearchHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.manSitIcon, width: 92, height: 92),
            const SizedBox(height: Space.lg),
            Text(
              'Find your next favorite',
              style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.sm),
            Text(
              'Search movies and TV shows to discover something worth watching.',
              style: textTheme.bodySmall?.copyWith(color: colors.textContrast),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

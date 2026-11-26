import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Empty state shown when TMDB search yields no results matching Figma node `784:9159`.
class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({
    super.key,
    this.title = 'No results found',
    this.message =
        "We couldn't find anything matching your search. Try another title or check your spelling.",
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Space.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.theaterIcon,
              width: 92,
              height: 92,
            ),
            const SizedBox(height: Space.lg),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.sm),
            Text(
              message,
              style: textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

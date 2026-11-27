import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Credits card matching Figma node `573:4341`.
/// Contains TMDB logo placeholder and attribution disclaimer.
class AboutTmdbCreditsCard extends StatelessWidget {
  const AboutTmdbCreditsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Space.xsm, bottom: Space.sm),
          child: Text(
            'CREDITS',
            style: textTheme.labelSmall?.copyWith(
              color: colors.textContrast,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Space.lg),
          decoration: BoxDecoration(
            color: colors.surfaceProfileRow,
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.surfaceDivider.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(Radii.sm),
                ),
                child: Icon(
                  Icons.movie_outlined,
                  size: 16,
                  color: colors.buttonPrimary,
                ),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Text(
                  'This product uses the TMDB API but is not endorsed or certified by TMDB.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.textContrast,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

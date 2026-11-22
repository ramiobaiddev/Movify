import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

/// Rating chip overlay on top-left of the poster.
class PosterRatingBadge extends StatelessWidget {
  const PosterRatingBadge({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: context.colors.surfaceBlurBackground,
      borderRadius: BorderRadius.circular(Radii.sm),
    ),
    child: Text(
      rating.toStringAsFixed(1),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.colors.textOnImage,
        fontWeight: FontWeight.w600,
        height: 1.1,
      ),
    ),
  );
}

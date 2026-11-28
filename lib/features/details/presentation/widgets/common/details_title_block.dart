import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Title, the short facts under it (year, runtime...) and the rating.
///
/// While the screen is still loading it is built from the navigation data, so
/// the title is on screen from the first frame.
class DetailsTitleBlock extends StatelessWidget {
  const DetailsTitleBlock({
    super.key,
    required this.title,
    required this.meta,
    this.rating,
    this.comingSoon = false,
    this.releaseLine,
  });

  final String title;
  final List<String> meta;
  final double? rating;

  /// Shows the green "Coming soon" badge next to the rating.
  final bool comingSoon;

  /// e.g. `Releases Wed, Nov 25 · in 12 days`.
  final String? releaseLine;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final factStyle = textTheme.bodyLarge?.copyWith(color: colors.textContrast);

    return Column(
      children: [
        Text(
          title,
          style: textTheme.headlineMedium?.copyWith(color: colors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Space.xsm),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: Space.md,
          children: [
            for (final fact in meta) Text(fact, style: factStyle),
            if (comingSoon) const _ComingSoonBadge(),
            if (rating != null) _Rating(rating: rating!),
          ],
        ),
        if (releaseLine != null) ...[
          const SizedBox(height: Space.md),
          Text(
            releaseLine!,
            style: textTheme.labelMedium?.copyWith(color: colors.textContrast),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: 24, color: colors.statusWarning),
        const SizedBox(width: Space.xsm),
        Text(
          rating.toStringAsFixed(1),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
        ),
      ],
    );
  }
}

class _ComingSoonBadge extends StatelessWidget {
  const _ComingSoonBadge();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceSuccess,
        borderRadius: BorderRadius.circular(Radii.full),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.sm,
          vertical: Space.xsm,
        ),
        child: Text(
          'Coming soon',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: colors.textOnImage),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Live rating readout badge showing the selected score, gold star, and quality description.
class RatingReadoutBadge extends StatelessWidget {
  const RatingReadoutBadge({super.key, required this.rating});

  final double? rating;

  String _descriptionFor(double? r) {
    if (r == null || r <= 0.0) {
      return 'Showing all titles without rating restrictions';
    }
    if (r >= 8.5) {
      return 'Masterpieces & highly celebrated';
    }
    if (r >= 8.0) {
      return 'Exceptional & critically acclaimed';
    }
    if (r >= 7.0) {
      return 'Great & positively reviewed';
    }
    if (r >= 6.0) {
      return 'Good & generally well received';
    }
    return 'Titles rated $r and higher';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final isAny = rating == null || rating! <= 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Space.md,
        vertical: Space.md,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerTonal.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: colors.surfaceDivider.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isAny
                  ? colors.surfaceContainerTonal.withValues(alpha: 0.5)
                  : const Color(0xFFFFB800).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(
              isAny ? Icons.all_inclusive_rounded : Icons.star_rounded,
              color: isAny ? colors.iconSecondary : const Color(0xFFFFB800),
              size: 26,
            ),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      isAny ? 'Any Rating' : '${rating!.toStringAsFixed(1)}+',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    if (!isAny) ...[
                      const SizedBox(width: Space.xsm),
                      Text(
                        '/ 10',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.textContrast,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _descriptionFor(rating),
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.textContrast,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

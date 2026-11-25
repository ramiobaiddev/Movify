import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Live release date readout badge displaying current year range selection.
class ReleaseDateReadoutBadge extends StatelessWidget {
  const ReleaseDateReadoutBadge({
    super.key,
    required this.fromYear,
    required this.toYear,
  });

  final int? fromYear;
  final int? toYear;

  String _title() {
    if (fromYear == null && toYear == null) {
      return 'All Time';
    }
    if (fromYear != null && toYear != null) {
      if (fromYear == toYear) {
        return '$fromYear';
      }
      return '$fromYear – $toYear';
    }
    if (fromYear != null) {
      return '$fromYear and later';
    }
    return 'Up to $toYear';
  }

  String _subtitle() {
    if (fromYear == null && toYear == null) {
      return 'Showing movies and series from any year';
    }
    if (fromYear != null && toYear != null) {
      if (fromYear == toYear) {
        return 'Titles released specifically in $fromYear';
      }
      return 'Titles released between $fromYear and $toYear';
    }
    if (fromYear != null) {
      return 'Titles released in $fromYear or after';
    }
    return 'Titles released before or in $toYear';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final isAll = fromYear == null && toYear == null;

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
              color: isAll
                  ? colors.surfaceContainerTonal.withValues(alpha: 0.5)
                  : colors.buttonPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: isAll ? colors.iconSecondary : colors.buttonPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _title(),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _subtitle(),
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

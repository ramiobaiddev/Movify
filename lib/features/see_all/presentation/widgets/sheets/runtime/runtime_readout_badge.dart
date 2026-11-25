import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Live runtime readout badge displaying duration range.
class RuntimeReadoutBadge extends StatelessWidget {
  const RuntimeReadoutBadge({
    super.key,
    required this.minRuntime,
    required this.maxRuntime,
  });

  final int? minRuntime;
  final int? maxRuntime;

  String _title() {
    if (minRuntime == null && maxRuntime == null) {
      return 'Any Runtime';
    }
    if (minRuntime != null && maxRuntime != null) {
      if (minRuntime == maxRuntime) {
        return '$minRuntime min';
      }
      return '$minRuntime – $maxRuntime min';
    }
    if (minRuntime != null) {
      return 'Over $minRuntime min';
    }
    return 'Under $maxRuntime min';
  }

  String _subtitle() {
    if (minRuntime == null && maxRuntime == null) {
      return 'Showing movies and series of any duration';
    }
    if (minRuntime != null && maxRuntime != null) {
      return 'Titles lasting between $minRuntime and $maxRuntime minutes';
    }
    if (minRuntime != null) {
      return 'Titles lasting longer than $minRuntime minutes';
    }
    return 'Titles shorter than $maxRuntime minutes';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final isAny = minRuntime == null && maxRuntime == null;

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
                  : colors.buttonPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(
              Icons.schedule_rounded,
              color: isAny ? colors.iconSecondary : colors.buttonPrimary,
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

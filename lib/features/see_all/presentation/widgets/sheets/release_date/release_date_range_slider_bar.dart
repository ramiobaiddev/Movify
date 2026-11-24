import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Dual-thumb range slider for choosing from-to release years.
class ReleaseDateRangeSliderBar extends StatelessWidget {
  const ReleaseDateRangeSliderBar({
    super.key,
    required this.fromYear,
    required this.toYear,
    required this.onChanged,
  });

  final int? fromYear;
  final int? toYear;
  final void Function(int from, int to) onChanged;

  static const double _min = 1970.0;
  static const double _max = 2026.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final startVal = (fromYear?.toDouble() ?? _min).clamp(_min, _max);
    final endVal = (toYear?.toDouble() ?? _max).clamp(_min, _max);

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colors.buttonPrimary,
            inactiveTrackColor: colors.surfaceDivider,
            thumbColor: Colors.white,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 9,
              elevation: 3,
            ),
            overlayColor: colors.buttonPrimary.withValues(alpha: 0.2),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
            trackHeight: 6,
          ),
          child: RangeSlider(
            min: _min,
            max: _max,
            divisions: 56,
            values: RangeValues(startVal, endVal),
            onChanged: (values) {
              onChanged(values.start.round(), values.end.round());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1970',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '1990',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '2010',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '2026',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

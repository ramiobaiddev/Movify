import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Dual-thumb range slider for specifying minimum and maximum running time.
class RuntimeRangeSliderBar extends StatelessWidget {
  const RuntimeRangeSliderBar({
    super.key,
    required this.minRuntime,
    required this.maxRuntime,
    required this.onChanged,
  });

  final int? minRuntime;
  final int? maxRuntime;
  final void Function(int min, int max) onChanged;

  static const double _min = 30.0;
  static const double _max = 240.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final startVal = (minRuntime?.toDouble() ?? _min).clamp(_min, _max);
    final endVal = (maxRuntime?.toDouble() ?? _max).clamp(_min, _max);

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
            divisions: 14,
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
                '30m',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '90m',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '150m',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '240m',
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

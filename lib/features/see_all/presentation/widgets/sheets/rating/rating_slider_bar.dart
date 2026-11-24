import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Stepped interactive slider for choosing minimum rating with fine 0.5 step granularity.
class RatingSliderBar extends StatelessWidget {
  const RatingSliderBar({
    super.key,
    required this.rating,
    required this.onChanged,
  });

  final double? rating;
  final ValueChanged<double?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final currentVal = (rating ?? 0.0).clamp(0.0, 10.0);

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colors.buttonPrimary,
            inactiveTrackColor: colors.surfaceDivider,
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 9,
              elevation: 3,
            ),
            overlayColor: colors.buttonPrimary.withValues(alpha: 0.2),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
            trackHeight: 6,
          ),
          child: Slider(
            max: 10.0,
            divisions: 20,
            value: currentVal,
            onChanged: (val) {
              onChanged(val <= 0.0 ? null : (val * 2).round() / 2);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0.0 (Any)',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '5.0',
                style: textTheme.labelSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              Text(
                '10.0',
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

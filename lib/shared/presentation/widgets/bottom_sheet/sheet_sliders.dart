import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

SliderThemeData _theme(BuildContext context) {
  final colors = context.colors;
  return SliderTheme.of(context).copyWith(
    activeTrackColor: colors.buttonPrimary,
    inactiveTrackColor: colors.surfaceDivider,
    thumbColor: colors.textOnImage,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9, elevation: 3),
    rangeThumbShape: const RoundRangeSliderThumbShape(
      enabledThumbRadius: 9,
      elevation: 3,
    ),
    overlayColor: colors.buttonPrimary.withValues(alpha: 0.2),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
    trackHeight: 6,
  );
}

class _TickLabels extends StatelessWidget {
  const _TickLabels(this.labels);

  final List<String> labels;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Space.sm),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final label in labels)
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: context.colors.textPrimary),
          ),
      ],
    ),
  );
}

/// One-thumb slider. [value] null means "no filter" and sits at [min];
/// dragging back to [min] gives null again.
class SheetSlider extends StatelessWidget {
  const SheetSlider({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.value,
    required this.onChanged,
    required this.tickLabels,
  });

  final double min;
  final double max;
  final int divisions;
  final double? value;
  final ValueChanged<double?> onChanged;
  final List<String> tickLabels;

  @override
  Widget build(BuildContext context) {
    final step = (max - min) / divisions;
    return Column(
      children: [
        SliderTheme(
          data: _theme(context),
          child: Slider(
            min: min,
            max: max,
            divisions: divisions,
            value: (value ?? min).clamp(min, max),
            onChanged: (v) =>
                onChanged(v <= min ? null : (v / step).round() * step),
          ),
        ),
        _TickLabels(tickLabels),
      ],
    );
  }
}

/// Two-thumb slider over whole numbers. null ends sit at [min] / [max].
class SheetRangeSlider extends StatelessWidget {
  const SheetRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.from,
    required this.to,
    required this.onChanged,
    required this.tickLabels,
  });

  final double min;
  final double max;
  final int divisions;
  final int? from;
  final int? to;
  final void Function(int from, int to) onChanged;
  final List<String> tickLabels;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SliderTheme(
        data: _theme(context),
        child: RangeSlider(
          min: min,
          max: max,
          divisions: divisions,
          values: RangeValues(
            (from?.toDouble() ?? min).clamp(min, max),
            (to?.toDouble() ?? max).clamp(min, max),
          ),
          onChanged: (v) => onChanged(v.start.round(), v.end.round()),
        ),
      ),
      _TickLabels(tickLabels),
    ],
  );
}

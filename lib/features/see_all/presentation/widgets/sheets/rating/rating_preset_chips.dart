import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Preset quick-tap chips for common rating thresholds.
class RatingPresetChips extends StatelessWidget {
  const RatingPresetChips({
    super.key,
    required this.selectedRating,
    required this.onSelect,
  });

  final double? selectedRating;
  final ValueChanged<double?> onSelect;

  static const _presets = <(String label, double? value)>[
    ('Any', null),
    ('6.0+', 6.0),
    ('7.0+', 7.0),
    ('8.0+', 8.0),
    ('8.5+', 8.5),
  ];

  bool _isSelected(double? presetValue) {
    if (presetValue == null) {
      return selectedRating == null || selectedRating! <= 0.0;
    }
    return selectedRating != null &&
        (selectedRating! - presetValue).abs() < 0.05;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        for (int i = 0; i < _presets.length; i++) ...[
          if (i > 0) const SizedBox(width: Space.xsm),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onSelect(_presets[i].$2),
                borderRadius: BorderRadius.circular(Radii.full),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: Space.sm),
                  decoration: BoxDecoration(
                    color: _isSelected(_presets[i].$2)
                        ? colors.buttonPrimary
                        : colors.surfaceContainerTonal.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(Radii.full),
                    border: Border.all(
                      color: _isSelected(_presets[i].$2)
                          ? colors.buttonPrimary
                          : colors.surfaceDivider,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _presets[i].$1,
                      style: textTheme.labelSmall?.copyWith(
                        color: _isSelected(_presets[i].$2)
                            ? Colors.white
                            : colors.textContrast,
                        fontWeight: _isSelected(_presets[i].$2)
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

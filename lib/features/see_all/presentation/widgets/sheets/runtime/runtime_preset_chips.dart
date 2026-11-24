import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Preset quick-tap chips for common runtime durations.
class RuntimePresetChips extends StatelessWidget {
  const RuntimePresetChips({
    super.key,
    required this.minRuntime,
    required this.maxRuntime,
    required this.onSelect,
  });

  final int? minRuntime;
  final int? maxRuntime;
  final void Function(int? min, int? max) onSelect;

  static const _presets = <(String label, int? min, int? max)>[
    ('Any', null, null),
    ('< 90m', null, 90),
    ('90–120m', 90, 120),
    ('120–150m', 120, 150),
    ('> 150m', 150, null),
  ];

  bool _isSelected(int? pMin, int? pMax) {
    if (pMin == null && pMax == null) {
      return minRuntime == null && maxRuntime == null;
    }
    return minRuntime == pMin && maxRuntime == pMax;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (final preset in _presets) ...[
            Padding(
              padding: const EdgeInsets.only(right: Space.xsm),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelect(preset.$2, preset.$3),
                  borderRadius: BorderRadius.circular(Radii.full),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Space.md,
                      vertical: Space.xsm + 2,
                    ),
                    decoration: BoxDecoration(
                      color: _isSelected(preset.$2, preset.$3)
                          ? colors.buttonPrimary
                          : colors.surfaceContainerTonal.withValues(
                              alpha: 0.25,
                            ),
                      borderRadius: BorderRadius.circular(Radii.full),
                      border: Border.all(
                        color: _isSelected(preset.$2, preset.$3)
                            ? colors.buttonPrimary
                            : colors.surfaceDivider,
                      ),
                    ),
                    child: Text(
                      preset.$1,
                      style: textTheme.labelSmall?.copyWith(
                        color: _isSelected(preset.$2, preset.$3)
                            ? Colors.white
                            : colors.textContrast,
                        fontWeight: _isSelected(preset.$2, preset.$3)
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

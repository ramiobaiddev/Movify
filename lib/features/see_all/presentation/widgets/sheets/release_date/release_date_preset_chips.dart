import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Preset quick-tap chips for common release date ranges and decades.
class ReleaseDatePresetChips extends StatelessWidget {
  const ReleaseDatePresetChips({
    super.key,
    required this.fromYear,
    required this.toYear,
    required this.onSelect,
  });

  final int? fromYear;
  final int? toYear;
  final void Function(int? from, int? to) onSelect;

  static const _presets = <(String label, int? from, int? to)>[
    ('All Time', null, null),
    ('2026', 2026, 2026),
    ('2025', 2025, 2025),
    ('2020s', 2020, 2026),
    ('2010s', 2010, 2019),
    ('Classic', 1970, 1999),
  ];

  bool _isSelected(int? pFrom, int? pTo) {
    if (pFrom == null && pTo == null) {
      return fromYear == null && toYear == null;
    }
    return fromYear == pFrom && toYear == pTo;
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
                      vertical: Space.sm,
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

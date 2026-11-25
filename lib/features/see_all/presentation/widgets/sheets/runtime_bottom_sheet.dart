import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/draft_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/preset_chips.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/readout_badge.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/sheet_sliders.dart';

typedef _Range = (int? min, int? max);

/// Runtime range in minutes. A null end is open.
abstract final class RuntimeBottomSheet {
  static const _presets = <(String, _Range)>[
    ('Any', (null, null)),
    ('< 90m', (null, 90)),
    ('90–120m', (90, 120)),
    ('120–150m', (120, 150)),
    ('> 150m', (150, null)),
  ];

  static String _title(_Range r) {
    final (min, max) = r;
    if (min == null && max == null) {
      return 'Any Runtime';
    }
    if (min != null && max != null) {
      return min == max ? '$min min' : '$min – $max min';
    }
    return min != null ? 'Over $min min' : 'Under $max min';
  }

  static String _subtitle(_Range r) {
    final (min, max) = r;
    if (min == null && max == null) {
      return 'Showing movies and series of any duration';
    }
    if (min != null && max != null) {
      return 'Titles lasting between $min and $max minutes';
    }
    return min != null
        ? 'Titles lasting longer than $min minutes'
        : 'Titles shorter than $max minutes';
  }

  static Future<void> show(
    BuildContext context, {
    required int? minRuntime,
    required int? maxRuntime,
    required void Function(int? min, int? max) onSelectRuntime,
  }) => DraftSheet.show<_Range>(
    context,
    title: 'Runtime',
    initial: (minRuntime, maxRuntime),
    emptyValue: (null, null),
    onApply: (r) => onSelectRuntime(r.$1, r.$2),
    builder: (context, range, set) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReadoutBadge(
          icon: Icons.schedule_rounded,
          title: _title(range),
          subtitle: _subtitle(range),
          active: range != (null, null),
        ),
        const SizedBox(height: Space.md),
        PresetChips<_Range>(presets: _presets, selected: range, onSelect: set),
        const SizedBox(height: Space.sm),
        SheetRangeSlider(
          min: 30,
          max: 240,
          divisions: 14,
          from: range.$1,
          to: range.$2,
          onChanged: (from, to) => set((from, to)),
          tickLabels: const ['30m', '90m', '150m', '240m'],
        ),
      ],
    ),
  );
}

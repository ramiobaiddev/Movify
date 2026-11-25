import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/draft_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/preset_chips.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/readout_badge.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/sheet_sliders.dart';

typedef _Years = (int? from, int? to);

/// Release year range. A null end is open.
abstract final class ReleaseDateBottomSheet {
  static const _presets = <(String, _Years)>[
    ('All Time', (null, null)),
    ('2026', (2026, 2026)),
    ('2025', (2025, 2025)),
    ('2020s', (2020, 2026)),
    ('2010s', (2010, 2019)),
    ('Classic', (1970, 1999)),
  ];

  static String _title(_Years y) {
    final (from, to) = y;
    if (from == null && to == null) {
      return 'All Time';
    }
    if (from != null && to != null) {
      return from == to ? '$from' : '$from – $to';
    }
    return from != null ? '$from and later' : 'Up to $to';
  }

  static String _subtitle(_Years y) {
    final (from, to) = y;
    if (from == null && to == null) {
      return 'Showing movies and series from any year';
    }
    if (from != null && to != null) {
      return from == to
          ? 'Titles released specifically in $from'
          : 'Titles released between $from and $to';
    }
    return from != null
        ? 'Titles released in $from or after'
        : 'Titles released before or in $to';
  }

  static Future<void> show(
    BuildContext context, {
    required int? fromYear,
    required int? toYear,
    required void Function(int? from, int? to) onSelectYears,
  }) => DraftSheet.show<_Years>(
    context,
    title: 'Release Date',
    initial: (fromYear, toYear),
    emptyValue: (null, null),
    onApply: (y) => onSelectYears(y.$1, y.$2),
    builder: (context, years, set) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReadoutBadge(
          icon: Icons.calendar_month_rounded,
          title: _title(years),
          subtitle: _subtitle(years),
          active: years != (null, null),
        ),
        const SizedBox(height: Space.md),
        PresetChips<_Years>(presets: _presets, selected: years, onSelect: set),
        const SizedBox(height: Space.sm),
        SheetRangeSlider(
          min: 1970,
          max: 2026,
          divisions: 56,
          from: years.$1,
          to: years.$2,
          onChanged: (from, to) => set((from, to)),
          tickLabels: const ['1970', '1990', '2010', '2026'],
        ),
      ],
    ),
  );
}

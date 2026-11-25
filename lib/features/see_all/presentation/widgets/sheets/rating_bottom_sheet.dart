import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/draft_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/preset_chips.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/readout_badge.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/sheet_sliders.dart';

/// Minimum rating (0.5 steps). null = any rating.
abstract final class RatingBottomSheet {
  static const _presets = <(String, double?)>[
    ('Any', null),
    ('6.0+', 6.0),
    ('7.0+', 7.0),
    ('8.0+', 8.0),
    ('8.5+', 8.5),
  ];

  static String _describe(double rating) {
    if (rating >= 8.5) {
      return 'Masterpieces & highly celebrated';
    }
    if (rating >= 8.0) {
      return 'Exceptional & critically acclaimed';
    }
    if (rating >= 7.0) {
      return 'Great & positively reviewed';
    }
    if (rating >= 6.0) {
      return 'Good & generally well received';
    }
    return 'Titles rated $rating and higher';
  }

  static Future<void> show(
    BuildContext context, {
    required double? selectedRating,
    required ValueChanged<double?> onSelectRating,
  }) => DraftSheet.show<double?>(
    context,
    title: 'Rating',
    initial: selectedRating,
    emptyValue: null,
    onApply: onSelectRating,
    builder: (context, rating, set) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReadoutBadge(
          icon: rating == null
              ? Icons.all_inclusive_rounded
              : Icons.star_rounded,
          title: rating == null
              ? 'Any Rating'
              : '${rating.toStringAsFixed(1)}+ / 10',
          subtitle: rating == null
              ? 'Showing all titles without rating restrictions'
              : _describe(rating),
          active: rating != null,
          accent: context.colors.statusWarning,
        ),
        const SizedBox(height: Space.lg),
        PresetChips<double?>(presets: _presets, selected: rating, onSelect: set),
        const SizedBox(height: Space.sm),
        SheetSlider(
          min: 0,
          max: 10,
          divisions: 20,
          value: rating,
          onChanged: set,
          tickLabels: const ['0.0 (Any)', '5.0', '10.0'],
        ),
      ],
    ),
  );
}

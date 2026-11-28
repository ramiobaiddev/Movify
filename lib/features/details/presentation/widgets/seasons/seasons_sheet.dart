import 'package:flutter/material.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Picker with every season. Returns the chosen season, or null when nothing
/// changed.
Future<SeasonItem?> showSeasonsSheet(
  BuildContext context, {
  required List<SeasonItem> seasons,
  required int currentNumber,
}) async {
  final picked = await AppSelectionBottomSheet.show<int>(
    context,
    title: 'Seasons',
    selectedValue: currentNumber,
    options: [
      for (final season in seasons)
        AppSelectionOption<int>(
          season.name,
          season.number,
          subtitle: season.episodeCount == null
              ? null
              : '${season.episodeCount} episodes',
        ),
    ],
  );
  if (picked == null || picked == currentNumber) {
    return null;
  }
  return seasons.firstWhere((s) => s.number == picked);
}

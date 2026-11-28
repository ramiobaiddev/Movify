import 'package:flutter/material.dart';
import 'package:movify/features/details/presentation/core/season_neighbours.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/seasons_sheet.dart';
import 'package:movify/shared/presentation/widgets/sequence_nav_bar.dart';

/// Previous / Seasons / Next bar of the season screen.
class SeasonBar extends StatelessWidget {
  const SeasonBar({
    super.key,
    required this.neighbours,
    required this.currentNumber,
    required this.onSelect,
  });

  final SeasonNeighbours neighbours;
  final int currentNumber;
  final ValueChanged<SeasonItem> onSelect;

  @override
  Widget build(BuildContext context) {
    final previous = neighbours.previous;
    final next = neighbours.next;

    return SequenceNavBar(
      centerLabel: 'Seasons',
      onCenter: () async {
        final picked = await showSeasonsSheet(
          context,
          seasons: neighbours.sorted,
          currentNumber: currentNumber,
        );
        if (picked != null && context.mounted) {
          onSelect(picked);
        }
      },
      onPrevious: previous == null ? null : () => onSelect(previous),
      nextLabel: next == null ? 'Next' : 'Next · S${next.number}',
      onNext: next == null ? null : () => onSelect(next),
    );
  }
}

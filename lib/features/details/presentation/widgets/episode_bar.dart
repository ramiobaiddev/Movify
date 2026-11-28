import 'package:flutter/material.dart';
import 'package:movify/features/details/presentation/core/episode_position.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/episodes_sheet.dart';
import 'package:movify/shared/presentation/widgets/sequence_nav_bar.dart';

/// Previous / All episodes / Next bar of the episode screen.
class EpisodeBar extends StatelessWidget {
  const EpisodeBar({
    super.key,
    required this.episodes,
    required this.current,
    required this.position,
    required this.onSelect,
  });

  final List<EpisodeItem> episodes;
  final EpisodeItem current;
  final EpisodePosition position;
  final ValueChanged<EpisodeItem> onSelect;

  @override
  Widget build(BuildContext context) {
    final previous = position.previous;
    final next = position.next;

    return SequenceNavBar(
      centerLabel: 'All episodes',
      onCenter: () async {
        final picked = await showEpisodesSheet(
          context,
          episodes: episodes,
          current: current,
          today: DateTime.now(),
        );
        if (picked != null && context.mounted) {
          onSelect(picked);
        }
      },
      onPrevious: previous == null ? null : () => onSelect(previous),
      nextLabel: next == null ? 'Next' : 'Next · ${next.code}',
      onNext: next == null ? null : () => onSelect(next),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_tile.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Picker with every episode of the season; the current one is highlighted.
/// Pops with the episode the person chose.
Future<EpisodeItem?> showEpisodesSheet(
  BuildContext context, {
  required List<EpisodeItem> episodes,
  required EpisodeItem current,
  required DateTime today,
}) => AppBottomSheet.show<EpisodeItem>(
  context,
  title: 'All episodes',
  isScrollable: true,
  child: _EpisodesList(episodes: episodes, current: current, today: today),
);

class _EpisodesList extends StatelessWidget {
  const _EpisodesList({
    required this.episodes,
    required this.current,
    required this.today,
  });

  final List<EpisodeItem> episodes;
  final EpisodeItem current;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final number = current.seasonNumber.toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Season $number',
          style: text.titleSmall?.copyWith(color: colors.textPrimary),
        ),
        const SizedBox(height: Space.xsm),
        Text(
          'Watching episode ${current.number.toString().padLeft(2, '0')}',
          style: text.bodyLarge?.copyWith(color: colors.textPrimary),
        ),
        const SizedBox(height: Space.lg),
        for (final episode in episodes) ...[
          EpisodeTile(
            episode: episode,
            today: today,
            selected: episode.id == current.id,
            showDivider: false,
            onTap: () => Navigator.of(context, rootNavigator: true).pop(episode),
          ),
          const SizedBox(height: Space.md),
        ],
      ],
    );
  }
}

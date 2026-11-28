import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/seasons/episode_tile.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Picker with every episode of the season; the current one is highlighted.
/// Pops with the episode the person chose.
Future<EpisodeItem?> showEpisodesSheet(
  BuildContext context, {
  required List<EpisodeItem> episodes,
  required EpisodeItem current,
  required DateTime today,
  String? fallbackStillPath,
}) => AppBottomSheet.show<EpisodeItem>(
  context,
  title: 'All episodes',
  isScrollable: true,
  lazyList: true,
  child: _EpisodesList(
    episodes: episodes,
    current: current,
    today: today,
    fallbackStillPath: fallbackStillPath,
  ),
);

class _EpisodesList extends StatelessWidget {
  const _EpisodesList({
    required this.episodes,
    required this.current,
    required this.today,
    this.fallbackStillPath,
  });

  final List<EpisodeItem> episodes;
  final EpisodeItem current;
  final DateTime today;
  final String? fallbackStillPath;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final number = current.seasonNumber.toString().padLeft(2, '0');

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: episodes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: Space.lg),
            child: Column(
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
              ],
            ),
          );
        }
        final episode = episodes[index - 1];

        return Padding(
          padding: const EdgeInsets.only(bottom: Space.md),
          child: EpisodeTile(
            episode: episode,
            today: today,
            fallbackStillPath: fallbackStillPath,
            selected: episode.id == current.id,
            showDivider: false,
            onTap: () =>
                Navigator.of(context, rootNavigator: true).pop(episode),
          ),
        );
      },
    );
  }
}

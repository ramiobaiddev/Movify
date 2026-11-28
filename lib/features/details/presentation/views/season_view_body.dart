import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/common/cast_row.dart';
import 'package:movify/features/details/presentation/widgets/common/details_title_block.dart';
import 'package:movify/features/details/presentation/widgets/common/information_section.dart';
import 'package:movify/features/details/presentation/widgets/common/storyline_section.dart';
import 'package:movify/features/details/presentation/widgets/common/trailer_player.dart';
import 'package:movify/features/details/presentation/widgets/common/videos_section.dart';
import 'package:movify/features/details/presentation/widgets/seasons/episodes_sliver.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Everything under the header once the season has loaded, as slivers so the
/// episodes list can build lazily.
class SeasonViewBody extends StatelessWidget {
  const SeasonViewBody({
    super.key,
    required this.content,
    required this.showAll,
    required this.onShowAll,
    required this.onEpisode,
    this.fallbackStillPath,
  });

  final SeasonContent content;
  final bool showAll;
  final VoidCallback onShowAll;
  final ValueChanged<EpisodeItem> onEpisode;
  final String? fallbackStillPath;

  @override
  Widget build(BuildContext context) => SliverMainAxisGroup(
    slivers: [
      SliverToBoxAdapter(
        child: Column(
          children: [
            ScreenGutter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsTitleBlock(
                    title: content.title,
                    meta: content.meta,
                    rating: content.rating,
                  ),
                  if (content.overview.isNotEmpty) ...[
                    const SizedBox(height: Space.x2xl),
                    StorylineSection(overview: content.overview),
                  ],
                ],
              ),
            ),
            const SizedBox(height: Space.x2xl),
            CastRow(
              cast: content.cast,
              onTap: (person) => context.openPerson(person.id),
            ),
            const SizedBox(height: Space.x3xl),
            InformationSection(rows: content.info),
            const SizedBox(height: Space.x3xl),
          ],
        ),
      ),
      EpisodesSliver(
        episodes: content.episodes,
        expanded: showAll,
        onShowAll: onShowAll,
        onTap: onEpisode,
        today: DateTime.now(),
        fallbackStillPath: fallbackStillPath,
      ),
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Space.x3xl),
            if (content.videos.isNotEmpty) ...[
              VideosSection(
                videos: content.videos,
                onPlay: (video) => showTrailerPlayer(context, video),
              ),
              const SizedBox(height: Space.x3xl),
            ],
            SizedBox(height: MediaQuery.paddingOf(context).bottom + Space.x3xl),
          ],
        ),
      ),
    ],
  );
}

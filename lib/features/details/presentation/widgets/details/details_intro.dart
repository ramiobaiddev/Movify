import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/common/details_title_block.dart';
import 'package:movify/features/details/presentation/widgets/common/storyline_section.dart';
import 'package:movify/features/details/presentation/widgets/details/genre_chips.dart';
import 'package:movify/features/details/presentation/widgets/details/next_episode_card.dart';
import 'package:movify/features/discover/presentation/models/discover_links.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Everything between the header and the cast: title, next episode, genres
/// and storyline.
class DetailsIntro extends StatelessWidget {
  const DetailsIntro({super.key, required this.content});

  final DetailsContent content;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final upcoming = content.isUpcoming(today);
    final release = content.releaseDate;
    final nextEpisode = content.nextEpisode;

    return ScreenGutter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: DetailsTitleBlock(
              title: content.title,
              meta: content.meta,
              rating: content.rating,
              comingSoon: upcoming,
              releaseLine: upcoming && release != null
                  ? releaseCountdown(release, today)
                  : null,
            ),
          ),
          if (nextEpisode != null) ...[
            const SizedBox(height: Space.x2xl),
            NextEpisodeCard(
              episode: nextEpisode,
              today: today,
              fallbackStillPath: content.backdropPath ?? content.posterPath,
            ),
          ],
          if (content.genres.isNotEmpty) ...[
            const SizedBox(height: Space.x2xl),
            GenreChips(
              genres: content.genres,
              onTap: (genre) =>
                  context.openGenre(content.kind, genre.id, genre.name),
            ),
          ],
          if (content.overview.isNotEmpty) ...[
            const SizedBox(height: Space.x2xl),
            StorylineSection(overview: content.overview),
          ],
        ],
      ),
    );
  }
}

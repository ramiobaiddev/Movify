import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/details/last_aired_card.dart';
import 'package:movify/features/details/presentation/widgets/details/seasons_row.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Last aired episode and the seasons row. Empty for movies.
class SeriesEpisodeSections extends StatelessWidget {
  const SeriesEpisodeSections({super.key, required this.content});

  final DetailsContent content;

  @override
  Widget build(BuildContext context) {
    final lastEpisode = content.lastEpisode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lastEpisode != null) ...[
          const SizedBox(height: Space.x2xl),
          ScreenGutter(
            child: LastAiredCard(
              episode: lastEpisode,
              fallbackStillPath: content.backdropPath ?? content.posterPath,
              onTap: () => context.openEpisode(content, lastEpisode),
            ),
          ),
        ],
        if (content.seasons.isNotEmpty) ...[
          const SizedBox(height: Space.x3xl),
          SeasonsRow(
            seasons: content.seasons,
            fallbackPosterPath: content.posterPath,
            onTap: (season) => context.openSeason(content, season),
          ),
        ],
      ],
    );
  }
}

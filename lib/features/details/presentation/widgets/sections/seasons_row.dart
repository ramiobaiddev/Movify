import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/section_title.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';

/// One poster per season, with the season count on the right of the title.
class SeasonsRow extends StatelessWidget {
  const SeasonsRow({
    super.key,
    required this.seasons,
    required this.fallbackPosterPath,
    required this.onTap,
  });

  static const double posterWidth = 95;

  final List<SeasonItem> seasons;

  /// Series poster, for seasons that have none of their own.
  final String? fallbackPosterPath;
  final ValueChanged<SeasonItem> onTap;

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) {
      return const SizedBox.shrink();
    }
    final count = seasons.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SectionTitle('Seasons'),
              Text(
                '$count ${count == 1 ? 'season' : 'seasons'}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colors.textContrast,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Space.lg),
        SizedBox(
          height: PosterRowMetrics.height(context, width: posterWidth),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            itemCount: seasons.length,
            separatorBuilder: (_, _) => const SizedBox(width: Space.md),
            itemBuilder: (context, index) {
              final season = seasons[index];

              return PosterCard(
                width: posterWidth,
                imageUrl: tmdbImageSize(
                  TmdbImageSize.w500,
                  season.posterPath ?? fallbackPosterPath ?? '',
                ),
                title: season.name,
                subtitle: _episodes(season.episodeCount),
                rating: season.rating,
                onTap: () => onTap(season),
              );
            },
          ),
        ),
      ],
    );
  }

  static String? _episodes(int? count) => count == null || count <= 0
      ? null
      : '$count ${count == 1 ? 'episode' : 'episodes'}';
}

import 'package:movify/features/details/domain/entites/series_season_details_entitiy.dart';
import 'package:movify/features/details/presentation/mappers/content_parts.dart';
import 'package:movify/features/details/presentation/mappers/formatters.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

extension SeasonDetailsContent on SeriesSeasonDetailsEntity {
  SeasonContent toSeasonContent() {
    final first = parseDate(seasonDate);
    final episodes = [
      for (final episode in seasonEpisodes)
        if (episode.id != null && episode.episodeNumber != null)
          EpisodeItem(
            id: episode.id!,
            seasonNumber: episode.seasonNumber ?? seasonNum,
            number: episode.episodeNumber!,
            name: nonEmpty(episode.name) ?? 'Episode ${episode.episodeNumber}',
            airDate: parseDate(episode.airDate),
            runtime: (episode.runtime ?? 0) > 0 ? episode.runtime : null,
            stillPath: nonEmpty(episode.stillPath),
            rating: ratingOrNull(episode.voteAverage),
            overview: nonEmpty(episode.overview) ?? '',
            guestStars: castOf(episode.guestStars ?? const []),
          ),
    ]..sort((a, b) => a.number.compareTo(b.number));
    final totalMinutes = episodes.fold<int>(
      0,
      (sum, e) => sum + (e.runtime ?? 0),
    );

    return SeasonContent(
      id: seasonId,
      number: seasonNum,
      title: nonEmpty(seasonName) ?? 'Season $seasonNum',
      posterPath: nonEmpty(seasonPosterPath),
      rating: ratingOrNull(seasonRating),
      meta: [
        if (first != null) '${first.year}',
        if (episodes.isNotEmpty)
          '${episodes.length} ${episodes.length == 1 ? 'Episode' : 'Episodes'}',
      ],
      overview: seasonOverView,
      cast: castOf(seasonCredits?.cast ?? const []),
      videos: videosOf(seasonVideos?.results),
      episodes: episodes,
      info: [
        if (episodes.isNotEmpty)
          InfoRow(label: 'Episodes', value: '${episodes.length}'),
        if (formatRuntime(totalMinutes) case final runtime?)
          InfoRow(label: 'Total runtime', value: runtime),
        if (first != null)
          InfoRow(label: 'First air date', value: formatDate(first)),
      ],
    );
  }
}

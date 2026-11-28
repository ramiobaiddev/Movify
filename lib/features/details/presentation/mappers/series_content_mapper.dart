import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/entites/series_details_entity.dart';
import 'package:movify/features/details/domain/value_objects/last_episode_to_air.dart';
import 'package:movify/features/details/domain/value_objects/next_episode_to_air.dart';
import 'package:movify/features/details/domain/value_objects/season.dart';
import 'package:movify/features/details/presentation/mappers/content_parts.dart';
import 'package:movify/features/details/presentation/mappers/formatters.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

extension SeriesDetailsContent on SeriesDetailsEntity {
  DetailsContent toContent() {
    final first = parseDate(firstDate);
    final last = parseDate(kLastAirDate);

    return DetailsContent(
      id: seiresId,
      kind: ContentType.series,
      title: seriesTitle ?? '',
      posterPath: nonEmpty(posterImage),
      backdropPath: nonEmpty(backgroundImage),
      rating: ratingOrNull(rating),
      releaseDate: first,
      meta: [
        if (first != null) '${first.year}',
        if (numOfSeason > 0)
          '$numOfSeason ${numOfSeason == 1 ? 'Season' : 'Seasons'}',
        if (numOfEpisoide > 0)
          '$numOfEpisoide ${numOfEpisoide == 1 ? 'Episode' : 'Episodes'}',
      ],
      overview: overView ?? '',
      genres: genresOf(geners ?? const []),
      cast: castOf(actorDetails ?? const []),
      reviews: reviewsOf(kReviews?.results),
      videos: videosOf(videoKey ?? kVideos?.results),
      nextEpisode: _nextEpisode(nextEpisodeAir),
      lastEpisode: _lastEpisode(lastEpisodeAir),
      seasons: _seasons(season),
      info: [
        if (nonEmpty(seriesStatus) case final status?)
          InfoRow(label: 'Status', value: status),
        ...originInfoRows(countries, companies, kLanguages),
        if (numOfSeason > 0)
          InfoRow(label: 'Seasons', value: '$numOfSeason'),
        if (numOfEpisoide > 0)
          InfoRow(label: 'Episodes', value: '$numOfEpisoide'),
        if (first != null)
          InfoRow(label: 'First air date', value: formatDate(first)),
        if (last != null)
          InfoRow(label: 'Last air date', value: formatDate(last)),
      ],
    );
  }
}

EpisodeSummary? _nextEpisode(NextEpisodeToAir? e) => e == null
    ? null
    : _episode(
        id: e.id,
        name: e.name,
        season: e.seasonNumber,
        number: e.episodeNumber,
        airDate: e.airDate,
        still: e.stillPath,
        vote: e.voteAverage,
      );

EpisodeSummary? _lastEpisode(LastEpisodeToAir? e) => e == null
    ? null
    : _episode(
        id: e.id,
        name: e.name,
        season: e.seasonNumber,
        number: e.episodeNumber,
        airDate: e.airDate,
        still: e.stillPath,
        vote: e.voteAverage,
      );

EpisodeSummary? _episode({
  required int? id,
  required String? name,
  required int? season,
  required int? number,
  required String? airDate,
  required String? still,
  required double? vote,
}) {
  if (id == null || season == null || number == null) {
    return null;
  }

  return EpisodeSummary(
    id: id,
    name: nonEmpty(name) ?? 'Episode $number',
    seasonNumber: season,
    episodeNumber: number,
    airDate: parseDate(airDate),
    stillPath: nonEmpty(still),
    rating: ratingOrNull(vote),
  );
}

/// Real seasons only; TMDB lists "Specials" as season 0.
List<SeasonItem> _seasons(List<Season> seasons) => [
  for (final season in seasons)
    if (season.id != null && (season.seasonNumber ?? 0) > 0)
      SeasonItem(
        id: season.id!,
        number: season.seasonNumber!,
        name: nonEmpty(season.name) ?? 'Season ${season.seasonNumber}',
        posterPath: nonEmpty(season.posterPath),
        rating: ratingOrNull(season.voteAverage),
        airDate: season.airDate,
        episodeCount: season.episodeCount,
      ),
];

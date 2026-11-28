import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/extensions/nullable_string_extension.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/models/related_args.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

/// Where a tap on the details screen goes. Keeps route names and the
/// navigation data out of the widgets.
extension DetailsLinks on BuildContext {
  void openPerson(int id) =>
      pushNamed(RouteName.person, pathParameters: {'id': '$id'});

  void openReviews(List<ReviewItem> reviews) =>
      pushNamed(RouteName.reviews, extra: reviews);

  void openCastCrew(List<CastMember> cast) =>
      pushNamed(RouteName.castCrew, extra: cast);

  void openAllSeasons(DetailsContent series) =>
      pushNamed(RouteName.allSeasons, extra: series);

  void openRelated(DetailsContent title, RelatedList list) => pushNamed(
    RouteName.related,
    extra: RelatedArgs(kind: title.kind, id: title.id, list: list),
  );

  void openSeason(DetailsContent series, SeasonItem season) => pushNamed(
    RouteName.season,
    extra: SeasonNavData.fromItem(
      season,
      tmdbId: series.id,
      seriesPosterPath: series.posterPath,
      backdropPath: series.backdropPath,
      seasons: series.seasons,
      seriesTitle: series.title,
    ),
  );

  void openEpisode(DetailsContent series, EpisodeSummary episode) => pushNamed(
    RouteName.episode,
    extra: EpisodeNavData(
      tmdbId: series.id,
      seasonNumber: episode.seasonNumber,
      episodeNumber: episode.episodeNumber,
      rating: episode.rating,
      posterImage: series.backdropPath ?? series.posterPath ?? '',
      seriesPosterPath: series.posterPath,
      seriesTitle: series.title,
      specificId: episode.id,
    ),
  );

  /// Swaps this season for a sibling so back still returns to the series.
  void replaceWithSeason(SeasonNavData from, SeasonItem season) =>
      pushReplacementNamed(
        RouteName.season,
        extra: SeasonNavData.fromItem(
          season,
          tmdbId: from.tmdbId,
          seriesPosterPath: from.posterImage,
          backdropPath: from.backdropImage,
          seasons: from.seasons,
          seriesTitle: from.seriesTitle,
        ),
      );

  void openSeasonEpisode(SeasonNavData season, EpisodeItem episode) =>
      pushNamed(
        RouteName.episode,
        extra: EpisodeNavData(
          tmdbId: season.tmdbId,
          seasonNumber: episode.seasonNumber,
          episodeNumber: episode.number,
          rating: episode.rating,
          posterImage:
              episode.stillPath.nonEmptyOrNull ??
              season.backdropImage.nonEmptyOrNull ??
              season.posterImage,
          seriesPosterPath: season.posterImage,
          seriesTitle: season.seriesTitle,
          specificId: episode.id,
        ),
      );

  void openSeries(EpisodeNavData episode) => pushNamed(
    RouteName.tvDetail,
    pathParameters: {'id': '${episode.tmdbId}'},
    extra: SeriesNavData(
      tmdbId: episode.tmdbId,
      title: episode.seriesTitle ?? '',
      posterImage: episode.seriesPosterPath ?? '',
      backdropImage: episode.backdropImage,
      specificId: episode.tmdbId,
    ),
  );
}

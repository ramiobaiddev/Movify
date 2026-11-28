import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

/// Where a tap on the details screen goes. Keeps route names and the
/// navigation data out of the widgets.
extension DetailsLinks on BuildContext {
  void openPerson(int id) =>
      pushNamed(RouteName.person, pathParameters: {'id': '$id'});

  void openReviews(List<ReviewItem> reviews) =>
      pushNamed(RouteName.reviews, extra: reviews);

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
}

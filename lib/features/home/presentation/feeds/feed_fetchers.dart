import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/use_cases/get_movie_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_series_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_trending_use_case.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// TMDB list endpoints that take no filters (home rows with a fixed source).
abstract final class FeedEndpoint {
  static const movieNowPlaying = 'movie/now_playing';
  static const movieUpcoming = 'movie/upcoming';
  static const seriesOnTheAir = 'tv/on_the_air';
  static const seriesAiringToday = 'tv/airing_today';
}

/// Builds the page fetchers behind home rows and fixed See all screens.
///
///   PagedCubit<CardDisplayModel>(fetchers.fixed(
///     ContentType.movies, FeedEndpoint.movieUpcoming))
class FeedFetchers {
  const FeedFetchers({
    required GetMovieFeedUseCase getMovies,
    required GetSeriesFeedUseCase getSeries,
    required GetTrendingUseCase getTrending,
  }) : _getMovies = getMovies,
       _getSeries = getSeries,
       _getTrending = getTrending;

  final GetMovieFeedUseCase _getMovies;
  final GetSeriesFeedUseCase _getSeries;
  final GetTrendingUseCase _getTrending;

  /// A fixed endpoint for one kind ([ContentType.movies] or
  /// [ContentType.series]).
  PageFetcher<CardDisplayModel> fixed(ContentType kind, String endPoint) =>
      switch (kind) {
        ContentType.movies =>
          (page) async => (await _getMovies(page: page, endPoint: endPoint))
              .map((r) => r.map((m) => m.toCardDisplay())),
        ContentType.series =>
          (page) async => (await _getSeries(page: page, endPoint: endPoint))
              .map((r) => r.map((s) => s.toCardDisplay())),
        _ => throw ArgumentError.value(kind, 'kind', 'movies or series only'),
      };

  /// Trending movies and series mixed (`trending/all/day`), people dropped.
  PageFetcher<CardDisplayModel> trending() =>
      (page) async => (await _getTrending(page: page)).map(
        (r) => r.map((item) => item.toCardDisplay()),
      );
}

import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/features/home/domian/use_cases/get_movies_use_case.dart';
import 'package:movify/features/home/domian/use_cases/get_series_use_case.dart';
import 'package:movify/shared/domain/entites/media_card.dart';

/// TMDB endpoints used by the home rows.
abstract final class FeedEndpoint {
  static const movieTrending = 'trending/movie/day';
  static const moviePopular = 'movie/popular';
  static const movieTopRated = 'movie/top_rated';
  static const movieUpcoming = 'movie/upcoming';
  static const movieNowPlaying = 'movie/now_playing';

  static const seriesTrending = 'trending/tv/day';
  static const seriesPopular = 'tv/popular';
  static const seriesTopRated = 'tv/top_rated';
  static const seriesOnTheAir = 'tv/on_the_air';
  static const seriesAiringToday = 'tv/airing_today';
}

/// Builds the page fetchers behind every home row. Each returns `MediaCard`s.
/// Lists that TMDB already mixes (trending/all, search/multi) need their own
/// fetcher that reads `media_type`; they are not combined here.
///
///   PagedCubit<MediaCard>(feeds.movies(FeedEndpoint.movieUpcoming))
class MediaFeeds {
  const MediaFeeds({
    required GetMoviesUseCase getMovies,
    required GetSeriesUseCase getSeries,
  }) : _getMovies = getMovies,
       _getSeries = getSeries;

  final GetMoviesUseCase _getMovies;
  final GetSeriesUseCase _getSeries;

  PageFetcher<MediaCard> movies(String endPoint) =>
      (page) async => (await _getMovies(
        page: page,
        endPoint: endPoint,
      )).map((result) => result.map((movie) => movie.toMediaCard()));

  PageFetcher<MediaCard> series(String endPoint) =>
      (page) async => (await _getSeries(
        page: page,
        endPoint: endPoint,
      )).map((result) => result.map((show) => show.toMediaCard()));

  /// For rows with a Movies / Series chip: the chip picks the endpoint.
  PageFetcher<MediaCard> byType(
    MediaType type, {
    required String movieEndPoint,
    required String seriesEndPoint,
  }) => switch (type) {
    MediaType.movie => movies(movieEndPoint),
    MediaType.series => series(seriesEndPoint),
  };
}

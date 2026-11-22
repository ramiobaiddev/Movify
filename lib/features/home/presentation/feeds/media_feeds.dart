import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
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

/// Builds the page fetchers behind every home row. Each returns
/// `MediaCard`s so rows can show movies, series, or both in the same list.
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

  /// Movies and series interleaved (movie, series, movie, ...). Both are
  /// fetched for the same page number in parallel. If only one side fails the
  /// other is still shown; if both fail the failure is returned.
  PageFetcher<MediaCard> mixed({
    required String movieEndPoint,
    required String seriesEndPoint,
  }) {
    final fetchMovies = movies(movieEndPoint);
    final fetchSeries = series(seriesEndPoint);

    return (page) async {
      final results = await Future.wait([
        fetchMovies(page),
        fetchSeries(page),
      ]);
      final movieSide = results[0];
      final seriesSide = results[1];

      final pages = <PageResult<MediaCard>>[
        ...movieSide.fold<List<PageResult<MediaCard>>>(
          (_) => const [],
          (p) => [p],
        ),
        ...seriesSide.fold<List<PageResult<MediaCard>>>(
          (_) => const [],
          (p) => [p],
        ),
      ];
      if (pages.isEmpty) {
        // Both sides failed; report the movie side's failure.
        final failure = movieSide.swap().getOrElse(
          () => const ServerFailure(errorMessage: 'Unknown error'),
        );
        return Left<Failure, PageResult<MediaCard>>(failure);
      }

      return Right(
        PageResult<MediaCard>(
          page: page,
          totalPages: pages
              .map((p) => p.totalPages)
              .reduce((a, b) => a > b ? a : b),
          totalResults: pages.fold(0, (sum, p) => sum + p.totalResults),
          results: _interleave(pages.map((p) => p.results).toList()),
        ),
      );
    };
  }

  /// For rows with a Movies / Series chip: `null` means "both".
  PageFetcher<MediaCard> byType(
    MediaType? type, {
    required String movieEndPoint,
    required String seriesEndPoint,
  }) => switch (type) {
    MediaType.movie => movies(movieEndPoint),
    MediaType.series => series(seriesEndPoint),
    null => mixed(movieEndPoint: movieEndPoint, seriesEndPoint: seriesEndPoint),
  };

  static List<MediaCard> _interleave(List<List<MediaCard>> lists) {
    final longest = lists.fold(0, (m, l) => l.length > m ? l.length : m);
    return [
      for (var i = 0; i < longest; i++)
        for (final list in lists)
          if (i < list.length) list[i],
    ];
  }
}

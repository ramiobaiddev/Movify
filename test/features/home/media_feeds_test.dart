import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/home/domian/use_cases/get_movies_use_case.dart';
import 'package:movify/features/home/domian/use_cases/get_series_use_case.dart';
import 'package:movify/features/home/presentation/feeds/media_feeds.dart';
import 'package:movify/shared/domain/entites/media_card.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';

class _MockGetMovies extends Mock implements GetMoviesUseCase {}

class _MockGetSeries extends Mock implements GetSeriesUseCase {}

MovieEntity _movie(int id) => MovieEntity(
  id: id,
  title: 'Movie $id',
  genreIds: const [],
  voteAverage: 7.5,
  releaseDate: '2024-05-17',
  posterPath: '/m$id.jpg',
  backdropPath: '',
  overview: '',
  popularity: 1,
);

SeriesEntity _show(int id) => SeriesEntity(
  id: id,
  name: 'Show $id',
  genreIds: const [],
  voteAverage: 8.1,
  firstAirDate: '2021-01-02',
  posterPath: '/s$id.jpg',
  backdropPath: '',
  overview: '',
  popularity: 1,
);

PageResult<T> _page<T>(List<T> items, {int totalPages = 5}) => PageResult<T>(
  page: 1,
  totalPages: totalPages,
  totalResults: items.length,
  results: items,
);

void main() {
  late _MockGetMovies getMovies;
  late _MockGetSeries getSeries;
  late MediaFeeds feeds;

  setUp(() {
    getMovies = _MockGetMovies();
    getSeries = _MockGetSeries();
    feeds = MediaFeeds(getMovies: getMovies, getSeries: getSeries);
  });

  void stubMovies(Either<Failure, PageResult<MovieEntity>> result) => when(
    () => getMovies(
      page: any(named: 'page'),
      endPoint: any(named: 'endPoint'),
    ),
  ).thenAnswer((_) async => result);

  void stubSeries(Either<Failure, PageResult<SeriesEntity>> result) => when(
    () => getSeries(
      page: any(named: 'page'),
      endPoint: any(named: 'endPoint'),
    ),
  ).thenAnswer((_) async => result);

  group('MediaCard mapping', () {
    test('movie maps title and release date', () {
      final card = _movie(1).toMediaCard();
      expect(card.type, MediaType.movie);
      expect(card.title, 'Movie 1');
      expect(card.year, '2024');
    });

    test('series maps name to title and first air date', () {
      final card = _show(2).toMediaCard();
      expect(card.type, MediaType.series);
      expect(card.title, 'Show 2');
      expect(card.year, '2021');
    });

    test('year is empty when the date is missing', () {
      final card = MediaCard(
        id: 1,
        type: MediaType.movie,
        title: 't',
        posterPath: '',
        voteAverage: 0,
        releaseDate: '',
      );
      expect(card.year, '');
    });
  });

  group('MediaFeeds', () {
    test('movies passes endpoint and page and maps results', () async {
      stubMovies(Right(_page([_movie(1), _movie(2)])));

      final result = await feeds.movies('movie/upcoming')(3);

      verify(() => getMovies(page: 3, endPoint: 'movie/upcoming')).called(1);
      final page = result.getOrElse(() => throw StateError('expected Right'));
      expect(page.results.map((c) => c.id), [1, 2]);
      expect(page.results.every((c) => c.type == MediaType.movie), isTrue);
    });

    test('series maps results as series cards', () async {
      stubSeries(Right(_page([_show(7)])));

      final result = await feeds.series('tv/on_the_air')(1);

      final page = result.getOrElse(() => throw StateError('expected Right'));
      expect(page.results.single.type, MediaType.series);
    });

    test('byType(series) calls only the series use case', () async {
      stubMovies(Right(_page([_movie(1)])));
      stubSeries(Right(_page([_show(10)])));

      final onlySeries = await feeds.byType(
        MediaType.series,
        movieEndPoint: 'movie/top_rated',
        seriesEndPoint: 'tv/top_rated',
      )(1);

      final page = onlySeries.getOrElse(
        () => throw StateError('expected Right'),
      );
      expect(page.results.map((c) => c.id), [10]);
      verifyNever(
        () => getMovies(
          page: any(named: 'page'),
          endPoint: any(named: 'endPoint'),
        ),
      );
    });
  });
}

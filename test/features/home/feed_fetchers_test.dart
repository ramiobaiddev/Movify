import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/use_cases/discover_media_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_movie_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_series_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_trending_use_case.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';

class _MockMovies extends Mock implements GetMovieFeedUseCase {}

class _MockSeries extends Mock implements GetSeriesFeedUseCase {}

class _MockTrending extends Mock implements GetTrendingUseCase {}

class _MockDiscover extends Mock implements DiscoverMediaUseCase {}

MovieEntity _movie(int id) => MovieEntity(
  id: id,
  title: 'Movie $id',
  genreIds: const [1],
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

PageResult<T> _page<T>(List<T> items) =>
    PageResult(page: 1, totalPages: 5, totalResults: 99, results: items);

void main() {
  late _MockMovies movies;
  late _MockSeries series;
  late _MockTrending trending;
  late _MockDiscover discover;
  late FeedFetchers fetchers;

  setUp(() {
    movies = _MockMovies();
    series = _MockSeries();
    trending = _MockTrending();
    discover = _MockDiscover();
    fetchers = FeedFetchers(
      getMovies: movies,
      getSeries: series,
      getTrending: trending,
      discoverMedia: discover,
    );
  });

  test('mappers: movie and series become card models', () {
    final m = _movie(1).toCardDisplay();
    expect(m.contentType, ContentType.movies);
    expect(m.year, '2024');
    final s = _show(2).toCardDisplay();
    expect(s.contentType, ContentType.series);
    expect(s.title, 'Show 2');
    expect(s.year, '2021');
  });

  test('fixed(movies) calls only the movie use case', () async {
    when(
      () => movies(page: any(named: 'page'), endPoint: any(named: 'endPoint')),
    ).thenAnswer((_) async => Right(_page([_movie(1), _movie(2)])));

    final r = await fetchers.fixed(ContentType.movies, 'movie/upcoming')(3);

    verify(() => movies(page: 3, endPoint: 'movie/upcoming')).called(1);
    verifyNever(
      () => series(page: any(named: 'page'), endPoint: any(named: 'endPoint')),
    );
    final page = r.getOrElse(() => throw StateError('expected Right'));
    expect(page.results.map((c) => c.id), [1, 2]);
  });

  test('fixed(series) maps series cards', () async {
    when(
      () => series(page: any(named: 'page'), endPoint: any(named: 'endPoint')),
    ).thenAnswer((_) async => Right(_page([_show(7)])));

    final r = await fetchers.fixed(ContentType.series, 'tv/on_the_air')(1);

    final page = r.getOrElse(() => throw StateError('expected Right'));
    expect(page.results.single.contentType, ContentType.series);
  });

  test('trending maps mixed items keeping their kind', () async {
    when(() => trending(page: any(named: 'page'))).thenAnswer(
      (_) async => Right(
        _page([
          const MediaItem(
            id: 1,
            kind: ContentType.series,
            title: 'S',
            posterPath: '/s',
            backdropPath: '',
            rating: 8,
            releaseDate: '2022-02-18',
            genreIds: [],
            popularity: 1,
          ),
        ]),
      ),
    );

    final r = await fetchers.trending()(1);

    final page = r.getOrElse(() => throw StateError('expected Right'));
    expect(page.results.single.contentType, ContentType.series);
  });

  test('discover passes kind, filters and page through', () async {
    const filters = DiscoverFilters(genreIds: {28});
    when(
      () => discover(
        kind: any(named: 'kind'),
        filters: any(named: 'filters'),
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) async => Right(_page(<MediaItem>[])));

    await fetchers.discover(ContentType.series, filters)(4);

    verify(
      () => discover(kind: ContentType.series, filters: filters, page: 4),
    ).called(1);
  });
}

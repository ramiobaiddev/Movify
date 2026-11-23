import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_cubit.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';
import 'package:movify/shared/domain/use_cases/discover_media_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_movie_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_series_feed_use_case.dart';
import 'package:movify/shared/domain/use_cases/get_trending_use_case.dart';

class _Movies extends Mock implements GetMovieFeedUseCase {}

class _Series extends Mock implements GetSeriesFeedUseCase {}

class _Trending extends Mock implements GetTrendingUseCase {}

class _Discover extends Mock implements DiscoverMediaUseCase {}

void main() {
  late _Discover discover;
  late _Movies movies;
  late FeedFetchers fetchers;

  setUp(() {
    discover = _Discover();
    movies = _Movies();
    fetchers = FeedFetchers(
      getMovies: movies,
      getSeries: _Series(),
      getTrending: _Trending(),
      discoverMedia: discover,
    );
    when(
      () => discover(
        kind: any(named: 'kind'),
        filters: any(named: 'filters'),
        page: any(named: 'page'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        PageResult(page: 1, totalPages: 1, totalResults: 0, results: []),
      ),
    );
    when(
      () => movies(page: any(named: 'page'), endPoint: any(named: 'endPoint')),
    ).thenAnswer(
      (_) async => const Right(
        PageResult(page: 1, totalPages: 1, totalResults: 0, results: []),
      ),
    );
  });

  SeeAllCubit make(SeeAllArgs args) =>
      SeeAllCubit(args: args, fetchers: fetchers);

  test('setKind maps genres, drops unmatched, clears studios, keeps rating', () {
    final cubit = make(
      const SeeAllArgs.discover(
        kind: ContentType.movies,
        filters: DiscoverFilters(
          genreIds: {28, 27},
          studioIds: {420},
          minRating: 7,
        ),
      ),
    );

    cubit.setKind(ContentType.series);

    expect(cubit.state.kind, ContentType.series);
    expect(cubit.state.filters.genreIds, {10759});
    expect(cubit.state.filters.studioIds, isEmpty);
    expect(cubit.state.filters.minRating, 7);
    expect(cubit.state.droppedGenreIds, {27});
    expect(cubit.state.revision, 1);

    cubit.clearNotice();
    expect(cubit.state.droppedGenreIds, isEmpty);
  });

  test('reset clears filters and sort, keeps the kind', () {
    final cubit = make(
      const SeeAllArgs.discover(
        kind: ContentType.series,
        filters: DiscoverFilters(
          genreIds: {18},
          sort: DiscoverSort.rating,
          minRating: 8,
        ),
      ),
    );

    cubit.reset();

    expect(cubit.state.kind, ContentType.series);
    expect(cubit.state.filters, const DiscoverFilters());
  });

  test('every query change builds a new list', () {
    final cubit = make(const SeeAllArgs.discover(kind: ContentType.movies));
    final first = cubit.state.list;

    cubit.applyFilters(const DiscoverFilters(minRating: 6));

    expect(cubit.state.list, isNot(same(first)));
    expect(first.isClosed, isTrue);
  });

  test('fixed args ignore every change and use the endpoint', () async {
    final cubit = make(
      const SeeAllArgs.fixed(
        kind: ContentType.movies,
        endPoint: FeedEndpoint.movieUpcoming,
      ),
    );
    await Future<void>.delayed(Duration.zero);

    cubit.setKind(ContentType.series);
    cubit.applyFilters(const DiscoverFilters(minRating: 9));
    cubit.reset();

    expect(cubit.state.revision, 0);
    expect(cubit.state.kind, ContentType.movies);
    verify(() => movies(page: 1, endPoint: 'movie/upcoming')).called(1);
    verifyNever(
      () => discover(
        kind: any(named: 'kind'),
        filters: any(named: 'filters'),
        page: any(named: 'page'),
      ),
    );
  });
}

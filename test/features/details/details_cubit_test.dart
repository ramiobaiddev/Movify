import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/entites/movie_details_entity.dart';
import 'package:movify/features/details/domain/use_cases/details_params.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_movie_details_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_tv_show_details_use_case.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_cubit.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_state.dart';

class _FetchMovie extends Mock implements FetchMovieDetailsUseCase {}

class _FetchSeries extends Mock implements FetchTvShowDetailsUseCase {}

class _FakeParams extends Fake implements DetailsParams {}

void main() {
  late _FetchMovie fetchMovie;
  late _FetchSeries fetchSeries;
  late DetailsCubit cubit;

  final movie = MovieDetailsEntity(
    movieId: 1,
    duration: 100,
    actorName: const [],
    movieStatus: 'Released',
    movieTitle: 'Movie',
    kGeners: const [],
    overView: '',
    kReviews: null,
  );

  setUpAll(() => registerFallbackValue(_FakeParams()));

  setUp(() {
    fetchMovie = _FetchMovie();
    fetchSeries = _FetchSeries();
    cubit = DetailsCubit(fetchMovie: fetchMovie, fetchSeries: fetchSeries);
  });

  tearDown(() => cubit.close());

  test('starts loading', () {
    expect(cubit.state, isA<DetailsLoading>());
  });

  test('a movie goes to the movie use case', () async {
    when(() => fetchMovie(any())).thenAnswer((_) async => Right(movie));

    await cubit.load(ContentType.movies, 1);

    expect(cubit.state, DetailsMovieLoaded(movie));
    final params =
        verify(() => fetchMovie(captureAny())).captured.single
            as DetailsParams;
    expect((params.id, params.type), (1, 'movie'));
    verifyZeroInteractions(fetchSeries);
  });

  test('a series goes to the series use case', () async {
    when(() => fetchSeries(any())).thenAnswer(
      (_) async => const Left(ServerFailure(errorMessage: 'nope')),
    );

    await cubit.load(ContentType.series, 5);

    expect(cubit.state, const DetailsError('nope'));
    final params =
        verify(() => fetchSeries(captureAny())).captured.single
            as DetailsParams;
    expect((params.id, params.type), (5, 'tv'));
    verifyZeroInteractions(fetchMovie);
  });

  test('a failure can be retried', () async {
    when(() => fetchMovie(any())).thenAnswer(
      (_) async => const Left(ServerFailure(errorMessage: 'boom')),
    );
    await cubit.load(ContentType.movies, 1);
    expect(cubit.state, const DetailsError('boom'));

    when(() => fetchMovie(any())).thenAnswer((_) async => Right(movie));
    await cubit.load(ContentType.movies, 1);
    expect(cubit.state, isA<DetailsMovieLoaded>());
  });

  test('only movies and series are accepted', () {
    expect(
      () => cubit.load(ContentType.seasons, 1),
      throwsArgumentError,
    );
  });
}

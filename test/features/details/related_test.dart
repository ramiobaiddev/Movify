import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/core/design_system/theme/movify_theme.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_movies_recommendations_use_case.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_similar_movies_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_series_recommendations_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_similar_series_use_case.dart';
import 'package:movify/features/details/presentation/feeds/related_fetchers.dart';
import 'package:movify/features/details/presentation/widgets/details/related_row.dart';

class _MovieRec extends Mock implements FetchMoviesRecommendationsUseCase {}

class _MovieSimilar extends Mock implements FetchSimilarMoviesUseCase {}

class _SeriesRec extends Mock implements FetchSeriesRecommendationsUseCase {}

class _SeriesSimilar extends Mock implements FetchSimilarSeriesUseCase {}

void main() {
  late _MovieRec movieRec;
  late _MovieSimilar movieSimilar;
  late _SeriesRec seriesRec;
  late _SeriesSimilar seriesSimilar;
  late RelatedFetchers fetchers;

  setUp(() {
    movieRec = _MovieRec();
    movieSimilar = _MovieSimilar();
    seriesRec = _SeriesRec();
    seriesSimilar = _SeriesSimilar();
    fetchers = RelatedFetchers(
      movieRecommendations: movieRec,
      movieSimilar: movieSimilar,
      seriesRecommendations: seriesRec,
      seriesSimilar: seriesSimilar,
    );
  });

  group('RelatedFetchers', () {
    test('movie recommendations use the movie use case', () async {
      when(() => movieRec(603, 2)).thenAnswer(
        (_) async => const Right(
          PageResult(page: 2, totalPages: 3, totalResults: 0, results: []),
        ),
      );

      final result = await fetchers.recommended(ContentType.movies, 603)(2);

      expect(result.isRight(), isTrue);
      verify(() => movieRec(603, 2)).called(1);
      verifyZeroInteractions(seriesRec);
    });

    test('series similar use the series use case', () async {
      when(() => seriesSimilar(7, 1)).thenAnswer(
        (_) async => const Right(
          PageResult(page: 1, totalPages: 1, totalResults: 0, results: []),
        ),
      );

      await fetchers.similar(ContentType.series, 7)(1);

      verify(() => seriesSimilar(7, 1)).called(1);
      verifyZeroInteractions(movieSimilar);
    });

    test('failures pass through', () async {
      when(() => movieSimilar(1, 1)).thenAnswer(
        (_) async => const Left(ServerFailure(errorMessage: 'boom')),
      );

      final result = await fetchers.similar(ContentType.movies, 1)(1);

      expect(result.isLeft(), isTrue);
    });

    test('only movies and series are accepted', () {
      expect(
        () => fetchers.recommended(ContentType.seasons, 1),
        throwsArgumentError,
      );
    });
  });

  testWidgets('RelatedRow collapses when there is nothing to show', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: MovifyTheme.dark(),
        home: Scaffold(
          body: RelatedRow(
            title: 'Similar',
            queryKey: 1,
            fetcher: (_) async => const Right(
              PageResult(page: 1, totalPages: 1, totalResults: 0, results: []),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Similar'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });
}

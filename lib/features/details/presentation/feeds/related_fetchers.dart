import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_movies_recommendations_use_case.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_similar_movies_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_series_recommendations_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_similar_series_use_case.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Page fetchers behind the Recommended and Similar rows of a details screen.
///
///   PagedCubit<CardDisplayModel>(fetchers.recommended(ContentType.movies, 603))
class RelatedFetchers {
  const RelatedFetchers({
    required this.movieRecommendations,
    required this.movieSimilar,
    required this.seriesRecommendations,
    required this.seriesSimilar,
  });

  final FetchMoviesRecommendationsUseCase movieRecommendations;
  final FetchSimilarMoviesUseCase movieSimilar;
  final FetchSeriesRecommendationsUseCase seriesRecommendations;
  final FetchSimilarSeriesUseCase seriesSimilar;

  /// What TMDB suggests to people who watched title [id].
  PageFetcher<CardDisplayModel> recommended(ContentType kind, int id) =>
      switch (kind) {
        ContentType.movies => (page) async => (await movieRecommendations(
          id,
          page,
        )).map((r) => r.map((m) => m.toCardDisplay())),
        ContentType.series => (page) async => (await seriesRecommendations(
          id,
          page,
        )).map((r) => r.map((s) => s.toCardDisplay())),
        _ => throw ArgumentError.value(kind, 'kind', 'movies or series only'),
      };

  /// Titles TMDB considers similar to [id] (genres and keywords).
  PageFetcher<CardDisplayModel> similar(ContentType kind, int id) =>
      switch (kind) {
        ContentType.movies => (page) async => (await movieSimilar(
          id,
          page,
        )).map((r) => r.map((m) => m.toCardDisplay())),
        ContentType.series => (page) async => (await seriesSimilar(
          id,
          page,
        )).map((r) => r.map((s) => s.toCardDisplay())),
        _ => throw ArgumentError.value(kind, 'kind', 'movies or series only'),
      };
}

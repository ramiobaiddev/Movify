import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/domain/use_cases/details_params.dart';
import 'package:movify/features/details/domain/use_cases/movies/fetch_movie_details_use_case.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_tv_show_details_use_case.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_state.dart';

/// Loads the details of one movie or series. Call [load] again to retry.
class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({
    required FetchMovieDetailsUseCase fetchMovie,
    required FetchTvShowDetailsUseCase fetchSeries,
  }) : _fetchMovie = fetchMovie,
       _fetchSeries = fetchSeries,
       super(const DetailsLoading());

  final FetchMovieDetailsUseCase _fetchMovie;
  final FetchTvShowDetailsUseCase _fetchSeries;

  Future<void> load(ContentType kind, int id) async {
    emit(const DetailsLoading());
    switch (kind) {
      case ContentType.movies:
        final result = await _fetchMovie(DetailsParams(id: id, type: 'movie'));
        if (isClosed) {
          return;
        }
        result.fold(
          (failure) => emit(DetailsError(failure.errorMessage)),
          (movie) => emit(DetailsMovieLoaded(movie)),
        );
      case ContentType.series:
        final result = await _fetchSeries(DetailsParams(id: id, type: 'tv'));
        if (isClosed) {
          return;
        }
        result.fold(
          (failure) => emit(DetailsError(failure.errorMessage)),
          (series) => emit(DetailsSeriesLoaded(series)),
        );
      default:
        throw ArgumentError.value(kind, 'kind', 'movies or series only');
    }
  }
}

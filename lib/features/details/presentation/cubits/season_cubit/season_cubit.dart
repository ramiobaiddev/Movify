import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/features/details/domain/use_cases/tv/fetch_series_season_details.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_state.dart';

/// Loads one season of a series. Call [load] again to retry.
class SeasonCubit extends Cubit<SeasonState> {
  SeasonCubit(this._fetchSeason) : super(const SeasonLoading());

  final FetchSeriesSeasonDetailsUseCase _fetchSeason;

  Future<void> load(int tvId, int seasonNumber) async {
    emit(const SeasonLoading());
    final result = await _fetchSeason(tvId, seasonNumber);
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) => emit(SeasonError(failure.errorMessage)),
      (season) => emit(SeasonLoaded(season)),
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:movify/features/details/domain/entites/series_season_details_entitiy.dart';

sealed class SeasonState extends Equatable {
  const SeasonState();

  @override
  List<Object?> get props => [];
}

final class SeasonLoading extends SeasonState {
  const SeasonLoading();
}

final class SeasonLoaded extends SeasonState {
  const SeasonLoaded(this.season);

  final SeriesSeasonDetailsEntity season;

  @override
  List<Object?> get props => [season];
}

final class SeasonError extends SeasonState {
  const SeasonError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

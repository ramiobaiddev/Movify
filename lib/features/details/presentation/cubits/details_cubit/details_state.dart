import 'package:equatable/equatable.dart';
import 'package:movify/features/details/domain/entites/movie_details_entity.dart';
import 'package:movify/features/details/domain/entites/series_details_entity.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

final class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

final class DetailsMovieLoaded extends DetailsState {
  const DetailsMovieLoaded(this.movie);

  final MovieDetailsEntity movie;

  @override
  List<Object?> get props => [movie];
}

final class DetailsSeriesLoaded extends DetailsState {
  const DetailsSeriesLoaded(this.series);

  final SeriesDetailsEntity series;

  @override
  List<Object?> get props => [series];
}

final class DetailsError extends DetailsState {
  const DetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

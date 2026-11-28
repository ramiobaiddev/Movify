import 'package:equatable/equatable.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

sealed class SeasonState extends Equatable {
  const SeasonState();

  @override
  List<Object?> get props => [];
}

final class SeasonLoading extends SeasonState {
  const SeasonLoading();
}

final class SeasonLoaded extends SeasonState {
  const SeasonLoaded(this.content);

  /// Mapped once when the season arrives, not on every rebuild.
  final SeasonContent content;

  @override
  List<Object?> get props => [content];
}

final class SeasonError extends SeasonState {
  const SeasonError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';

sealed class PersonDetailsState extends Equatable {
  const PersonDetailsState();

  @override
  List<Object?> get props => [];
}

final class PersonDetailsLoading extends PersonDetailsState {
  const PersonDetailsLoading();
}

final class PersonDetailsLoaded extends PersonDetailsState {
  const PersonDetailsLoaded(this.details);

  final PersonDetails details;

  @override
  List<Object?> get props => [details];
}

final class PersonDetailsError extends PersonDetailsState {
  const PersonDetailsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

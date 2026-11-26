import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/features/people/domain/use_cases/get_person_details_use_case.dart';
import 'package:movify/features/people/presentation/cubits/person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit(this._getDetails) : super(const PersonDetailsLoading());

  final GetPersonDetailsUseCase _getDetails;

  Future<void> load(int id) async {
    emit(const PersonDetailsLoading());
    final result = await _getDetails(id);
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) => emit(PersonDetailsError(failure.errorMessage)),
      (details) => emit(PersonDetailsLoaded(details)),
    );
  }
}

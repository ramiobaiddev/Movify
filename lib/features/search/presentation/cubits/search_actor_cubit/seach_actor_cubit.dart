import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/domain/use_cases/search_actor_use_case.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

part 'seach_actor_state.dart';

class SearchActorCubit extends Cubit<SearchActorState> {
  SearchActorCubit(this.searchActorUseCase) : super(SeachActorInitial());
  final SearchActorUseCase searchActorUseCase;
  Future<void> searchActor(String query) async {
    final results = await searchActorUseCase.call(query);
    results.fold(
      (failure) {
        emit(SearchActorFailure(errorMessage: failure.errorMessage));
      },
      (suggestions) {
        emit(SearchActorSuccess(suggestions: suggestions));
      },
    );
  }
}

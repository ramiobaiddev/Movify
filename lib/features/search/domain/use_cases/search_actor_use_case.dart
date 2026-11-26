import 'package:dartz/dartz.dart';
import 'package:movify/core/domain/use_cases/use_case.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

class SearchActorUseCase implements UseCase<PageResult<PersonItem>, String> {
  final SearchRepo searchRepo;

  SearchActorUseCase({required this.searchRepo});
  @override
  Future<Either<Failure, PageResult<PersonItem>>> call([String? parameter]) =>
      searchRepo.searchPeople(query: parameter!);
}

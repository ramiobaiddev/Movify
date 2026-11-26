import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/people/domain/repo/people_repo.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

class GetPopularPeopleUseCase {
  const GetPopularPeopleUseCase(this._repo);

  final PeopleRepo _repo;

  Future<Either<Failure, PageResult<PersonItem>>> call({int page = 1}) =>
      _repo.popular(page: page);
}

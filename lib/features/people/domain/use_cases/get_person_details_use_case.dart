import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/domain/repo/people_repo.dart';

class GetPersonDetailsUseCase {
  const GetPersonDetailsUseCase(this._repo);

  final PeopleRepo _repo;

  Future<Either<Failure, PersonDetails>> call(int id) => _repo.details(id);
}

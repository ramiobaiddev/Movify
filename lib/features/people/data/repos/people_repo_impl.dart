import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/network/api/services/safe_api_calls.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/people/data/data_sources/remote_people_data_source.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/domain/repo/people_repo.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

class PeopleRepoImpl implements PeopleRepo {
  const PeopleRepoImpl({required this.remoteDataSource});

  final RemotePeopleDataSource remoteDataSource;

  @override
  Future<Either<Failure, PageResult<PersonItem>>> popular({int page = 1}) =>
      safeApiCall(
        () async => (await remoteDataSource.popular(
          page: page,
        )).map((model) => model.toEntity()),
      );

  @override
  Future<Either<Failure, PersonDetails>> details(int id) => safeApiCall(
    () async => (await remoteDataSource.details(id)).toEntity(),
  );
}

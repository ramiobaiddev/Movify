import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/network/api/services/safe_api_calls.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/search/data/data_sources/remote/remote_search_data_source.dart';
import 'package:movify/features/search/domain/repo/search_repo.dart';
import 'package:movify/shared/domain/entites/keyword.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

class SearchRepoImpl implements SearchRepo {
  const SearchRepoImpl({required this.remoteDataSource});

  final RemoteSearchDataSource remoteDataSource;

  @override
  Future<Either<Failure, PageResult<MediaItem>>> searchMulti({
    required String query,
    int page = 1,
  }) => safeApiCall(
    () async => (await remoteDataSource.searchMulti(
      query: query,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<MediaItem>>> searchMovies({
    required String query,
    int page = 1,
  }) => safeApiCall(
    () async => (await remoteDataSource.searchMovies(
      query: query,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<MediaItem>>> searchSeries({
    required String query,
    int page = 1,
  }) => safeApiCall(
    () async => (await remoteDataSource.searchSeries(
      query: query,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<PersonItem>>> searchPeople({
    required String query,
    int page = 1,
  }) => safeApiCall(
    () async => (await remoteDataSource.searchPeople(
      query: query,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<Keyword>>> searchKeywords({
    required String query,
    int page = 1,
  }) => safeApiCall(
    () async => (await remoteDataSource.searchKeywords(
      query: query,
      page: page,
    )).map((model) => model.toEntity()),
  );
}

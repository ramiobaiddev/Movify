import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/repos/media_repo.dart';

class GetMovieFeedUseCase {
  const GetMovieFeedUseCase(this._repo);

  final MediaRepo _repo;

  Future<Either<Failure, PageResult<MovieEntity>>> call({
    required String endPoint,
    int page = 1,
  }) => _repo.movies(endPoint: endPoint, page: page);
}

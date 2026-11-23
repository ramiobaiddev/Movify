import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';
import 'package:movify/shared/domain/repos/media_repo.dart';

class GetSeriesFeedUseCase {
  const GetSeriesFeedUseCase(this._repo);

  final MediaRepo _repo;

  Future<Either<Failure, PageResult<SeriesEntity>>> call({
    required String endPoint,
    int page = 1,
  }) => _repo.series(endPoint: endPoint, page: page);
}

import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/enums/trending_window.dart';
import 'package:movify/shared/domain/repos/media_repo.dart';

class GetTrendingUseCase {
  const GetTrendingUseCase(this._repo);

  final MediaRepo _repo;

  Future<Either<Failure, PageResult<MediaItem>>> call({
    TrendingWindow window = TrendingWindow.day,
    int page = 1,
  }) => _repo.trending(window: window, page: page);
}

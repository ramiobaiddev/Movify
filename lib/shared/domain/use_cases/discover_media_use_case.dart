import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/repos/media_repo.dart';

class DiscoverMediaUseCase {
  const DiscoverMediaUseCase(this._repo);

  final MediaRepo _repo;

  Future<Either<Failure, PageResult<MediaItem>>> call({
    required ContentType kind,
    required DiscoverFilters filters,
    int page = 1,
  }) => _repo.discover(kind: kind, filters: filters, page: page);
}

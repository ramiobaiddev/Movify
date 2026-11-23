import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/network/api/services/safe_api_calls.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/data/data_sources/remote_media_data_source.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';
import 'package:movify/shared/domain/enums/trending_window.dart';
import 'package:movify/shared/domain/repos/media_repo.dart';

class MediaRepoImpl implements MediaRepo {
  const MediaRepoImpl({required this.remote});

  final RemoteMediaDataSource remote;

  @override
  Future<Either<Failure, PageResult<MediaItem>>> trending({
    TrendingWindow window = TrendingWindow.day,
    int page = 1,
  }) => safeApiCall(
    () async => (await remote.trending(
      window: window,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<MovieEntity>>> movies({
    required String endPoint,
    int page = 1,
  }) => safeApiCall(
    () async => (await remote.movies(
      endPoint: endPoint,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<SeriesEntity>>> series({
    required String endPoint,
    int page = 1,
  }) => safeApiCall(
    () async => (await remote.series(
      endPoint: endPoint,
      page: page,
    )).map((model) => model.toEntity()),
  );

  @override
  Future<Either<Failure, PageResult<MediaItem>>> discover({
    required ContentType kind,
    required DiscoverFilters filters,
    int page = 1,
  }) => safeApiCall(
    () async => (await remote.discover(
      kind: kind,
      filters: filters,
      page: page,
    )).map((model) => model.toEntity()),
  );
}

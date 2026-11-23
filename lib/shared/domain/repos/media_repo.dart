import 'package:dartz/dartz.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/domain/entites/movie_entity.dart';
import 'package:movify/shared/domain/entites/series_entity.dart';
import 'package:movify/shared/domain/enums/trending_window.dart';

/// The TMDB catalogue: lists of movies and series. User data (favorites,
/// history, reminders, auth) lives in their own repositories.
abstract interface class MediaRepo {
  /// Movies and series mixed (`trending/all/{window}`); people are dropped.
  Future<Either<Failure, PageResult<MediaItem>>> trending({
    TrendingWindow window = TrendingWindow.day,
    int page = 1,
  });

  /// A fixed movie list such as `movie/now_playing`.
  Future<Either<Failure, PageResult<MovieEntity>>> movies({
    required String endPoint,
    int page = 1,
  });

  /// A fixed series list such as `tv/on_the_air`.
  Future<Either<Failure, PageResult<SeriesEntity>>> series({
    required String endPoint,
    int page = 1,
  });

  /// Filtered, sorted list of one kind (`discover/movie` or `discover/tv`).
  /// [kind] must be [ContentType.movies] or [ContentType.series].
  Future<Either<Failure, PageResult<MediaItem>>> discover({
    required ContentType kind,
    required DiscoverFilters filters,
    int page = 1,
  });
}

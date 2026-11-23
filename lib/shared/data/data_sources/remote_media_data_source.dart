import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/home/data/models/movie_model.dart';
import 'package:movify/features/home/data/models/series_model.dart';
import 'package:movify/shared/data/models/media_item_model.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/trending_window.dart';

abstract interface class RemoteMediaDataSource {
  Future<PageResult<MediaItemModel>> trending({
    required TrendingWindow window,
    required int page,
  });

  Future<PageResult<MovieModel>> movies({
    required String endPoint,
    required int page,
  });

  Future<PageResult<SeriesModel>> series({
    required String endPoint,
    required int page,
  });

  /// `discover/movie` or `discover/tv`; [kind] is movies or series.
  Future<PageResult<MediaItemModel>> discover({
    required ContentType kind,
    required DiscoverFilters filters,
    required int page,
  });
}

import 'package:movify/core/network/api/services/api_service.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/home/data/models/movie_model.dart';
import 'package:movify/features/home/data/models/series_model.dart';
import 'package:movify/shared/data/data_sources/remote_media_data_source.dart';
import 'package:movify/shared/data/mappers/map_paged_response.dart';
import 'package:movify/shared/data/models/media_item_model.dart';
import 'package:movify/shared/domain/enums/trending_window.dart';

/// No cancel tokens here: [PagedCubit] already drops responses that belong to
/// an older load, so two rows can safely request the same endpoint at once.
class RemoteMediaDataSourceImpl implements RemoteMediaDataSource {
  const RemoteMediaDataSourceImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<PageResult<MediaItemModel>> trending({
    required TrendingWindow window,
    required int page,
  }) async {
    final data = await apiService.tmdb.content.getMovies(
      page: page,
      endPoint: 'trending/all/${window.apiValue}',
    );
    return PageResult<MediaItemModel>(
      page: data['page'] as int,
      totalPages: data['total_pages'] as int,
      totalResults: data['total_results'] as int,
      results: (data['results'] as List)
          .map((e) => MediaItemModel.tryFromJson(e as Map<String, dynamic>))
          .whereType<MediaItemModel>()
          .toList(),
    );
  }

  @override
  Future<PageResult<MovieModel>> movies({
    required String endPoint,
    required int page,
  }) async => mapPagedResponse(
    data: await apiService.tmdb.content.getMovies(
      page: page,
      endPoint: endPoint,
    ),
    fromJson: MovieModel.fromJson,
  );

  @override
  Future<PageResult<SeriesModel>> series({
    required String endPoint,
    required int page,
  }) async => mapPagedResponse(
    data: await apiService.tmdb.content.getTvShows(
      page: page,
      endPoint: endPoint,
    ),
    fromJson: SeriesModel.fromJson,
  );
}

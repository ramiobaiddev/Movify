import 'package:movify/core/network/api/services/api_service.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/features/home/data/models/movie_model.dart';
import 'package:movify/features/home/data/models/series_model.dart';
import 'package:movify/features/search/data/data_sources/remote/remote_search_data_source.dart';
import 'package:movify/features/search/data/models/keyword_model.dart';
import 'package:movify/features/search/data/models/person_item_model.dart';
import 'package:movify/shared/data/mappers/map_paged_response.dart';
import 'package:movify/shared/data/models/media_item_model.dart';

class RemoteSearchDataSourceImpl implements RemoteSearchDataSource {
  const RemoteSearchDataSourceImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<PageResult<MediaItemModel>> searchMulti({
    required String query,
    int page = 1,
  }) async {
    final data = await apiService.tmdb.search.searchMulti(query, page: page);
    final items = (data['results'] as List)
        .map((e) => MediaItemModel.tryFromJson(e as Map<String, dynamic>))
        .whereType<MediaItemModel>()
        .toList();

    return PageResult<MediaItemModel>(
      page: (data['page'] as num?)?.toInt() ?? page,
      totalPages: (data['total_pages'] as num?)?.toInt() ?? 1,
      totalResults: (data['total_results'] as num?)?.toInt() ?? items.length,
      results: items,
    );
  }

  @override
  Future<PageResult<MovieModel>> searchMovies({
    required String query,
    int page = 1,
  }) async => mapPagedResponse(
    data: await apiService.tmdb.search.searchMovies(query, page: page),
    fromJson: MovieModel.fromJson,
  );

  @override
  Future<PageResult<SeriesModel>> searchSeries({
    required String query,
    int page = 1,
  }) async => mapPagedResponse(
    data: await apiService.tmdb.search.searchSeries(query, page: page),
    fromJson: SeriesModel.fromJson,
  );

  @override
  Future<PageResult<PersonItemModel>> searchPeople({
    required String query,
    int page = 1,
  }) async {
    final data = await apiService.tmdb.search.searchActors(query, page: page);
    final items = (data['results'] as List)
        .map(
          (e) => PersonItemModel.fromJson(e as Map<String, dynamic>),
        )
        .where((e) => e.profilePath != null)
        .toList();

    return PageResult<PersonItemModel>(
      page: (data['page'] as num?)?.toInt() ?? page,
      totalPages: (data['total_pages'] as num?)?.toInt() ?? 1,
      totalResults: (data['total_results'] as num?)?.toInt() ?? items.length,
      results: items,
    );
  }

  @override
  Future<PageResult<KeywordModel>> searchKeywords({
    required String query,
    int page = 1,
  }) async {
    final data = await apiService.tmdb.search.searchKeywords(query, page: page);
    final items = (data['results'] as List)
        .map((e) => KeywordModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PageResult<KeywordModel>(
      page: (data['page'] as num?)?.toInt() ?? page,
      totalPages: (data['total_pages'] as num?)?.toInt() ?? 1,
      totalResults: (data['total_results'] as num?)?.toInt() ?? items.length,
      results: items,
    );
  }
}

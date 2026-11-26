import 'package:movify/core/network/api/services/api_service.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';
import 'package:movify/core/utils/enums/content_type.dart';
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
  }) async => mapPagedItems(
    data: await apiService.tmdb.search.searchMulti(query, page: page),
    parse: MediaItemModel.tryFromJson,
  );

  @override
  Future<PageResult<MediaItemModel>> searchMovies({
    required String query,
    int page = 1,
  }) async => mapPagedItems(
    data: await apiService.tmdb.search.searchMovies(query, page: page),
    parse: (json) => MediaItemModel.tryFromJson(json, kind: ContentType.movies),
  );

  @override
  Future<PageResult<MediaItemModel>> searchSeries({
    required String query,
    int page = 1,
  }) async => mapPagedItems(
    data: await apiService.tmdb.search.searchSeries(query, page: page),
    parse: (json) => MediaItemModel.tryFromJson(json, kind: ContentType.series),
  );

  @override
  Future<PageResult<PersonItemModel>> searchPeople({
    required String query,
    int page = 1,
  }) async => mapPagedItems(
    data: await apiService.tmdb.search.searchActors(query, page: page),
    parse: (json) {
      final person = PersonItemModel.fromJson(json);
      return person.profilePath == null ? null : person;
    },
  );

  @override
  Future<PageResult<KeywordModel>> searchKeywords({
    required String query,
    int page = 1,
  }) async => mapPagedItems(
    data: await apiService.tmdb.search.searchKeywords(query, page: page),
    parse: KeywordModel.fromJson,
  );
}

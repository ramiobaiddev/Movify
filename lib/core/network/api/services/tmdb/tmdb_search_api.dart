import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_base_client.dart';
import 'package:movify/core/types/api_types.dart';

class TmdbSearchApi {
  final TmdbBaseClient client;

  TmdbSearchApi(this.client);

  ApiResponse searchMulti(
    String query, {
    int page = 1,
    CancelToken? cancelToken,
  }) => client.get(
    'search/multi',
    queryParams: {'query': query, 'page': '$page'},
    cancelToken: cancelToken,
    overridePolicy: CachePolicy.noCache,
  );

  ApiResponse searchMovies(
    String query, {
    int page = 1,
    CancelToken? cancelToken,
  }) => client.get(
    'search/movie',
    queryParams: {'query': query, 'page': '$page'},
    cancelToken: cancelToken,
    overridePolicy: CachePolicy.noCache,
  );

  ApiResponse searchSeries(
    String query, {
    int page = 1,
    CancelToken? cancelToken,
  }) => client.get(
    'search/tv',
    queryParams: {'query': query, 'page': '$page'},
    cancelToken: cancelToken,
    overridePolicy: CachePolicy.noCache,
  );

  ApiResponse searchActors(
    String query, {
    int page = 1,
    CancelToken? cancelToken,
  }) => client.get(
    'search/person',
    queryParams: {'query': query, 'page': '$page'},
    cancelToken: cancelToken,
    overridePolicy: CachePolicy.noCache,
  );

  ApiResponse searchKeywords(
    String query, {
    int page = 1,
    CancelToken? cancelToken,
  }) => client.get(
    'search/keyword',
    queryParams: {'query': query, 'page': '$page'},
    cancelToken: cancelToken,
    overridePolicy: CachePolicy.noCache,
  );
}

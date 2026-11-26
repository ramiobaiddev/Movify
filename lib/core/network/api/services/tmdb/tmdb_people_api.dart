import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:movify/constant.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_base_client.dart';
import 'package:movify/core/types/api_types.dart';

class TmdbPeopleApi {
  TmdbPeopleApi(this.client);

  final TmdbBaseClient client;
  final int pageCacheCount = Constants.pageCacheCount;

  ApiResponse popular({int page = 1}) => client.get(
    'person/popular',
    queryParams: {'page': '$page'},
    overridePolicy: page <= pageCacheCount
        ? CachePolicy.request
        : CachePolicy.noCache,
  );

  /// Profile and every movie/TV credit in one request.
  ApiResponse details(int id) => client.get(
    'person/$id',
    queryParams: {'append_to_response': 'combined_credits'},
    overridePolicy: CachePolicy.request,
  );
}

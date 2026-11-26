import 'package:movify/core/pagination/domain/entites/page_result.dart';

PageResult<T> mapPagedResponse<T>({
  required Map<String, dynamic> data,
  required T Function(Map<String, dynamic>) fromJson,
}) {
  final items = (data['results'] as List)
      .where((e) => e['poster_path'] != null)
      .map((e) => fromJson(e as Map<String, dynamic>))
      .toList();

  return PageResult<T>(
    page: data['page'] as int,
    totalPages: data['total_pages'] as int,
    totalResults: data['total_results'] as int,
    results: items,
  );
}

/// Like [mapPagedResponse] but [parse] may return null to drop an entry
/// (no poster, no profile photo, a person in a mixed list, ...).
PageResult<T> mapPagedItems<T>({
  required Map<String, dynamic> data,
  required T? Function(Map<String, dynamic>) parse,
}) {
  final items = (data['results'] as List)
      .map((e) => parse(e as Map<String, dynamic>))
      .whereType<T>()
      .toList();

  return PageResult<T>(
    page: (data['page'] as num?)?.toInt() ?? 1,
    totalPages: (data['total_pages'] as num?)?.toInt() ?? 1,
    totalResults: (data['total_results'] as num?)?.toInt() ?? items.length,
    results: items,
  );
}

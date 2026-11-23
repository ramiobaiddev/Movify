import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';

/// Builds the query string for TMDB `discover/movie` and `discover/tv`.
/// Only non-empty filters are sent.
abstract final class DiscoverQuery {
  /// Rating sorts need a vote floor, otherwise one 10/10 vote tops the list.
  static const ratingVoteFloor = 300;

  static Map<String, String> build({
    required ContentType kind,
    required DiscoverFilters filters,
    required int page,
  }) {
    final isMovie = kind == ContentType.movies;
    final dateField = isMovie ? 'primary_release_date' : 'first_air_date';
    final f = filters;

    return {
      'page': '$page',
      'sort_by': _sort(f.sort, dateField),
      if (f.sort == DiscoverSort.rating)
        'vote_count.gte': '$ratingVoteFloor',
      if (f.genreIds.isNotEmpty) 'with_genres': f.genreIds.join(','),
      if (f.minRating != null) 'vote_average.gte': '${f.minRating}',
      if (f.fromYear != null) '$dateField.gte': '${f.fromYear}-01-01',
      if (f.toYear != null) '$dateField.lte': '${f.toYear}-12-31',
      if (f.languageCode != null) 'with_original_language': f.languageCode!,
      if (f.minRuntime != null) 'with_runtime.gte': '${f.minRuntime}',
      if (f.maxRuntime != null) 'with_runtime.lte': '${f.maxRuntime}',
      if (f.studioIds.isNotEmpty) 'with_companies': f.studioIds.join(','),
    };
  }

  static String _sort(DiscoverSort sort, String dateField) => switch (sort) {
    DiscoverSort.popularity => 'popularity.desc',
    DiscoverSort.rating => 'vote_average.desc',
    DiscoverSort.newest => '$dateField.desc',
    DiscoverSort.oldest => '$dateField.asc',
  };
}

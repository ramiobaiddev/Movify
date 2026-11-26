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
      'sort_by': _sort(f.sort, dateField, isMovie),
      if (f.sort == DiscoverSort.ratingDesc ||
          f.sort == DiscoverSort.ratingAsc)
        'vote_count.gte': '$ratingVoteFloor',
      if (f.genreIds.isNotEmpty) 'with_genres': f.genreIds.join(','),
      if (f.minRating != null) 'vote_average.gte': '${f.minRating}',
      if (f.fromYear != null) '$dateField.gte': '${f.fromYear}-01-01',
      if (f.toYear != null) '$dateField.lte': '${f.toYear}-12-31',
      if (f.languageCode != null) 'with_original_language': f.languageCode!,
      if (f.minRuntime != null) 'with_runtime.gte': '${f.minRuntime}',
      if (f.maxRuntime != null) 'with_runtime.lte': '${f.maxRuntime}',
      if (f.keywords.isNotEmpty)
        'with_keywords': f.keywords.map((k) => k.id).join(','),
      if (f.studioIds.isNotEmpty)
        isMovie ? 'with_companies' : 'with_networks': f.studioIds.join('|'),
    };
  }

  /// `discover/tv` has no revenue sort; fall back to popularity.
  static String _sort(DiscoverSort sort, String dateField, bool isMovie) =>
      switch (sort) {
    DiscoverSort.popularityDesc => 'popularity.desc',
    DiscoverSort.popularityAsc => 'popularity.asc',
    DiscoverSort.ratingDesc => 'vote_average.desc',
    DiscoverSort.ratingAsc => 'vote_average.asc',
    DiscoverSort.releaseDateDesc => '$dateField.desc',
    DiscoverSort.releaseDateAsc => '$dateField.asc',
    DiscoverSort.revenueDesc => isMovie ? 'revenue.desc' : 'popularity.desc',
    DiscoverSort.revenueAsc => isMovie ? 'revenue.asc' : 'popularity.desc',
  };
}

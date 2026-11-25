import 'package:flutter_test/flutter_test.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/data/models/discover_query.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';

void main() {
  test('defaults send only page and popularity sort', () {
    final q = DiscoverQuery.build(
      kind: ContentType.movies,
      filters: const DiscoverFilters(),
      page: 2,
    );
    expect(q, {'page': '2', 'sort_by': 'popularity.desc'});
  });

  test('movie uses primary_release_date, tv uses first_air_date', () {
    const f = DiscoverFilters(fromYear: 2000, toYear: 2010);
    final movie = DiscoverQuery.build(kind: ContentType.movies, filters: f, page: 1);
    final tv = DiscoverQuery.build(kind: ContentType.series, filters: f, page: 1);
    expect(movie['primary_release_date.gte'], '2000-01-01');
    expect(movie['primary_release_date.lte'], '2010-12-31');
    expect(tv['first_air_date.gte'], '2000-01-01');
    expect(tv.containsKey('primary_release_date.gte'), isFalse);
  });

  test('runtime, genres, language and studios use TMDB names', () {
    final q = DiscoverQuery.build(
      kind: ContentType.movies,
      filters: const DiscoverFilters(
        genreIds: {28, 12},
        minRuntime: 90,
        maxRuntime: 150,
        languageCode: 'ko',
        minRating: 7.5,
        studioIds: {420},
      ),
      page: 1,
    );
    expect(q['with_genres'], '28,12');
    expect(q['with_runtime.gte'], '90');
    expect(q['with_runtime.lte'], '150');
    expect(q['with_original_language'], 'ko');
    expect(q['vote_average.gte'], '7.5');
    expect(q['with_companies'], '420');
  });

  test('rating sort adds a vote count floor', () {
    final q = DiscoverQuery.build(
      kind: ContentType.series,
      filters: const DiscoverFilters(sort: DiscoverSort.rating),
      page: 1,
    );
    expect(q['sort_by'], 'vote_average.desc');
    expect(q['vote_count.gte'], '300');
  });

  test('newest and oldest follow the kind date field', () {
    String sort(ContentType k, DiscoverSort s) => DiscoverQuery.build(
      kind: k,
      filters: DiscoverFilters(sort: s),
      page: 1,
    )['sort_by']!;
    expect(sort(ContentType.movies, DiscoverSort.newest), 'primary_release_date.desc');
    expect(sort(ContentType.series, DiscoverSort.oldest), 'first_air_date.asc');
  });

  test('series studios use with_networks joined with OR', () {
    final q = DiscoverQuery.build(
      kind: ContentType.series,
      filters: const DiscoverFilters(studioIds: {213, 49}),
      page: 1,
    );
    expect(q['with_networks'], '213|49');
    expect(q.containsKey('with_companies'), isFalse);
  });

  test('movie studios use with_companies joined with OR', () {
    final q = DiscoverQuery.build(
      kind: ContentType.movies,
      filters: const DiscoverFilters(studioIds: {420, 3}),
      page: 1,
    );
    expect(q['with_companies'], '420|3');
  });

  test('revenue sort works for movies but falls back to popularity for tv', () {
    String sort(ContentType k) => DiscoverQuery.build(
      kind: k,
      filters: const DiscoverFilters(sort: DiscoverSort.revenueDesc),
      page: 1,
    )['sort_by']!;
    expect(sort(ContentType.movies), 'revenue.desc');
    expect(sort(ContentType.series), 'popularity.desc');
  });
}

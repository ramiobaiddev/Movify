import 'package:flutter_test/flutter_test.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';

void main() {
  test('hasFilters ignores the sort order', () {
    expect(const DiscoverFilters().hasFilters, isFalse);
    expect(
      const DiscoverFilters(sort: DiscoverSort.ratingAsc).hasFilters,
      isFalse,
    );
  });

  test('hasFilters is true for every other field', () {
    expect(const DiscoverFilters(genreIds: {1}).hasFilters, isTrue);
    expect(const DiscoverFilters(minRating: 7).hasFilters, isTrue);
    expect(const DiscoverFilters(fromYear: 2000).hasFilters, isTrue);
    expect(const DiscoverFilters(toYear: 2000).hasFilters, isTrue);
    expect(const DiscoverFilters(languageCode: 'ko').hasFilters, isTrue);
    expect(const DiscoverFilters(minRuntime: 90).hasFilters, isTrue);
    expect(const DiscoverFilters(maxRuntime: 90).hasFilters, isTrue);
    expect(const DiscoverFilters(studioIds: {1}).hasFilters, isTrue);
  });

  test('copyWith can clear a nullable field', () {
    final f = const DiscoverFilters(minRating: 7).copyWith(minRating: () => null);
    expect(f.minRating, isNull);
  });
}

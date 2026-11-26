import 'package:equatable/equatable.dart';
import 'package:movify/shared/domain/entites/keyword.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';

/// Everything the user can filter a See all list by. A null/empty field means
/// "no filter". Genre ids belong to the kind the filters are used with
/// (movie and tv ids differ; see GenreMapping).
class DiscoverFilters extends Equatable {
  const DiscoverFilters({
    this.sort = DiscoverSort.popularity,
    this.genreIds = const {},
    this.minRating,
    this.fromYear,
    this.toYear,
    this.languageCode,
    this.minRuntime,
    this.maxRuntime,
    this.studioIds = const {},
    this.keywords = const {},
  });

  final DiscoverSort sort;
  final Set<int> genreIds;

  /// 0-10, matches TMDB `vote_average.gte`.
  final double? minRating;
  final int? fromYear;
  final int? toYear;

  /// ISO 639-1, e.g. `en`.
  final String? languageCode;
  final int? minRuntime;
  final int? maxRuntime;

  /// TMDB company ids.
  final Set<int> studioIds;

  /// TMDB keywords filter.
  final Set<Keyword> keywords;

  /// True when anything other than the sort order is set.
  bool get hasFilters =>
      genreIds.isNotEmpty ||
      minRating != null ||
      fromYear != null ||
      toYear != null ||
      languageCode != null ||
      minRuntime != null ||
      maxRuntime != null ||
      studioIds.isNotEmpty ||
      keywords.isNotEmpty;

  DiscoverFilters copyWith({
    DiscoverSort? sort,
    Set<int>? genreIds,
    double? Function()? minRating,
    int? Function()? fromYear,
    int? Function()? toYear,
    String? Function()? languageCode,
    int? Function()? minRuntime,
    int? Function()? maxRuntime,
    Set<int>? studioIds,
    Set<Keyword>? keywords,
  }) => DiscoverFilters(
    sort: sort ?? this.sort,
    genreIds: genreIds ?? this.genreIds,
    minRating: minRating != null ? minRating() : this.minRating,
    fromYear: fromYear != null ? fromYear() : this.fromYear,
    toYear: toYear != null ? toYear() : this.toYear,
    languageCode: languageCode != null ? languageCode() : this.languageCode,
    minRuntime: minRuntime != null ? minRuntime() : this.minRuntime,
    maxRuntime: maxRuntime != null ? maxRuntime() : this.maxRuntime,
    studioIds: studioIds ?? this.studioIds,
    keywords: keywords ?? this.keywords,
  );

  @override
  List<Object?> get props => [
    sort,
    genreIds,
    minRating,
    fromYear,
    toYear,
    languageCode,
    minRuntime,
    maxRuntime,
    studioIds,
    keywords,
  ];
}

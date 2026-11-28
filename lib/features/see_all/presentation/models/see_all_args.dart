import 'package:equatable/equatable.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

/// Picture and blurb shown above a curated list (a collection) while the list
/// still has the query it opened with.
class SeeAllHeroData extends Equatable {
  const SeeAllHeroData({required this.imagePath, required this.description});

  /// TMDB image path.
  final String imagePath;
  final String description;

  @override
  List<Object?> get props => [imagePath, description];
}

/// What a See all screen was opened with (passed as GoRouter `extra`).
///
/// Two shapes:
///  - fixed: [fixedEndPoint] is set (In theater now, On the air, ...). No
///    filters, no Movies/Series switch, no Reset.
///  - discover: everything else. [kind] and [filters] are the starting query
///    and the user can change both.
class SeeAllArgs extends Equatable {
  const SeeAllArgs.discover({
    required this.kind,
    this.filters = const DiscoverFilters(),
    this.title,
    this.hero,
  }) : fixedEndPoint = null;

  const SeeAllArgs.fixed({
    required this.kind,
    required String endPoint,
    this.title,
  })  : fixedEndPoint = endPoint,
        filters = const DiscoverFilters(),
        hero = null;

  /// [ContentType.movies] or [ContentType.series].
  final ContentType kind;
  final DiscoverFilters filters;
  final String? fixedEndPoint;
  final String? title;
  final SeeAllHeroData? hero;

  bool get isFixed => fixedEndPoint != null;

  @override
  List<Object?> get props => [kind, filters, fixedEndPoint, title, hero];
}

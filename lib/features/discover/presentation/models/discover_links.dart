import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/models/discover_collection.dart';
import 'package:movify/features/discover/presentation/models/mood.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

/// Every Discover tile ends in the same place: a See all list with a starting
/// query. These build that query.
extension DiscoverLinks on BuildContext {
  void _openSeeAll(SeeAllArgs args) =>
      pushNamed(RouteName.seeAll, extra: args);

  void openGenre(ContentType kind, int id, String name) => _openSeeAll(
    SeeAllArgs.discover(
      kind: kind,
      filters: DiscoverFilters(genreIds: {id}),
      title: name,
    ),
  );

  void openMood(ContentType kind, Mood mood) => _openSeeAll(
    SeeAllArgs.discover(
      kind: kind,
      filters: DiscoverFilters(genreIds: mood.genresFor(kind), anyGenre: true),
      title: mood.label,
    ),
  );

  void openCollection(ContentType kind, DiscoverCollection collection) =>
      _openSeeAll(
        SeeAllArgs.discover(
          kind: kind,
          filters: DiscoverFilters(keywords: {collection.keyword}),
          title: collection.name,
          hero: SeeAllHeroData(
            imagePath: collection.pictureFor(kind),
            description: collection.description,
          ),
        ),
      );

  /// [decade] is the first year, e.g. 1990 for the 1990s.
  void openDecade(ContentType kind, int decade) => _openSeeAll(
    SeeAllArgs.discover(
      kind: kind,
      filters: DiscoverFilters(fromYear: decade, toYear: decade + 9),
      title: '${decade}s',
    ),
  );
}

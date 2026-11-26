import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/search/presentation/widgets/search_empty_state.dart';
import 'package:movify/features/search/presentation/widgets/search_keyword_tile.dart';
import 'package:movify/features/search/presentation/widgets/search_list_skeleton.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/entites/keyword.dart';

/// Paginated list of keyword results. Tapping opens SeeAll filtered by this keyword.
class SearchKeywordsList extends StatelessWidget {
  const SearchKeywordsList({super.key});

  void _onKeywordTap(BuildContext context, Keyword keyword) {
    context.pushNamed(
      RouteName.seeAll,
      extra: SeeAllArgs.discover(
        kind: ContentType.movies,
        filters: DiscoverFilters(keywords: {keyword}),
        title: keyword.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SliverPagedGrid<Keyword>(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisExtent: 52,
      mainAxisSpacing: Space.xsm,
    ),
    loadingBuilder: (context) => const SearchListSkeleton(),
    emptyBuilder: (context) => const SearchEmptyState(
      title: 'No keywords found',
      message:
          'Try searching for generic topics like "space", "zombie", or "heist".',
    ),
    itemBuilder: (context, keyword, index) => SearchKeywordTile(
      keyword: keyword,
      onTap: () => _onKeywordTap(context, keyword),
    ),
  );
}

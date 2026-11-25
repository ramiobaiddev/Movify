import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_empty_state.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_grid_skeleton.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Responsive paginated poster grid powered by SliverPagedGrid and SeeAllCubit.
class SeeAllPosterGrid extends StatelessWidget {
  const SeeAllPosterGrid({super.key});

  void _openDetails(BuildContext context, CardDisplayModel item) {
    final routeName = item.contentType == ContentType.movies
        ? RouteName.movieDetail
        : RouteName.tvDetail;

    context.pushNamed(
      routeName,
      pathParameters: {'id': item.id.toString()},
      extra: item.toNavigationData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    // 2 columns on phone, 3–4 columns on tablet
    final int columns = screenWidth >= 900 ? 4 : (screenWidth >= 600 ? 4 : 3);
    final double cardWidth =
        (screenWidth - (Space.lg * 2) - ((columns - 1) * Space.md)) / columns;
    final double cardHeight = PosterRowMetrics.height(
      context,
      width: cardWidth,
    );
    final double childAspectRatio = cardWidth / cardHeight;

    return SliverPagedGrid<CardDisplayModel>(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: Space.md,
        mainAxisSpacing: Space.lg,
        childAspectRatio: childAspectRatio,
      ),
      loadingBuilder: (context) => SeeAllGridSkeleton(
        columns: columns,
        childAspectRatio: childAspectRatio,
      ),
      emptyBuilder: (context) => const SeeAllEmptyState(),
      itemBuilder: (context, item, index) => PosterCard(
        imageUrl: tmdbImageSize(TmdbImageSize.w500, item.posterPath),
        title: item.title,
        subtitle: item.year,
        rating: item.rating,
        onTap: () => _openDetails(context, item),
      ),
    );
  }
}

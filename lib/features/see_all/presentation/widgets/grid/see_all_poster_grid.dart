import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/presentation/models/favorite_card_mapper.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_empty_state.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_grid_skeleton.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/poster_grid_layout.dart';

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
    final layout = PosterGridLayout.of(context);

    return SliverPagedGrid<CardDisplayModel>(
      gridDelegate: layout.delegate,
      loadingBuilder: (context) => SeeAllGridSkeleton(
        columns: layout.columns,
        childAspectRatio: layout.childAspectRatio,
      ),
      emptyBuilder: (context) => const SeeAllEmptyState(),
      itemBuilder: (context, item, index) => PosterCard(
        imageUrl: tmdbImageSize(TmdbImageSize.w500, item.posterPath),
        title: item.title,
        subtitle: item.year,
        rating: item.rating,
        actionButton: FavoriteButton(
          favoriteEntity: item.toFavorite(),
          size: PosterRowMetrics.heartSize,
        ),
        onTap: () => _openDetails(context, item),
      ),
    );
  }
}

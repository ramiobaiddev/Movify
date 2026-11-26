import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/widgets/search_empty_state.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_grid_skeleton.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/widgets/poster_grid_layout.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Paginated poster grid for Search results (Movies & Series, Movies, Series).
class SearchPosterGrid extends StatelessWidget {
  const SearchPosterGrid({super.key, this.isMulti = false});

  final bool isMulti;

  void _onItemTapped(BuildContext context, CardDisplayModel item) {
    // Save to search history
    context.read<SearchCubit>().addToHistory(
      SearchHistoryEntity(
        id: item.id,
        title: item.title,
        posterPath: item.backdropPath ?? item.posterPath,
        historyContentType: item.contentType,
        searchedAt: DateTime.now(),
        rating: item.rating ?? 0,
        date: item.year,
      ),
    );

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
      emptyBuilder: (context) => const SearchEmptyState(),
      itemBuilder: (context, item, index) {
        final subtitle = isMulti
            ? '${item.contentType == ContentType.movies ? "Movie" : "Series"}${item.year.isNotEmpty ? " · ${item.year}" : ""}'
            : item.year;

        return PosterCard(
          imageUrl: tmdbImageSize(TmdbImageSize.w500, item.posterPath),
          title: item.title,
          subtitle: subtitle,
          rating: item.rating,
          onTap: () => _onItemTapped(context, item),
        );
      },
    );
  }
}

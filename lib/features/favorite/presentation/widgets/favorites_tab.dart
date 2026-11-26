import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_cubit.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';
import 'package:movify/features/favorite/presentation/cubits/sign_in_prompt_cubit.dart';
import 'package:movify/features/favorite/presentation/models/favorite_card_mapper.dart';
import 'package:movify/features/favorite/presentation/models/favorite_sort.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_actions_sheet.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_empty_state.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_sign_in_card.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_grid_skeleton.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/keep_alive_wrapper.dart';
import 'package:movify/shared/presentation/widgets/poster_grid_layout.dart';

/// One tab (movies or series) of the Favorites screen. Each tab keeps its own
/// sort.
class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key, required this.kind});

  final ContentType kind;

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  FavoriteSort _sort = FavoriteSort.recentlyAdded;

  Future<void> _pickSort() async {
    final picked = await AppSelectionBottomSheet.show<FavoriteSort>(
      context,
      title: 'Sort by',
      options: [for (final s in FavoriteSort.values) (s.label, s)],
      selectedValue: _sort,
    );
    if (picked != null && mounted) {
      setState(() => _sort = picked);
    }
  }

  void _open(FavoriteEntity item) {
    final card = item.toCardDisplay();
    context.pushNamed(
      card.contentType == ContentType.movies
          ? RouteName.movieDetail
          : RouteName.tvDetail,
      pathParameters: {'id': card.id.toString()},
      extra: card.toNavigationData(),
    );
  }

  @override
  Widget build(BuildContext context) => KeepAliveWrapper(
    child: BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) => switch (state) {
        FavoriteInitial() || FavoriteLoading() => const _TabSkeleton(),
        FavoriteError(:final message) => PagedErrorView(
          message: message,
          onRetry: context.read<FavoriteCubit>().loadFavorites,
        ),
        FavoriteLoaded() => _buildLoaded(context, state),
      },
    ),
  );

  Widget _buildLoaded(BuildContext context, FavoriteLoaded state) {
    final items = _sort.apply(state.ofType(widget.kind));
    if (items.isEmpty) {
      return FavoriteEmptyState(kind: widget.kind);
    }

    final layout = PosterGridLayout.of(context);

    return RefreshIndicator(
      onRefresh: context.read<FavoriteCubit>().refreshFromCloud,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          if (state.isGuest)
            SliverToBoxAdapter(
              child: BlocBuilder<SignInPromptCubit, SignInPromptState>(
                builder: (context, prompt) {
                  final cubit = context.read<SignInPromptCubit>();
                  if (!prompt.canShow(cubit.now)) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Space.lg,
                      Space.lg,
                      Space.lg,
                      0,
                    ),
                    child: FavoriteSignInCard(onDismiss: cubit.dismiss),
                  );
                },
              ),
            ),
          SliverToBoxAdapter(
            child: _CountAndSortRow(
              kind: widget.kind,
              count: items.length,
              sort: _sort,
              onSortTap: _pickSort,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              Space.lg,
              0,
              Space.lg,
              Space.x3xl,
            ),
            sliver: SliverGrid.builder(
              gridDelegate: layout.delegate,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return PosterCard(
                  key: ValueKey('${item.contentType.name}_${item.specificId}'),
                  imageUrl: tmdbImageSize(TmdbImageSize.w500, item.posterImage),
                  title: item.title,
                  subtitle: item.toCardDisplay().year,
                  rating: item.rating,
                  onTap: () => _open(item),
                  onLongPress: () => FavoriteActionsSheet.show(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CountAndSortRow extends StatelessWidget {
  const _CountAndSortRow({
    required this.kind,
    required this.count,
    required this.sort,
    required this.onSortTap,
  });

  final ContentType kind;
  final int count;
  final FavoriteSort sort;
  final VoidCallback onSortTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final noun = kind == ContentType.movies
        ? (count == 1 ? 'Movie' : 'Movies')
        : 'Series';

    return Padding(
      padding: const EdgeInsets.all(Space.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count $noun',
            style: textTheme.titleMedium?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: onSortTap,
            behavior: HitTestBehavior.opaque,
            child: Row(
              spacing: Space.sm,
              children: [
                Text(
                  sort.label,
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.primary300,
                  ),
                ),
                Icon(Icons.swap_vert_rounded, color: colors.primary300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabSkeleton extends StatelessWidget {
  const _TabSkeleton();

  @override
  Widget build(BuildContext context) {
    final layout = PosterGridLayout.of(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: Space.lg),
      child: SeeAllGridSkeleton(
        columns: layout.columns,
        childAspectRatio: layout.childAspectRatio,
      ),
    );
  }
}

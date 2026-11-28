import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_cubit.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_state.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/see_all_filter_bar.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_poster_grid.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/sort_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sort_row/see_all_sort_row.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_hero.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Body of SeeAllView using pure widget composition matching Figma See All flow.
class SeeAllViewBody extends StatelessWidget {
  const SeeAllViewBody({super.key, required this.args});

  final SeeAllArgs args;

  String _resolveTitle(BuildContext context, SeeAllState state) {
    // The row's own title only fits the query it opened with; once the kind
    // or any filter changes (including Reset) fall back to a neutral title.
    final unchanged = state.kind == args.kind && state.filters == args.filters;
    if (args.title != null && unchanged) {
      return args.title!;
    }
    if (state.filters.genreIds.isNotEmpty) {
      final firstGenreId = state.filters.genreIds.first;
      if (state.kind == ContentType.movies) {
        final match = MovieGenre.values.where((g) => g.id == firstGenreId);
        if (match.isNotEmpty) {
          return match.first.localizedText(context);
        }
      } else {
        final match = TvGenre.values.where((g) => g.id == firstGenreId);
        if (match.isNotEmpty) {
          return match.first.localizedText(context);
        }
      }
    }
    return state.kind == ContentType.movies ? 'Movies' : 'Series';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SeeAllCubit>();
    final state = cubit.state;
    final title = _resolveTitle(context, state);
    final hasFilters = state.filters.hasFilters;
    final unchanged = state.kind == args.kind && state.filters == args.filters;
    final hero = unchanged ? args.hero : null;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── 1. Top Bar: Back Button, Title, and Reset Button ──
        // A collection shows its picture instead, until the query changes.
        if (hero != null)
          SliverToBoxAdapter(
            child: SizedBox(
              height: SeeAllHero.height,
              // The screen pads the list; the picture goes edge to edge.
              child: OverflowBox(
                minWidth: MediaQuery.widthOf(context),
                maxWidth: MediaQuery.widthOf(context),
                child: SeeAllHero(
                  title: args.title ?? title,
                  hero: hero,
                  onBack: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: SeeAllTopBar(
                title: title,
                showResetButton: !args.isFixed && hasFilters,
                onBackTap: () => Navigator.of(context).maybePop(),
                onResetTap: cubit.reset,
              ),
            ),
          ),

        // ── 2. Horizontal Filter Bar: Media Switcher & Chips ──
        if (!args.isFixed) ...[
          const SliverToBoxAdapter(child: SizedBox(height: Space.sm)),
          SliverToBoxAdapter(
            child: SeeAllFilterBar(
              kind: state.kind,
              filters: state.filters,
              onKindChanged: cubit.setKind,
              onFiltersChanged: cubit.applyFilters,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: Space.md)),

          // ── 3. Sort Row: "Popularity ↑" Indicator ──
          SliverToBoxAdapter(
            child: SeeAllSortRow(
              sort: state.filters.sort,
              onTap: () => SortBottomSheet.show(
                context,
                kind: state.kind,
                selectedSort: state.filters.sort,
                onSelectSort: (newSort) => cubit.applyFilters(
                  state.filters.copyWith(sort: newSort),
                ),
              ),
            ),
          ),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: Space.md)),

        // ── 4. Responsive Poster Grid ──
        BlocProvider<PagedCubit<CardDisplayModel>>.value(
          key: ValueKey(state.revision),
          value: state.list,
          child: const SeeAllPosterGrid(),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: Space.x2xl)),
      ],
    );
  }
}

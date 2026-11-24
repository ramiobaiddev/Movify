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
import 'package:movify/features/see_all/presentation/widgets/sheets/genre_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/language_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/rating_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/release_date_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/runtime_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/sort_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/studio_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sort_row/see_all_sort_row.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Body of SeeAllView using pure widget composition matching Figma See All flow.
class SeeAllViewBody extends StatelessWidget {
  const SeeAllViewBody({super.key, required this.args});

  final SeeAllArgs args;

  String _resolveTitle(BuildContext context, SeeAllState state) {
    if (args.title != null) {
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

  bool _hasActiveFilters(DiscoverFilters filters) =>
      filters.genreIds.isNotEmpty ||
      filters.minRating != null ||
      filters.fromYear != null ||
      filters.toYear != null ||
      filters.languageCode != null ||
      filters.minRuntime != null ||
      filters.maxRuntime != null ||
      filters.studioIds.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SeeAllCubit>();
    final state = cubit.state;
    final title = _resolveTitle(context, state);
    final hasFilters = _hasActiveFilters(state.filters);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── 1. Top Bar: Back Button, Title, and Reset Button ──
        SliverToBoxAdapter(
          child: SeeAllTopBar(
            title: title,
            showResetButton: !args.isFixed && hasFilters,
            onBackTap: () => Navigator.of(context).maybePop(),
            onResetTap: cubit.reset,
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
              onOpenGenres: () => GenreBottomSheet.show(
                context,
                kind: state.kind,
                initialGenreIds: state.filters.genreIds,
                onApply: (newIds) => cubit.applyFilters(
                  state.filters.copyWith(genreIds: newIds),
                ),
              ),
              onClearGenres: () => cubit.applyFilters(
                state.filters.copyWith(genreIds: const {}),
              ),
              onOpenRating: () => RatingBottomSheet.show(
                context,
                selectedRating: state.filters.minRating,
                onSelectRating: (rating) => cubit.applyFilters(
                  state.filters.copyWith(minRating: () => rating),
                ),
              ),
              onClearRating: () => cubit.applyFilters(
                state.filters.copyWith(minRating: () => null),
              ),
              onOpenReleaseDate: () => ReleaseDateBottomSheet.show(
                context,
                fromYear: state.filters.fromYear,
                toYear: state.filters.toYear,
                onSelectYears: (from, to) => cubit.applyFilters(
                  state.filters.copyWith(
                    fromYear: () => from,
                    toYear: () => to,
                  ),
                ),
              ),
              onClearReleaseDate: () => cubit.applyFilters(
                state.filters.copyWith(
                  fromYear: () => null,
                  toYear: () => null,
                ),
              ),
              onOpenLanguage: () => LanguageBottomSheet.show(
                context,
                selectedLanguage: state.filters.languageCode,
                onSelectLanguage: (code) => cubit.applyFilters(
                  state.filters.copyWith(languageCode: () => code),
                ),
              ),
              onClearLanguage: () => cubit.applyFilters(
                state.filters.copyWith(languageCode: () => null),
              ),
              onOpenRuntime: () => RuntimeBottomSheet.show(
                context,
                minRuntime: state.filters.minRuntime,
                maxRuntime: state.filters.maxRuntime,
                onSelectRuntime: (min, max) => cubit.applyFilters(
                  state.filters.copyWith(
                    minRuntime: () => min,
                    maxRuntime: () => max,
                  ),
                ),
              ),
              onClearRuntime: () => cubit.applyFilters(
                state.filters.copyWith(
                  minRuntime: () => null,
                  maxRuntime: () => null,
                ),
              ),
              onOpenStudios: () => StudioBottomSheet.show(
                context,
                kind: state.kind,
                initialStudioIds: state.filters.studioIds,
                onApply: (newIds) => cubit.applyFilters(
                  state.filters.copyWith(studioIds: newIds),
                ),
              ),
              onClearStudios: () => cubit.applyFilters(
                state.filters.copyWith(studioIds: const {}),
              ),
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

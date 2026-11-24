import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_state.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';
import 'package:movify/shared/domain/genre_mapping.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Owns the query of one See all screen. Every query change builds a new
/// [PagedCubit], so a slow response from the old query can never land in the
/// new list.
class SeeAllCubit extends Cubit<SeeAllState> {
  SeeAllCubit({required SeeAllArgs args, required FeedFetchers fetchers})
    : _args = args,
      _fetchers = fetchers,
      super(
        SeeAllState(
          kind: args.kind,
          filters: args.filters,
          list: _buildList(fetchers, args, args.kind, args.filters)..load(),
          revision: 0,
        ),
      );

  final SeeAllArgs _args;
  final FeedFetchers _fetchers;

  static PagedCubit<CardDisplayModel> _buildList(
    FeedFetchers fetchers,
    SeeAllArgs args,
    ContentType kind,
    DiscoverFilters filters,
  ) => PagedCubit(
    args.isFixed
        ? fetchers.fixed(kind, args.fixedEndPoint!)
        : fetchers.discover(kind, filters),
  );

  void _replace({
    required ContentType kind,
    required DiscoverFilters filters,
    Set<int> dropped = const {},
  }) {
    final old = state.list;
    emit(
      SeeAllState(
        kind: kind,
        filters: filters,
        list: _buildList(_fetchers, _args, kind, filters)..load(),
        revision: state.revision + 1,
        droppedGenreIds: dropped,
      ),
    );
    old.close();
  }

  /// Movies / Series switch. Genres are mapped by name (unmatched ones are
  /// dropped and reported in [SeeAllState.droppedGenreIds]); studios are
  /// cleared; rating, years, language and runtime are kept.
  void setKind(ContentType kind) {
    if (_args.isFixed || kind == state.kind) {
      return;
    }
    final genres = GenreMapping.convert(
      state.filters.genreIds,
      from: state.kind,
      to: kind,
    );
    final sort =
        (kind == ContentType.series &&
            (state.filters.sort == DiscoverSort.revenueDesc ||
                state.filters.sort == DiscoverSort.revenueAsc))
        ? DiscoverSort.popularityDesc
        : state.filters.sort;
    _replace(
      kind: kind,
      filters: state.filters.copyWith(
        sort: sort,
        genreIds: genres.mapped,
        studioIds: const {},
      ),
      dropped: genres.dropped,
    );
  }

  void applyFilters(DiscoverFilters filters) {
    if (_args.isFixed || filters == state.filters) {
      return;
    }
    _replace(kind: state.kind, filters: filters);
  }

  /// Clears every filter and the sort, keeps the media type.
  void reset() {
    if (_args.isFixed) {
      return;
    }
    _replace(kind: state.kind, filters: const DiscoverFilters());
  }

  void clearNotice() {
    if (state.droppedGenreIds.isEmpty) {
      return;
    }
    emit(
      SeeAllState(
        kind: state.kind,
        filters: state.filters,
        list: state.list,
        revision: state.revision,
      ),
    );
  }

  @override
  Future<void> close() {
    state.list.close();
    return super.close();
  }
}

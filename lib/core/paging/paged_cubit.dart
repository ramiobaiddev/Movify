import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/errors/failure.dart';
import 'package:movify/core/paging/paged_state.dart';
import 'package:movify/core/pagination/domain/entites/page_result.dart';

/// Fetches one page (1-based). Filters, sort order and endpoints are captured
/// by the closure, so the cubit needs no params type:
///
///   PagedCubit<MovieEntity>(
///     (page) => getMovies(page: page, endPoint: 'popular'),
///   )
///
/// To change filters, create a new cubit (e.g. give the BlocProvider a new
/// key) instead of mutating this one.
typedef PageFetcher<T> =
    Future<Either<Failure, PageResult<T>>> Function(int page);

class PagedCubit<T> extends Cubit<PagedState<T>> {
  PagedCubit(this._fetch) : super(const PagedState());

  final PageFetcher<T> _fetch;

  /// Bumped on every first-page load, so a slow response that belongs to an
  /// older load (or an older list) is thrown away instead of overwriting
  /// fresher data.
  int _generation = 0;

  /// Safe to call from `initState`/`build` repeatedly: loads only once.
  Future<void> load() async {
    if (state.status != PagedStatus.initial) {
      return;
    }
    await _loadFirstPage();
  }

  /// Pull-to-refresh / retry after a first-page error. Keeps the old items
  /// on screen while loading.
  Future<void> refresh() => _loadFirstPage();

  Future<void> _loadFirstPage() async {
    final generation = ++_generation;
    emit(
      state.copyWith(
        status: PagedStatus.loading,
        isLoadingMore: false,
        clearError: true,
      ),
    );

    final result = await _fetch(1);
    if (isClosed || generation != _generation) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PagedStatus.failure,
          error: failure.errorMessage,
        ),
      ),
      (data) => emit(
        PagedState<T>(
          items: data.results,
          status: PagedStatus.success,
          page: 1,
          totalPages: data.totalPages,
        ),
      ),
    );
  }

  /// Called when the list scrolls near its end. Ignored while a page is
  /// loading, when there are no more pages, and after a load-more error
  /// (use [retryLoadMore] so a failing request is not hammered by scrolling).
  Future<void> loadMore() async {
    if (!state.canLoadMore) {
      return;
    }

    final generation = _generation;
    final nextPage = state.page + 1;
    emit(state.copyWith(isLoadingMore: true, clearError: true));

    final result = await _fetch(nextPage);
    if (isClosed || generation != _generation) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, error: failure.errorMessage),
      ),
      (data) => emit(
        state.copyWith(
          items: [...state.items, ...data.results],
          page: nextPage,
          totalPages: data.totalPages,
          isLoadingMore: false,
        ),
      ),
    );
  }

  /// Retry button at the end of the list after a load-more error.
  Future<void> retryLoadMore() async {
    if (!state.hasLoadMoreError) {
      return;
    }
    emit(state.copyWith(clearError: true));
    await loadMore();
  }
}

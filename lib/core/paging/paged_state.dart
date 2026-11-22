import 'package:equatable/equatable.dart';

enum PagedStatus { initial, loading, success, failure }

/// State of ONE paginated list.
///
/// A row of movies, a grid of search results, a "similar titles" list: each
/// is its own list with its own [PagedCubit], so there is no category map.
class PagedState<T> extends Equatable {
  const PagedState({
    this.items = const [],
    this.status = PagedStatus.initial,
    this.page = 0,
    this.totalPages = 1,
    this.isLoadingMore = false,
    this.error,
  });

  final List<T> items;
  final PagedStatus status;

  /// Last page that was loaded successfully (0 = nothing loaded yet).
  final int page;
  final int totalPages;

  /// The next page is being fetched; show a loader at the end of the list.
  final bool isLoadingMore;

  /// Message of the last failure. With [PagedStatus.failure] it is a
  /// first-page error; with [PagedStatus.success] it is a load-more error
  /// (the list is kept and a retry is shown at the end).
  final String? error;

  /// First load (or reload with nothing to show): show the skeleton.
  bool get isFirstLoading => status == PagedStatus.loading && items.isEmpty;

  /// First load failed and there is nothing to show: show the error view.
  bool get isFirstError => status == PagedStatus.failure && items.isEmpty;

  /// Loaded fine but the server returned nothing.
  bool get isEmpty => status == PagedStatus.success && items.isEmpty;

  /// Loading more failed; list is kept, show a retry at the end.
  bool get hasLoadMoreError => status == PagedStatus.success && error != null;

  bool get canLoadMore =>
      status == PagedStatus.success &&
      !isLoadingMore &&
      error == null &&
      page < totalPages;

  PagedState<T> copyWith({
    List<T>? items,
    PagedStatus? status,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
    String? error,
    bool clearError = false,
  }) => PagedState<T>(
    items: items ?? this.items,
    status: status ?? this.status,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    error: clearError ? null : (error ?? this.error),
  );

  @override
  List<Object?> get props => [
    items,
    status,
    page,
    totalPages,
    isLoadingMore,
    error,
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/paged_state.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';

/// Horizontal list that shows whatever the nearest [PagedCubit]<T> holds and
/// asks it for more when the user scrolls near the end.
///
/// It only decides *where* things go; what an item or a skeleton looks like is
/// up to the caller.
class PagedHorizontalList<T> extends StatefulWidget {
  const PagedHorizontalList({
    super.key,
    required this.height,
    required this.itemBuilder,
    required this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.itemGap = Space.md,
    this.padding = const EdgeInsets.symmetric(horizontal: Space.lg),
    this.loadMoreThreshold = 200,
  });

  final double height;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Skeleton shown while the first page loads.
  final WidgetBuilder loadingBuilder;

  /// First-page error. Default: message + retry button.
  final Widget Function(BuildContext context, String message, VoidCallback retry)?
  errorBuilder;

  /// Default: nothing (the row collapses).
  final WidgetBuilder? emptyBuilder;

  final double itemGap;
  final EdgeInsets padding;

  /// Distance from the end (px) at which the next page is requested.
  final double loadMoreThreshold;

  @override
  State<PagedHorizontalList<T>> createState() =>
      _PagedHorizontalListState<T>();
}

class _PagedHorizontalListState<T> extends State<PagedHorizontalList<T>> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - widget.loadMoreThreshold) {
      context.read<PagedCubit<T>>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PagedCubit<T>>();
    return BlocBuilder<PagedCubit<T>, PagedState<T>>(
      builder: (context, state) {
        if (state.isFirstLoading || state.status == PagedStatus.initial) {
          return SizedBox(
            height: widget.height,
            child: widget.loadingBuilder(context),
          );
        }
        if (state.isFirstError) {
          final message = state.error ?? '';
          return SizedBox(
            height: widget.height,
            child:
                widget.errorBuilder?.call(context, message, cubit.refresh) ??
                PagedErrorView(message: message, onRetry: cubit.refresh),
          );
        }
        if (state.isEmpty) {
          return widget.emptyBuilder?.call(context) ?? const SizedBox.shrink();
        }

        final hasTail = state.isLoadingMore || state.hasLoadMoreError;
        return SizedBox(
          height: widget.height,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            padding: widget.padding,
            itemCount: state.items.length + (hasTail ? 1 : 0),
            separatorBuilder: (_, _) => SizedBox(width: widget.itemGap),
            itemBuilder: (context, index) {
              if (index < state.items.length) {
                return widget.itemBuilder(context, state.items[index], index);
              }
              return state.hasLoadMoreError
                  ? Center(
                      child: IconButton(
                        onPressed: cubit.retryLoadMore,
                        icon: const Icon(Icons.refresh),
                      ),
                    )
                  : const Center(
                      child: SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}

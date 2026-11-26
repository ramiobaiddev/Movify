import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/paged_state.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';

/// A paginated grid as a sliver, for See all / search / discover screens that
/// have their own header, chips or app bar in a [CustomScrollView].
///
/// There is no scroll controller: the next page is requested when an item
/// near the end gets built ([prefetchDistance] items before the last one).
class SliverPagedGrid<T> extends StatelessWidget {
  const SliverPagedGrid({
    super.key,
    required this.gridDelegate,
    required this.itemBuilder,
    required this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.prefetchDistance = 6,
    this.padding = const EdgeInsets.symmetric(horizontal: Space.lg),
  });

  final SliverGridDelegate gridDelegate;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final WidgetBuilder loadingBuilder;
  final Widget Function(
    BuildContext context,
    String message,
    VoidCallback retry,
  )?
  errorBuilder;
  final WidgetBuilder? emptyBuilder;
  final int prefetchDistance;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PagedCubit<T>>();
    return BlocBuilder<PagedCubit<T>, PagedState<T>>(
      builder: (context, state) {
        if (state.isFirstLoading || state.status == PagedStatus.initial) {
          return SliverToBoxAdapter(child: loadingBuilder(context));
        }
        if (state.isFirstError) {
          final message = state.error ?? '';
          return SliverFillRemaining(
            hasScrollBody: false,
            child:
                errorBuilder?.call(context, message, cubit.refresh) ??
                PagedErrorView(message: message, onRetry: cubit.refresh),
          );
        }
        if (state.isEmpty) {
          return SliverToBoxAdapter(
            child: emptyBuilder?.call(context) ?? const SizedBox.shrink(),
          );
        }

        return SliverMainAxisGroup(
          slivers: [
            SliverGrid(
              gridDelegate: gridDelegate,
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index >= state.items.length - prefetchDistance &&
                    state.canLoadMore) {
                  // Not during build: loadMore emits a new state.
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => cubit.loadMore(),
                  );
                }
                return itemBuilder(context, state.items[index], index);
              }, childCount: state.items.length),
            ),
            if (state.isLoadingMore)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(Space.lg),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
            if (state.hasLoadMoreError)
              SliverToBoxAdapter(
                child: Center(
                  child: IconButton(
                    onPressed: cubit.retryLoadMore,
                    icon: const Icon(Icons.refresh),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

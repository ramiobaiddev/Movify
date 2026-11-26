import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:movify/features/search/presentation/views/search_results_view.dart';
import 'package:movify/features/search/presentation/widgets/search_history_view.dart';

/// Body of SearchView dynamically switching between initial loading, history, and active results.
class SearchViewBody extends StatelessWidget {
  const SearchViewBody({
    super.key,
    required this.onHistoryItemTap,
  });

  final ValueChanged<SearchHistoryEntity> onHistoryItemTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => switch (state) {
        SearchInitial() => const SizedBox.shrink(),
        SearchHistoryLoaded(:final history) => SearchHistoryView(
          history: history,
          onItemTap: onHistoryItemTap,
          onItemDelete: (item) => context.read<SearchCubit>().deleteFromHistory(
            item.id,
            item.historyContentType,
          ),
          onClearAll: () => context.read<SearchCubit>().clearHistory(),
        ),
        SearchActive() => SearchResultsView(state: state),
      },
    );
  }
}

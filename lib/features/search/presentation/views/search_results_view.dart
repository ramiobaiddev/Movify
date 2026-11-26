import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:movify/features/search/presentation/models/search_tab.dart';
import 'package:movify/features/search/presentation/widgets/search_keywords_list.dart';
import 'package:movify/features/search/presentation/widgets/search_people_list.dart';
import 'package:movify/features/search/presentation/widgets/search_poster_grid.dart';
import 'package:movify/features/search/presentation/widgets/search_tabs_bar.dart';

/// Active results view displaying the tabs bar and the corresponding paginated results.
class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.state});

  final SearchActive state;

  /// Provides the tab's list to its grid. The key changes with every search,
  /// so a new query or tab gets a fresh subtree.
  Widget _results<T>(PagedCubit<T>? list, Widget sliver) {
    if (list == null) {
      return const SizedBox.shrink();
    }
    return BlocProvider<PagedCubit<T>>.value(
      key: ValueKey('${state.tab.name}_${state.revision}'),
      value: list,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: Space.x2xl),
            sliver: sliver,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: Space.lg),
      SearchTabsBar(
        selectedTab: state.tab,
        onTabSelected: (tab) => context.read<SearchCubit>().onTabChanged(tab),
      ),
      const SizedBox(height: Space.x2xl),
      Expanded(
        child: switch (state.tab) {
          SearchTab.moviesAndSeries => _results(
            state.mediaList,
            const SearchPosterGrid(isMulti: true),
          ),
          SearchTab.movies || SearchTab.series => _results(
            state.mediaList,
            const SearchPosterGrid(),
          ),
          SearchTab.people => _results(
            state.peopleList,
            const SearchPeopleList(),
          ),
          SearchTab.keywords => _results(
            state.keywordList,
            SearchKeywordsList(kind: state.mediaKind),
          ),
        },
      ),
    ],
  );
}

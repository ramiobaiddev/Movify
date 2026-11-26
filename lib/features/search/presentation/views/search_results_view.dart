import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
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
          SearchTab.moviesAndSeries =>
            state.mediaList == null
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    key: ValueKey('media_${state.revision}'),
                    value: state.mediaList!,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: Space.x2xl),
                          sliver: SearchPosterGrid(isMulti: true),
                        ),
                      ],
                    ),
                  ),
          SearchTab.movies =>
            state.mediaList == null
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    key: ValueKey('movies_${state.revision}'),
                    value: state.mediaList!,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: Space.x2xl),
                          sliver: SearchPosterGrid(),
                        ),
                      ],
                    ),
                  ),
          SearchTab.series =>
            state.mediaList == null
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    key: ValueKey('series_${state.revision}'),
                    value: state.mediaList!,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: Space.x2xl),
                          sliver: SearchPosterGrid(),
                        ),
                      ],
                    ),
                  ),
          SearchTab.people =>
            state.peopleList == null
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    key: ValueKey('people_${state.revision}'),
                    value: state.peopleList!,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: Space.x2xl),
                          sliver: SearchPeopleList(),
                        ),
                      ],
                    ),
                  ),
          SearchTab.keywords =>
            state.keywordList == null
                ? const SizedBox.shrink()
                : BlocProvider.value(
                    key: ValueKey('keywords_${state.revision}'),
                    value: state.keywordList!,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(bottom: Space.x2xl),
                          sliver: SearchKeywordsList(),
                        ),
                      ],
                    ),
                  ),
        },
      ),
    ],
  );
}

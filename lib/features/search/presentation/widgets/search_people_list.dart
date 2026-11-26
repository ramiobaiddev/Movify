import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/features/search/presentation/widgets/search_empty_state.dart';
import 'package:movify/features/search/presentation/widgets/search_list_skeleton.dart';
import 'package:movify/features/search/presentation/widgets/search_person_tile.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

/// Paginated list of people results powered by SliverPagedGrid.
class SearchPeopleList extends StatelessWidget {
  const SearchPeopleList({super.key});

  @override
  Widget build(BuildContext context) => SliverPagedGrid<PersonItem>(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisExtent: 68,
      mainAxisSpacing: Space.xsm,
    ),
    padding: EdgeInsets.zero,
    loadingBuilder: (context) => const SearchListSkeleton(),
    emptyBuilder: (context) => const SearchEmptyState(
      title: 'No people found',
      message: 'Try checking your spelling for the actor or director name.',
    ),
    itemBuilder: (context, person, index) => SearchPersonTile(
      person: person,
      onTap: () {
        // Future actor details view navigation hook
      },
    ),
  );
}

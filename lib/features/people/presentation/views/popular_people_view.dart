import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/people/domain/use_cases/get_popular_people_use_case.dart';
import 'package:movify/features/search/presentation/widgets/search_list_skeleton.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/cards/person_list_tile.dart';

/// Full list of popular actors.
class PopularPeopleView extends StatelessWidget {
  const PopularPeopleView({super.key, this.fetcher});

  /// Only for tests; the app uses [GetPopularPeopleUseCase].
  final PageFetcher<PersonItem>? fetcher;

  @override
  Widget build(BuildContext context) => BlocProvider<PagedCubit<PersonItem>>(
    create: (_) => PagedCubit<PersonItem>(
      fetcher ?? (page) => getIt<GetPopularPeopleUseCase>()(page: page),
    )..load(),
    child: Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SeeAllTopBar(
                  title: 'Popular actor',
                  showResetButton: false,
                ),
              ),
              SliverPagedGrid<PersonItem>(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 69,
                ),
                loadingBuilder: (_) => const SearchListSkeleton(),
                itemBuilder: (context, person, _) => PersonListTile(
                  person: person,
                  onTap: () => context.pushNamed(
                    RouteName.person,
                    pathParameters: {'id': person.id.toString()},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

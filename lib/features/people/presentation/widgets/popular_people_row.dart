import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/widgets/paged_horizontal_list.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_row_header.dart';
import 'package:movify/features/people/domain/use_cases/get_popular_people_use_case.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/keep_alive_wrapper.dart';
import 'package:movify/shared/presentation/widgets/person_avatar_card.dart';

/// Home row of popular actors. Tapping the header opens the full list.
class PopularPeopleRow extends StatelessWidget {
  const PopularPeopleRow({super.key, this.fetcher});

  /// Only for tests; the app uses [GetPopularPeopleUseCase].
  final PageFetcher<PersonItem>? fetcher;

  @override
  Widget build(BuildContext context) => KeepAliveWrapper(
    child: BlocProvider<PagedCubit<PersonItem>>(
      create: (_) => PagedCubit<PersonItem>(
        fetcher ?? (page) => getIt<GetPopularPeopleUseCase>()(page: page),
      )..load(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeRowHeader(
            title: 'Popular actors',
            onSeeAll: () => context.pushNamed(RouteName.popularPeople),
          ),
          const SizedBox(height: Space.sm),
          PagedHorizontalList<PersonItem>(
            height: PersonAvatarCard.height,
            loadingBuilder: (_) => const _PopularPeopleSkeleton(),
            itemBuilder: (context, person, _) => PersonAvatarCard(
              name: person.name,
              profilePath: person.profilePath,
              subtitle: person.knownForDepartment ?? 'Acting',
              onTap: () => context.pushNamed(
                RouteName.person,
                pathParameters: {'id': person.id.toString()},
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PopularPeopleSkeleton extends StatelessWidget {
  const _PopularPeopleSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: Space.md),
      itemBuilder: (_, _) => Align(
        alignment: Alignment.topCenter,
        child: SizedBox.square(
          dimension: 86,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceGenre,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

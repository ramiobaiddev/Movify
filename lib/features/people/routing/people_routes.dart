import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/routing/route_paths.dart';
import 'package:movify/core/routing/transition/app_transition.dart';
import 'package:movify/features/people/presentation/cubits/person_details_cubit.dart';
import 'package:movify/features/people/presentation/models/person_credits_args.dart';
import 'package:movify/features/people/presentation/views/person_credits_view.dart';
import 'package:movify/features/people/presentation/views/person_view.dart';
import 'package:movify/features/people/presentation/views/popular_people_view.dart';

class PeopleRoutes {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RoutePaths.popularPeople,
      name: RouteName.popularPeople,
      pageBuilder: (context, state) => AppTransitions.cupertino(
        child: const PopularPeopleView(),
        state: state,
      ),
    ),
    GoRoute(
      path: RoutePaths.person,
      name: RouteName.person,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return AppTransitions.cupertino(
          state: state,
          child: BlocProvider(
            key: ValueKey('person-$id'),
            create: (_) => getIt<PersonDetailsCubit>()..load(id),
            child: PersonView(personId: id),
          ),
        );
      },
    ),
    GoRoute(
      path: RoutePaths.personCredits,
      name: RouteName.personCredits,
      pageBuilder: (context, state) => AppTransitions.cupertino(
        child: PersonCreditsView(args: state.extra! as PersonCreditsArgs),
        state: state,
      ),
    ),
  ];
}

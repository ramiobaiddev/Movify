import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/routing/route_paths.dart';
import 'package:movify/core/routing/transition/app_transition.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_cubit.dart';
import 'package:movify/features/details/presentation/cubits/fetch_series_season_details_cubit/fetch_series_season_details_cubit.dart';
import 'package:movify/features/details/presentation/views/details_screen.dart';
import 'package:movify/features/details/presentation/views/episode_view.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/views/reviews_view.dart';
import 'package:movify/features/details/presentation/views/season_screen.dart';

class DetailsRoutes {
  static List<GoRoute> get routes => [
    GoRoute(
      path: RoutePaths.season,
      name: RouteName.season,
      pageBuilder: (context, state) => AppTransitions.fadeThrough(
        child: SeasonScreen(data: state.extra! as SeasonNavData),
        state: state,
      ),
    ),
    GoRoute(
      path: RoutePaths.reviews,
      name: RouteName.reviews,
      pageBuilder: (context, state) => AppTransitions.cupertino(
        child: ReviewsView(reviews: state.extra! as List<ReviewItem>),
        state: state,
      ),
    ),
    GoRoute(
      path: RoutePaths.episode,
      name: RouteName.episode,
      pageBuilder: (context, state) => AppTransitions.slideFromBottom(
        child: BlocProvider(
          create: (context) => getIt.get<FetchSeriesSeasonDetailsCubit>(),
          child: EpisodeView(episodeDataNav: state.extra as EpisodeNavData),
        ),
        state: state,
      ),
    ),
    GoRoute(
      path: RoutePaths.movieDetail,
      name: RouteName.movieDetail,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          key: ValueKey('movie-$id'), // guarantees disposal
          create: (_) => getIt<DetailsCubit>()..load(ContentType.movies, id),
          child: DetailsScreen(data: state.extra! as MovieNavData),
        );
      },
    ),

    GoRoute(
      path: RoutePaths.tvDetail,
      name: RouteName.tvDetail,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);

        return AppTransitions.fadeScaleAnimation(
          state: state,
          child: BlocProvider(
            key: ValueKey('tv-$id'),
            create: (_) => getIt<DetailsCubit>()..load(ContentType.series, id),
            child: DetailsScreen(data: state.extra! as SeriesNavData),
          ),
        );
      },
    ),
  ];
}

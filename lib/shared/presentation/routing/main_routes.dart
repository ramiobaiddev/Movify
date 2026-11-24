import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/routing/route_paths.dart';
import 'package:movify/core/routing/screens/force_update_screen.dart';
import 'package:movify/core/routing/screens/maintenance_screen.dart';
import 'package:movify/core/routing/transition/app_transition.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/views/discover_view.dart';
import 'package:movify/features/favorite/presentation/views/favorite_view.dart';
import 'package:movify/features/home/presentation/views/home_feed_view.dart';
import 'package:movify/features/profile/presentation/views/profile_view.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/features/see_all/presentation/views/see_all_view.dart';
import 'package:movify/shared/presentation/widgets/navigation_views.dart';

class MainRoutes {
  static List<RouteBase> get routes => [
    GoRoute(
      path: RoutePaths.root,
      name: RouteName.root,
      builder: (context, state) =>
          const Center(child: CircularProgressIndicator()),
    ),
    GoRoute(
      path: RoutePaths.maintenance,
      name: RouteName.maintenanceScreen,
      builder: (context, state) => const MaintenanceScreen(),
    ),
    GoRoute(
      path: RoutePaths.forceUpdate,
      name: RouteName.forceUpdateScreen,
      builder: (context, state) => const ForceUpdateScreen(),
    ),
    GoRoute(
      path: RoutePaths.seeAll,
      name: RouteName.seeAll,
      pageBuilder: (context, state) => AppTransitions.cupertino(
        child: SeeAllView(
          args: state.extra as SeeAllArgs? ??
              const SeeAllArgs.discover(kind: ContentType.movies),
        ),
        state: state,
      ),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          NavigationViews(navigationShell: navigationShell),
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.home,
              name: RouteName.home,
              builder: (context, state) => const HomeFeedView(),
            ),
          ],
        ),
        // Discover Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.discover,
              name: RouteName.discover,
              builder: (context, state) => const DiscoverView(),
            ),
          ],
        ),
        // Favorite Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.favorite,
              name: RouteName.favorite,
              builder: (context, state) => const FavoriteView(),
            ),
          ],
        ),
        // Profile Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.profile,
              name: RouteName.profile,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
  ];
}

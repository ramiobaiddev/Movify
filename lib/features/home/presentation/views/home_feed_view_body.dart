import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/home/presentation/widgets/home_hero_section.dart';
import 'package:movify/features/home/presentation/widgets/home_top_bar.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_chip_row.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_fixed_row.dart';
import 'package:movify/features/people/presentation/widgets/popular_people_row.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

class HomeFeedViewBody extends StatelessWidget {
  const HomeFeedViewBody({super.key, this.fetchers});

  final FeedFetchers? fetchers;

  FeedFetchers get _fetchers => fetchers ?? getIt<FeedFetchers>();

  void _openDetails(BuildContext context, CardDisplayModel item) {
    final routeName = item.contentType == ContentType.movies
        ? RouteName.movieDetail
        : RouteName.tvDetail;

    context.pushNamed(
      routeName,
      pathParameters: {'id': item.id.toString()},
      extra: item.toNavigationData(),
    );
  }

  void _openSeeAll(BuildContext context, SeeAllArgs args) {
    context.pushNamed(RouteName.seeAll, extra: args);
  }

  @override
  Widget build(BuildContext context) {
    final f = _fetchers;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── 1. Top Bar (Branding & Action) ──
        const SliverToBoxAdapter(child: HomeTopBar()),

        const SliverToBoxAdapter(child: SizedBox(height: Space.md)),

        // ── 2. Hero 3D Trending Carousel ──
        SliverToBoxAdapter(child: HomeHeroSection(fetchers: f)),

        const SliverToBoxAdapter(child: SizedBox(height: Space.x2xl)),

        // ── 3. Discovery Feed Rows ──
        SliverList.list(
          children: [
            // "For you" (Chip row: Movies / TV shows)
            HomeChipRow(
              rowId: 'for_you',
              title: 'For you',
              fetchers: f,
              filters: const DiscoverFilters(),
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: (kind) => _openSeeAll(
                context,
                SeeAllArgs.discover(kind: kind, title: 'For you'),
              ),
            ),

            const SizedBox(height: Space.xl),

            // "Upcoming movies" (Fixed row)
            HomeFixedRow(
              title: 'Upcoming movies',
              kind: ContentType.movies,
              endPoint: FeedEndpoint.movieUpcoming,
              fetchers: f,
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: () => _openSeeAll(
                context,
                const SeeAllArgs.fixed(
                  kind: ContentType.movies,
                  endPoint: FeedEndpoint.movieUpcoming,
                  title: 'Upcoming movies',
                ),
              ),
            ),

            const SizedBox(height: Space.xl),

            // "Popular actors"
            const PopularPeopleRow(),

            const SizedBox(height: Space.xl),

            // "On the air" (Fixed TV row)
            HomeFixedRow(
              title: 'On the air',
              kind: ContentType.series,
              endPoint: FeedEndpoint.seriesOnTheAir,
              fetchers: f,
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: () => _openSeeAll(
                context,
                const SeeAllArgs.fixed(
                  kind: ContentType.series,
                  endPoint: FeedEndpoint.seriesOnTheAir,
                  title: 'On the air',
                ),
              ),
            ),

            const SizedBox(height: Space.xl),

            // "Airing today" (Fixed TV row)
            HomeFixedRow(
              title: 'Airing today',
              kind: ContentType.series,
              endPoint: FeedEndpoint.seriesAiringToday,
              fetchers: f,
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: () => _openSeeAll(
                context,
                const SeeAllArgs.fixed(
                  kind: ContentType.series,
                  endPoint: FeedEndpoint.seriesAiringToday,
                  title: 'Airing today',
                ),
              ),
            ),

            const SizedBox(height: Space.xl),

            // "In theater now" (Fixed Movie row)
            HomeFixedRow(
              title: 'In theater now',
              kind: ContentType.movies,
              endPoint: FeedEndpoint.movieNowPlaying,
              fetchers: f,
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: () => _openSeeAll(
                context,
                const SeeAllArgs.fixed(
                  kind: ContentType.movies,
                  endPoint: FeedEndpoint.movieNowPlaying,
                  title: 'In theater now',
                ),
              ),
            ),

            const SizedBox(height: Space.xl),

            // "All-time favorites" (Chip row sorted by rating)
            HomeChipRow(
              rowId: 'all_time_favorites',
              title: 'All-time favorites',
              fetchers: f,
              filters: const DiscoverFilters(sort: DiscoverSort.rating),
              onItemTap: (item) => _openDetails(context, item),
              onSeeAll: (kind) => _openSeeAll(
                context,
                SeeAllArgs.discover(
                  kind: kind,
                  filters: const DiscoverFilters(sort: DiscoverSort.rating),
                  title: 'All-time favorites',
                ),
              ),
            ),

            // Space for floating bottom navigation bar
            const SizedBox(height: 120),
          ],
        ),
      ],
    );
  }
}

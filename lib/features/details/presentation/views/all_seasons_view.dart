import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/seasons/sort_toggle.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Every season of a series as a two-column poster grid. Uses the seasons the
/// details screen already loaded, so nothing is fetched here.
class AllSeasonsView extends StatefulWidget {
  const AllSeasonsView({super.key, required this.series});

  final DetailsContent series;

  @override
  State<AllSeasonsView> createState() => _AllSeasonsViewState();
}

class _AllSeasonsViewState extends State<AllSeasonsView> {
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    final series = widget.series;
    final seasons = series.seasons;
    final cardWidth = (MediaQuery.widthOf(context) - Space.lg * 2 - Space.md) / 2;
    final cardHeight = PosterRowMetrics.height(context, width: cardWidth);

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ScreenGutter(
                child: SeeAllTopBar(
                  title: 'Seasons',
                  showResetButton: false,
                  trailing: SortToggle(
                    newestFirst: _newestFirst,
                    onTap: () => setState(() => _newestFirst = !_newestFirst),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                Space.lg,
                Space.lg,
                Space.lg,
                MediaQuery.paddingOf(context).bottom + Space.x3xl,
              ),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Space.md,
                  mainAxisSpacing: Space.lg,
                  childAspectRatio: cardWidth / cardHeight,
                ),
                itemCount: seasons.length,
                itemBuilder: (context, index) {
                  final season = _newestFirst
                      ? seasons[seasons.length - 1 - index]
                      : seasons[index];

                  return PosterCard(
                    imageUrl: tmdbImageSize(
                      TmdbImageSize.w500,
                      season.posterPath ?? series.posterPath ?? '',
                    ),
                    title: season.name,
                    subtitle: season.episodesLabel,
                    rating: season.rating,
                    onTap: () => context.openSeason(series, season),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

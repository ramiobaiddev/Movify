import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/favorite/presentation/models/favorite_card_mapper.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/people/presentation/models/person_credits_args.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/presentation/extensions/open_media_details.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/widgets/poster_grid_layout.dart';

/// Every movie or series of one person. The list is already in memory, so this
/// is a plain grid.
class PersonCreditsView extends StatelessWidget {
  const PersonCreditsView({super.key, required this.args});

  final PersonCreditsArgs args;

  @override
  Widget build(BuildContext context) {
    final layout = PosterGridLayout.of(context);

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SeeAllTopBar(title: args.title, showResetButton: false),
              ),
              SliverGrid.builder(
                gridDelegate: layout.delegate,
                itemCount: args.items.length,
                itemBuilder: (context, index) {
                  final item = args.items[index];
                  return PosterCard(
                    imageUrl: tmdbImageSize(
                      TmdbImageSize.w500,
                      item.posterPath,
                    ),
                    title: item.title,
                    subtitle: item.year,
                    rating: item.rating,
                    actionButton: FavoriteButton(
                      favoriteEntity: item.toFavorite(),
                      size: PosterRowMetrics.heartSize,
                    ),
                    onTap: () => context.openMediaDetails(item),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + Space.xl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

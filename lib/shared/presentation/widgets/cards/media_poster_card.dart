import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/favorite/presentation/models/favorite_card_mapper.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Poster of one movie or series with its rating, heart and year.
///
/// Used by every poster row (Home, actor credits, Details related rows).
class MediaPosterCard extends StatelessWidget {
  const MediaPosterCard({
    super.key,
    required this.item,
    required this.onTap,
    this.width = PosterRowMetrics.posterWidth,
  });

  final CardDisplayModel item;
  final VoidCallback onTap;
  /// Null lets the card fill its parent (grids).
  final double? width;

  @override
  Widget build(BuildContext context) => PosterCard(
    width: width,
    imageUrl: tmdbImageSize(TmdbImageSize.w500, item.posterPath),
    title: item.title,
    subtitle: item.year,
    rating: item.rating,
    actionButton: FavoriteButton(
      favoriteEntity: item.toFavorite(),
      size: PosterRowMetrics.heartSize,
    ),
    onTap: onTap,
  );
}

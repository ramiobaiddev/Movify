import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/radii.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/home/presentation/widgets/empty_image.dart';

/// Single carousel poster card matching Figma node `4:671` (196 x 295 px).
class StackedCarouselCard extends StatelessWidget {
  const StackedCarouselCard({
    super.key,
    required this.posterPath,
  });

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 196,
      height: 295,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radii.lg),
        child: CachedNetworkImage(
          imageUrl: tmdbImageSize(TmdbImageSize.w500, posterPath),
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: const Color(0xFF1E2029),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const EmptyImage(),
        ),
      ),
    );
  }
}

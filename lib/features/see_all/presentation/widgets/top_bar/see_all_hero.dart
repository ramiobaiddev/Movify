import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/shared/presentation/widgets/headers/header_button_row.dart';

/// Picture, back button, title and description above a collection (Figma
/// "Cartoons Â· Cinematic hero"). Replaces the plain top bar.
class SeeAllHero extends StatelessWidget {
  const SeeAllHero({
    super.key,
    required this.title,
    required this.hero,
    required this.onBack,
  });

  static const double height = 292;
  static const double _fadeHeight = 160;

  final String title;
  final SeeAllHeroData hero;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: tmdbImageSize(TmdbImageSize.w780, hero.imagePath),
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: _fadeHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.surfacePrimary.withValues(alpha: 0),
                    colors.surfacePrimary,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + Space.sm,
            left: Space.lg,
            right: Space.lg,
            child: HeaderButtonRow(onBack: onBack),
          ),
          Positioned(
            left: Space.lg,
            right: Space.lg,
            bottom: Space.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: text.headlineLarge?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: Space.xsm),
                Text(
                  hero.description,
                  style: text.bodyMedium?.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/details_header.dart';
import 'package:movify/shared/presentation/widgets/photo_header.dart';

/// Wide still of the episode fading into the screen colour, with the back,
/// heart, share and home buttons on top (Figma "episode").
class EpisodeHeader extends StatelessWidget {
  const EpisodeHeader({super.key, required this.data, required this.imagePath});

  static const double _height = 189;
  static const double _fadeHeight = 90;

  final EpisodeNavData data;

  /// TMDB path of the picture; null leaves the plain background.
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final path = imagePath;

    return SizedBox(
      height: _height,
      child: Stack(
        children: [
          if (path != null && path.isNotEmpty)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: tmdbImageSize(TmdbImageSize.w780, path),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
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
            child: HeaderButtonRow(
              onBack: () => Navigator.of(context).maybePop(),
              actions: headerActions(context, data),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';

/// 120x67 episode thumbnail used by the Next episode and Last aired cards.
class EpisodeStill extends StatelessWidget {
  const EpisodeStill({super.key, required this.path, this.fallbackPath});

  static const double width = 120;
  static const double height = 67;

  final String? path;
  final String? fallbackPath;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectivePath = (path != null && path!.isNotEmpty)
        ? path
        : (fallbackPath != null && fallbackPath!.isNotEmpty)
        ? fallbackPath
        : null;
    final placeholder = Center(
      child: Icon(Icons.movie_outlined, size: 24, color: colors.iconSecondary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.sm),
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: colors.surfacePlaceholderImage,
          child: effectivePath == null
              ? placeholder
              : CachedNetworkImage(
                  imageUrl: tmdbImageSize(TmdbImageSize.w300, effectivePath),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  memCacheWidth:
                      (width * MediaQuery.devicePixelRatioOf(context)).round(),
                  errorWidget: (_, _, _) => placeholder,
                ),
        ),
      ),
    );
  }
}

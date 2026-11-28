import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';

/// 120x67 episode thumbnail used by the Next episode and Last aired cards.
class EpisodeStill extends StatelessWidget {
  const EpisodeStill({super.key, required this.path});

  static const double width = 120;
  static const double height = 67;

  final String? path;

  @override
  Widget build(BuildContext context) {
    final path = this.path;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.sm),
      child: SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: context.colors.surfaceGenre,
          child: path == null
              ? null
              : CachedNetworkImage(
                  imageUrl: tmdbImageSize(TmdbImageSize.w300, path),
                  fit: BoxFit.cover,
                  memCacheWidth: (width * MediaQuery.devicePixelRatioOf(context)).round(),
                  errorWidget: (_, _, _) => const SizedBox.shrink(),
                ),
        ),
      ),
    );
  }
}

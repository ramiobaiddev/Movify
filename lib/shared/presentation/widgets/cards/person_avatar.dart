import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';

/// Round profile photo with a person icon when there is no photo.
class PersonAvatar extends StatelessWidget {
  const PersonAvatar({super.key, required this.profilePath, this.size = 48});

  final String? profilePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final path = profilePath;
    final fallback = Icon(
      Icons.person_rounded,
      color: colors.iconSecondary,
      size: size * 0.5,
    );

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: ColoredBox(
          color: colors.surfaceGenre,
          child: path == null || path.isEmpty
              ? fallback
              : CachedNetworkImage(
                  imageUrl: tmdbImageSize(TmdbImageSize.w185, path),
                  fit: BoxFit.cover,
                  memCacheWidth: (size * MediaQuery.devicePixelRatioOf(context))
                      .round(),
                  errorWidget: (_, _, _) => fallback,
                ),
        ),
      ),
    );
  }
}

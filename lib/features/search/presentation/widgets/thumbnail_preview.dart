import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

class ThumbnailPreview extends StatelessWidget {
  const ThumbnailPreview({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.sm),
      child: SizedBox(
        width: 64,
        height: 36,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.fill,
          errorWidget: (_, _, _) => ColoredBox(
            color: colors.surfaceGenre,
            child: Icon(
              Icons.movie_outlined,
              size: 18,
              color: colors.iconSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

/// Cached poster image with placeholder, error handling, and optional Hero animation.
class PosterImage extends StatelessWidget {
  const PosterImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = Radii.lg,
    this.enableHero = false,
    this.heroTag,
  });

  final String imageUrl;
  final double borderRadius;
  final bool enableHero;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => ColoredBox(
          color: colors.surfacePlaceholderImage,
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primaryDefault.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => ColoredBox(
          color: colors.surfacePlaceholderImage,
          child: Icon(
            Icons.broken_image_rounded,
            color: colors.iconSecondary,
            size: 28,
          ),
        ),
      ),
    );
  }
}

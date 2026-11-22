import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/motion.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

/// Cached poster image with a static placeholder, an error state, and an
/// optional [Hero]. Decodes at the size it is shown (not the full TMDB image).
class PosterImage extends StatelessWidget {
  const PosterImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = Radii.lg,
    this.enableHero = false,
    this.heroTag,
  }) : assert(!enableHero || heroTag != null, 'enableHero needs a heroTag');

  final String imageUrl;
  final double borderRadius;
  final bool enableHero;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    Widget error() => ColoredBox(
      color: colors.surfacePlaceholderImage,
      child: Icon(
        Icons.broken_image_rounded,
        color: colors.iconSecondary,
        size: 28,
      ),
    );

    // A plain colour while loading: a spinner per poster means dozens of
    // running animations in a single row.
    final placeholder = ColoredBox(color: colors.surfacePlaceholderImage);

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl.isEmpty
          ? error()
          : LayoutBuilder(
              builder: (context, constraints) => CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                memCacheWidth: constraints.maxWidth.isFinite
                    ? (constraints.maxWidth * pixelRatio).round()
                    : null,
                fadeInDuration: Motion.durationFast,
                placeholder: (context, url) => placeholder,
                errorWidget: (context, url, error_) => error(),
              ),
            ),
    );

    return enableHero ? Hero(tag: heroTag!, child: image) : image;
  }
}

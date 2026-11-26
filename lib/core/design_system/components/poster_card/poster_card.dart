import 'package:flutter/material.dart';
import 'package:movify/core/design_system/components/poster_card/poster_image.dart';
import 'package:movify/core/design_system/components/poster_card/poster_metadata.dart';
import 'package:movify/core/design_system/components/poster_card/poster_rating_badge.dart';
import 'package:movify/core/design_system/tokens/motion.dart';
import 'package:movify/core/design_system/tokens/radii.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';

/// Production-ready Poster Card component mirroring Figma node `10:1258`.
///
/// Features:
/// - Pure widget composition (no private helper builder methods)
/// - Sub-widgets separated into their own dedicated files
/// - 2:3 poster aspect ratio (TMDB posters)
/// - Top-left rating chip with frosted background
/// - Top-right slot for any action button (e.g. `FavoriteButton`)
/// - Title & media type subtitle with single-line ellipsis
/// - Press feedback scale animation
class PosterCard extends StatefulWidget {
  const PosterCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.rating,
    this.actionButton,
    this.onTap,
    this.onLongPress,
    this.width,
    this.borderRadius = Radii.lg,
    this.aspectRatio = 2 / 3,
    this.enableHero = false,
    this.heroTag,
  }) : assert(!enableHero || heroTag != null, 'enableHero needs a heroTag');

  final String imageUrl;
  final String title;
  final String? subtitle;
  final double? rating;

  /// Top-right overlay widget (e.g. `FavoriteButton`).
  final Widget? actionButton;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double borderRadius;
  final double aspectRatio;
  final bool enableHero;
  final Object? heroTag;

  @override
  State<PosterCard> createState() => _PosterCardState();
}

class _PosterCardState extends State<PosterCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget card = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PosterImage(
                imageUrl: widget.imageUrl,
                borderRadius: widget.borderRadius,
                enableHero: widget.enableHero,
                heroTag: widget.heroTag,
              ),
              if (widget.rating != null && widget.rating! > 0)
                Positioned(
                  top: Space.sm,
                  left: Space.sm,
                  child: PosterRatingBadge(rating: widget.rating!),
                ),
              if (widget.actionButton != null)
                Positioned(
                  top: Space.sm,
                  right: Space.sm,
                  child: widget.actionButton!,
                ),
            ],
          ),
        ),
        const SizedBox(height: Space.sm),
        Flexible(
          child: PosterMetadata(title: widget.title, subtitle: widget.subtitle),
        ),
      ],
    );

    if (widget.width != null) {
      card = SizedBox(width: widget.width, child: card);
    }

    return Semantics(
      button: widget.onTap != null,
      onTap: widget.onTap,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: Motion.durationFast,
          curve: Curves.easeInOut,
          child: card,
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/headers/header_button_row.dart';

/// Top of the actor and details screens (Figma "Actor View" / "movie details"):
/// a full-width photo that fades into the screen colour, a portrait that
/// overlaps the fade, and a row of round buttons on top.
///
/// The photo is not blurred in the design. The fade is a plain gradient, which
/// costs nothing next to a real layer blur on a scrolling screen.
class PhotoHeader extends StatelessWidget {
  const PhotoHeader({
    super.key,
    required this.backdropUrl,
    required this.portraitUrl,
    required this.onBack,
    this.actions = const [],
    this.portraitOverlay,
    this.portraitFallback,
  });

  static const double backdropHeight = 420;
  static const double fadeHeight = 90;
  static const double portraitTop = 251;
  static const double portraitWidth = 148;
  static const double portraitHeight = 223;
  static const double height = portraitTop + portraitHeight;

  /// Full-width picture behind everything. Null leaves the plain background.
  final String? backdropUrl;

  /// Picture in the portrait frame. Null shows [portraitFallback].
  final String? portraitUrl;

  final VoidCallback onBack;

  /// Buttons on the right, usually [HeaderCircleAction]s.
  final List<Widget> actions;

  /// Drawn over the bottom-right corner of the portrait (e.g. a play icon).
  final Widget? portraitOverlay;

  /// Shown in the portrait frame when there is no picture.
  final Widget? portraitFallback;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final backdrop = backdropUrl;
    final portrait = portraitUrl;
    final overlay = portraitOverlay;

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (backdrop != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: backdropHeight,
              child: CachedNetworkImage(
                imageUrl: backdrop,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorWidget: (_, _, _) => const SizedBox.shrink(),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            top: backdropHeight - fadeHeight,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.surfacePrimary.withValues(alpha: 0),
                    colors.surfacePrimary,
                  ],
                  stops: const [
                    0,
                    fadeHeight / (height - backdropHeight + fadeHeight),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: portraitTop,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Radii.lg),
              child: SizedBox(
                width: portraitWidth,
                height: portraitHeight,
                child: ColoredBox(
                  color: colors.surfacePlaceholderImage,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (portrait == null)
                        Center(child: portraitFallback)
                      else
                        CachedNetworkImage(
                          imageUrl: portrait,
                          fit: BoxFit.cover,
                          errorWidget: (_, _, _) => Center(child: portraitFallback),
                        ),
                      if (overlay != null)
                        Positioned(
                          right: Space.sm,
                          bottom: Space.sm,
                          child: overlay,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + Space.sm,
            left: Space.lg,
            right: Space.lg,
            child: HeaderButtonRow(onBack: onBack, actions: actions),
          ),
        ],
      ),
    );
  }
}

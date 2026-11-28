import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/details_actions.dart';
import 'package:movify/shared/presentation/widgets/photo_header.dart';

/// Photo header of a movie or series, built from the navigation data so it is
/// on screen before the details arrive.
class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key, required this.data, this.onPlayTrailer});

  final DetailsNavigationData data;

  /// Shows a play button on the poster. Null while there is nothing to play.
  final VoidCallback? onPlayTrailer;

  @override
  Widget build(BuildContext context) {
    final backdrop = data.backdropImage ?? data.posterImage;

    return PhotoHeader(
      backdropUrl: backdrop.isEmpty
          ? null
          : tmdbImageSize(TmdbImageSize.w780, backdrop),
      portraitUrl: data.posterImage.isEmpty
          ? null
          : tmdbImageSize(TmdbImageSize.w500, data.posterImage),
      portraitFallback: const Icon(Icons.movie_outlined, size: 48),
      portraitOverlay: onPlayTrailer == null
          ? null
          : _PlayButton(onTap: onPlayTrailer!),
      onBack: () => Navigator.of(context).maybePop(),
      actions: headerActions(context, data),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Play trailer',
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        Icons.play_circle_fill_rounded,
        size: 40,
        color: context.colors.iconPrimary,
      ),
    ),
  );
}

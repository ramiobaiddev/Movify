import 'package:flutter/material.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/common/details_actions.dart';
import 'package:movify/features/details/presentation/widgets/common/play_button.dart';
import 'package:movify/shared/presentation/widgets/headers/header_circle.dart';
import 'package:movify/shared/presentation/widgets/headers/photo_header.dart';

/// Photo header of a movie or series, built from the navigation data so it is
/// on screen before the details arrive.
class DetailsHeader extends StatelessWidget {
  const DetailsHeader({super.key, required this.data, this.onPlayTrailer});

  final DetailsNavigationData data;

  /// Shows a play button on the poster. Null while there is nothing to play.
  final VoidCallback? onPlayTrailer;

  @override
  Widget build(BuildContext context) {
    final backdrop = (data.backdropImage?.isNotEmpty ?? false)
        ? data.backdropImage!
        : data.posterImage;

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
          : HeaderCircle(child: PlayButton(onTap: onPlayTrailer!)),
      onBack: () => Navigator.of(context).maybePop(),
      actions: headerActions(context, data),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/core/mappers/favorite_mappers.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:movify/shared/presentation/widgets/photo_header.dart';
import 'package:share_plus/share_plus.dart';

/// Link shared for a movie, series, season or episode.
String shareUrlOf(DetailsNavigationData data) => switch (data) {
  EpisodeNavData(:final seasonNumber, :final episodeNumber) =>
    'https://www.themoviedb.org/tv/${data.tmdbId}/season/$seasonNumber'
        '/episode/$episodeNumber',
  SeasonNavData(:final seasonNumber) =>
    'https://www.themoviedb.org/tv/${data.tmdbId}/season/$seasonNumber',
  SeriesNavData() => 'https://www.themoviedb.org/tv/${data.tmdbId}',
  _ => 'https://www.themoviedb.org/movie/${data.tmdbId}',
};

/// Heart, share and home as dark round buttons, for the photo header.
List<Widget> headerActions(BuildContext context, DetailsNavigationData data) =>
    [
      HeaderCircle(
        child: FavoriteButton(
          favoriteEntity: FavoriteMapper.fromNavigationData(data),
          size: 18,
          shaded: false,
        ),
      ),
      HeaderCircleAction(
        icon: Icons.ios_share_rounded,
        label: 'Share',
        onTap: () => SharePlus.instance.share(ShareParams(text: shareUrlOf(data))),
      ),
      HeaderCircleAction(
        icon: Icons.home_rounded,
        label: 'Home',
        onTap: () => context.goNamed(RouteName.home),
      ),
    ];

/// The same three actions as plain icons, for the pinned app bar.
List<Widget> barActions(BuildContext context, DetailsNavigationData data) {
  final color = context.colors.textPrimary;

  return [
    IconTheme(
      data: IconThemeData(color: color),
      child: FavoriteButton(
        favoriteEntity: FavoriteMapper.fromNavigationData(data),
        size: 24,
        shaded: false,
      ),
    ),
    _BarIcon(
      icon: Icons.ios_share_rounded,
      label: 'Share',
      onTap: () => SharePlus.instance.share(ShareParams(text: shareUrlOf(data))),
    ),
    _BarIcon(
      icon: Icons.home_rounded,
      label: 'Home',
      onTap: () => context.goNamed(RouteName.home),
    ),
  ];
}

class _BarIcon extends StatelessWidget {
  const _BarIcon({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 40,
        height: 48,
        child: Icon(icon, size: 24, color: context.colors.textPrimary),
      ),
    ),
  );
}

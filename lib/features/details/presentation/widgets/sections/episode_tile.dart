import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

/// One episode row: still with its number, title, date and runtime, and a
/// countdown when it has not aired yet.
class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    super.key,
    required this.episode,
    required this.today,
    required this.onTap,
    this.selected = false,
    this.showDivider = true,
  });

  static const double _stillWidth = 106;
  static const double _stillHeight = 60;

  final EpisodeItem episode;
  final DateTime today;
  final VoidCallback onTap;

  /// Highlights the row (the episode being watched in the picker).
  final bool selected;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final date = episode.airDate;
    final runtime = episode.runtime;
    final details = [
      if (date != null) DateFormat('d MMM y').format(date),
      if (runtime != null) '${runtime}min',
    ].join(' · ');
    final path = episode.stillPath;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryDefault.withValues(alpha: 0.15)
              : null,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        child: Padding(
          padding: selected
              ? const EdgeInsets.all(Space.sm)
              : EdgeInsets.zero,
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Radii.sm),
                        child: SizedBox(
                          width: _stillWidth,
                          height: _stillHeight,
                          child: ColoredBox(
                            color: colors.surfaceGenre,
                            child: path == null
                                ? null
                                : CachedNetworkImage(
                                    imageUrl: tmdbImageSize(TmdbImageSize.w300, path),
                                    fit: BoxFit.cover,
                                    memCacheWidth: (_stillWidth * MediaQuery.devicePixelRatioOf(context)).round(),
                                    errorWidget: (_, _, _) =>
                                        const SizedBox.shrink(),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: Space.xsm,
                        bottom: Space.xsm,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.surfacePrimary.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(Radii.md),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Space.sm,
                            ),
                            child: Text(
                              'E${episode.number}',
                              style: text.labelSmall?.copyWith(
                                color: colors.iconPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: Space.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episode.name,
                          style: text.titleSmall?.copyWith(
                            color: colors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (details.isNotEmpty) ...[
                          const SizedBox(height: Space.xsm),
                          Text(
                            details,
                            style: text.bodySmall?.copyWith(
                              color: colors.textContrast,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (date != null && episode.isUpcoming(today)) ...[
                    const SizedBox(width: Space.sm),
                    Icon(
                      Icons.schedule_rounded,
                      size: 16,
                      color: colors.primaryDefault,
                    ),
                    const SizedBox(width: Space.sm),
                    Text(
                      daysUntil(date, today),
                      style: text.labelMedium?.copyWith(
                        color: colors.primaryDefault,
                      ),
                    ),
                  ],
                ],
              ),
              if (showDivider) ...[
                const SizedBox(height: Space.md),
                Divider(height: 1, thickness: 1, color: colors.surfaceDivider),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

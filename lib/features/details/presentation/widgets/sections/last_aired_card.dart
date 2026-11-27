import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_still.dart';

/// The most recent episode; tapping it opens that episode.
class LastAiredCard extends StatelessWidget {
  const LastAiredCard({super.key, required this.episode, required this.onTap});

  final EpisodeSummary episode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final airDate = episode.airDate;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceProfileRow,
          borderRadius: BorderRadius.circular(Radii.lg),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.lg,
            vertical: Space.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last aired',
                style: text.titleSmall?.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: Space.lg),
              Row(
                children: [
                  EpisodeStill(path: episode.stillPath),
                  const SizedBox(width: Space.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          episode.code,
                          style: text.bodySmall?.copyWith(
                            color: colors.textContrast,
                          ),
                        ),
                        const SizedBox(height: Space.sm),
                        Text(
                          episode.name,
                          style: text.titleSmall?.copyWith(
                            color: colors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (airDate != null) ...[
                          const SizedBox(height: Space.sm),
                          Text(
                            'Aired ${DateFormat('d MMM y').format(airDate)}',
                            style: text.bodySmall?.copyWith(
                              color: colors.textContrast,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 24,
                    color: colors.iconPrimary,
                  ),
                ],
              ),
              const SizedBox(height: Space.lg),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_still.dart';

/// The episode that airs next, with a countdown when the date is known.
class NextEpisodeCard extends StatelessWidget {
  const NextEpisodeCard({
    super.key,
    required this.episode,
    required this.today,
  });

  final EpisodeSummary episode;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final airDate = episode.airDate;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceBottomSheet,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.lg,
          vertical: Space.x2xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NEXT EPISODE',
                  style: text.titleSmall?.copyWith(color: colors.textContrast),
                ),
                if (airDate != null)
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 24,
                        color: colors.primaryDefault,
                      ),
                      const SizedBox(width: Space.sm),
                      Text(
                        daysUntil(airDate, today),
                        style: text.titleSmall?.copyWith(
                          color: colors.primaryDefault,
                        ),
                      ),
                    ],
                  ),
              ],
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
                      const SizedBox(height: Space.xsm),
                      Text(
                        episode.name,
                        style: text.titleSmall?.copyWith(
                          color: colors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (airDate != null) ...[
                        const SizedBox(height: Space.xsm),
                        Text(
                          DateFormat('EEE, d MMM').format(airDate),
                          style: text.bodySmall?.copyWith(
                            color: colors.textContrast,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

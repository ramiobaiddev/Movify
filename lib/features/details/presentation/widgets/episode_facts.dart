import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';

/// `S01 · E03 · 52 min · 4 Mar 2024` with the rating beside it.
class EpisodeFacts extends StatelessWidget {
  const EpisodeFacts({super.key, required this.episode});

  final EpisodeItem episode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final date = episode.airDate;
    final rating = episode.rating;
    final facts = [
      episode.fullCode,
      if (episode.runtime != null) '${episode.runtime} min',
      if (date != null) DateFormat('d MMM y').format(date),
    ].join(' · ');

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: Space.md,
      children: [
        Text(
          facts,
          style: text.titleSmall?.copyWith(color: colors.textContrast),
        ),
        if (rating != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: text.bodyLarge?.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(width: Space.xsm),
              Icon(Icons.star_rounded, size: 24, color: colors.statusWarning),
            ],
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/common/cast_row.dart';
import 'package:movify/features/details/presentation/widgets/episodes/episode_facts.dart';
import 'package:movify/features/details/presentation/widgets/episodes/episode_series_link.dart';
import 'package:movify/shared/presentation/widgets/common/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Title, facts, overview and guest stars of one episode.
class EpisodeViewBody extends StatelessWidget {
  const EpisodeViewBody({
    super.key,
    required this.episode,
    required this.seriesTitle,
    required this.onSeries,
  });

  final EpisodeItem episode;
  final String? seriesTitle;
  final VoidCallback onSeries;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final series = seriesTitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenGutter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (series != null && series.isNotEmpty)
                EpisodeSeriesLink(title: series, onTap: onSeries),
              const SizedBox(height: Space.xsm),
              Text(
                episode.name,
                style: text.headlineLarge?.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: Space.xsm),
              EpisodeFacts(episode: episode),
              if (episode.overview.isNotEmpty) ...[
                const SizedBox(height: Space.x2xl),
                Text(
                  'Overview',
                  style: text.titleMedium?.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: Space.md),
                ExpandableText(text: episode.overview),
              ],
            ],
          ),
        ),
        if (episode.guestStars.isNotEmpty) ...[
          const SizedBox(height: Space.x2xl),
          CastRow(
            title: 'Guest stars',
            dense: true,
            cast: episode.guestStars,
            onTap: (person) => context.openPerson(person.id),
          ),
        ],
        SizedBox(height: Space.x3xl + MediaQuery.paddingOf(context).bottom),
      ],
    );
  }
}

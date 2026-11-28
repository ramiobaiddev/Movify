import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/core/episode_position.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_cubit.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_state.dart';
import 'package:movify/features/details/presentation/mappers/season_content_mapper.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/centered_status.dart';
import 'package:movify/features/details/presentation/widgets/content_error.dart';
import 'package:movify/features/details/presentation/widgets/episode_bar.dart';
import 'package:movify/features/details/presentation/widgets/episode_content_view.dart';
import 'package:movify/features/details/presentation/widgets/episode_header.dart';

/// One episode: still, series link, title, facts, overview, guest stars, and
/// a bar to step to the previous or next episode of the season.
class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key, required this.data});

  final EpisodeNavData data;

  @override
  Widget build(BuildContext context) => BlocProvider<SeasonCubit>(
    key: ValueKey('episode-${data.tmdbId}-${data.seasonNumber}'),
    create: (_) => getIt<SeasonCubit>()..load(data.tmdbId, data.seasonNumber),
    child: _EpisodeBody(data: data),
  );
}

class _EpisodeBody extends StatefulWidget {
  const _EpisodeBody({required this.data});

  final EpisodeNavData data;

  @override
  State<_EpisodeBody> createState() => _EpisodeBodyState();
}

class _EpisodeBodyState extends State<_EpisodeBody> {
  /// Stepping previous / next changes this in place; no new route.
  late int _number = widget.data.episodeNumber;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return BlocBuilder<SeasonCubit, SeasonState>(
      builder: (context, state) {
        final episodes = state is SeasonLoaded
            ? state.season.toSeasonContent().episodes
            : const <EpisodeItem>[];
        final position = EpisodePosition(episodes, _number);
        final current = position.current;
        final nav = current == null ? data : data.forEpisode(current);

        return Scaffold(
          backgroundColor: context.colors.surfacePrimary,
          bottomNavigationBar: current == null
              ? null
              : EpisodeBar(
                  episodes: episodes,
                  current: current,
                  position: position,
                  onSelect: (episode) =>
                      setState(() => _number = episode.number),
                ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              EpisodeHeader(
                data: nav,
                imagePath: current?.stillPath ?? data.posterImage,
              ),
              if (current != null)
                EpisodeContentView(
                  episode: current,
                  seriesTitle: data.seriesTitle,
                  onSeries: () => context.openSeries(data),
                )
              else if (state is SeasonError)
                ContentError(
                  message: state.message,
                  onRetry: () => context.read<SeasonCubit>().load(
                    data.tmdbId,
                    data.seasonNumber,
                  ),
                )
              else if (state is SeasonLoaded)
                const CenteredStatus(child: Text('Episode not available'))
              else
                const CenteredStatus(),
            ],
          ),
        );
      },
    );
  }
}

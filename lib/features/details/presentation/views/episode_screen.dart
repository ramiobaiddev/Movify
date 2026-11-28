import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_cubit.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_state.dart';
import 'package:movify/features/details/presentation/mappers/season_content_mapper.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/episode_header.dart';
import 'package:movify/features/details/presentation/widgets/episodes_sheet.dart';
import 'package:movify/features/details/presentation/widgets/sections/cast_row.dart';
import 'package:movify/shared/presentation/widgets/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/sequence_nav_bar.dart';

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
  late int _number = widget.data.episodeNumber;

  EpisodeNavData _navFor(EpisodeItem? episode) {
    final data = widget.data;
    if (episode == null) {
      return data;
    }
    return EpisodeNavData(
      tmdbId: data.tmdbId,
      seasonNumber: episode.seasonNumber,
      episodeNumber: episode.number,
      date: episode.airDate?.toIso8601String(),
      rating: episode.rating,
      seriesPosterPath: data.seriesPosterPath,
      seriesTitle: data.seriesTitle,
      posterImage: episode.stillPath ?? data.posterImage,
      backdropImage: data.backdropImage,
      specificId: episode.id,
    );
  }

  void _openSeries() {
    final data = widget.data;
    context.pushNamed(
      RouteName.tvDetail,
      pathParameters: {'id': data.tmdbId.toString()},
      extra: SeriesNavData(
        tmdbId: data.tmdbId,
        title: data.seriesTitle ?? '',
        posterImage: data.seriesPosterPath ?? '',
        backdropImage: data.backdropImage,
        specificId: data.tmdbId,
      ),
    );
  }

  Future<void> _pick(List<EpisodeItem> episodes, EpisodeItem current) async {
    final picked = await showEpisodesSheet(
      context,
      episodes: episodes,
      current: current,
      today: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _number = picked.number);
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SeasonCubit, SeasonState>(
    builder: (context, state) {
      final episodes = state is SeasonLoaded
          ? state.season.toSeasonContent().episodes
          : const <EpisodeItem>[];
      final index = episodes.indexWhere((e) => e.number == _number);
      final current = index < 0 ? null : episodes[index];
      final previous = index > 0 ? episodes[index - 1] : null;
      final next = index >= 0 && index < episodes.length - 1
          ? episodes[index + 1]
          : null;
      final nav = _navFor(current);

      return Scaffold(
        backgroundColor: context.colors.surfacePrimary,
        bottomNavigationBar: current == null
            ? null
            : SequenceNavBar(
                centerLabel: 'All episodes',
                onCenter: () => _pick(episodes, current),
                onPrevious: previous == null
                    ? null
                    : () => setState(() => _number = previous.number),
                nextLabel: next == null ? 'Next' : 'Next · ${next.code}',
                onNext: next == null
                    ? null
                    : () => setState(() => _number = next.number),
              ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            EpisodeHeader(
              data: nav,
              imagePath: current?.stillPath ?? widget.data.posterImage,
            ),
            if (current != null)
              _Loaded(
                episode: current,
                seriesTitle: widget.data.seriesTitle,
                onSeries: _openSeries,
              )
            else if (state is SeasonError)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
                child: PagedErrorView(
                  message: state.message,
                  onRetry: () => context.read<SeasonCubit>().load(
                    widget.data.tmdbId,
                    widget.data.seasonNumber,
                  ),
                ),
              )
            else if (state is SeasonLoaded)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Space.x3xl),
                child: Center(child: Text('Episode not available')),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Space.x3xl),
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
          ],
        ),
      );
    },
  );
}

class _Loaded extends StatelessWidget {
  const _Loaded({
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
    final date = episode.airDate;
    final rating = episode.rating;
    final facts = [
      episode.fullCode,
      if (episode.runtime != null) '${episode.runtime} min',
      if (date != null) DateFormat('d MMM y').format(date),
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (seriesTitle != null && seriesTitle!.isNotEmpty)
                GestureDetector(
                  onTap: onSeries,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          seriesTitle!,
                          style: text.titleSmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: Space.xsm),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: colors.textPrimary,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: Space.xsm),
              Text(
                episode.name,
                style: text.headlineLarge?.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: Space.xsm),
              Wrap(
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
                          style: text.bodyLarge?.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: Space.xsm),
                        Icon(
                          Icons.star_rounded,
                          size: 24,
                          color: colors.statusWarning,
                        ),
                      ],
                    ),
                ],
              ),
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
            onTap: (person) => context.pushNamed(
              RouteName.person,
              pathParameters: {'id': person.id.toString()},
            ),
          ),
        ],
        SizedBox(height: Space.x3xl + MediaQuery.paddingOf(context).bottom),
      ],
    );
  }
}

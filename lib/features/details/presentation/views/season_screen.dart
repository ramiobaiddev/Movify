import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_cubit.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_state.dart';
import 'package:movify/features/details/presentation/mappers/details_content_mapper.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/details_header.dart';
import 'package:movify/features/details/presentation/widgets/sections/cast_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_title_block.dart';
import 'package:movify/features/details/presentation/widgets/sections/episodes_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/information_section.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';
import 'package:movify/features/details/presentation/widgets/sections/videos_section.dart';
import 'package:movify/features/details/presentation/widgets/trailer_player.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/sequence_nav_bar.dart';

/// One season of a series: header, story, cast, information, episodes, videos.
class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key, required this.data});

  final SeasonNavData data;

  @override
  Widget build(BuildContext context) => BlocProvider<SeasonCubit>(
    key: ValueKey('season-${data.tmdbId}-${data.seasonNumber}'),
    create: (_) => getIt<SeasonCubit>()..load(data.tmdbId, data.seasonNumber),
    child: _SeasonBody(data: data),
  );
}

class _SeasonBody extends StatefulWidget {
  const _SeasonBody({required this.data});

  final SeasonNavData data;

  @override
  State<_SeasonBody> createState() => _SeasonBodyState();
}

class _SeasonBodyState extends State<_SeasonBody> {
  bool _showAll = false;

  SeasonNavData get _data => widget.data;

  List<SeasonItem> get _seasons => [..._data.seasons]
    ..sort((a, b) => a.number.compareTo(b.number));

  SeasonItem? _neighbour(int step) {
    final seasons = _seasons;
    final index = seasons.indexWhere((s) => s.number == _data.seasonNumber);
    final target = index + step;
    if (index < 0 || target < 0 || target >= seasons.length) {
      return null;
    }
    return seasons[target];
  }

  void _openSeason(SeasonItem season) {
    context.pushReplacementNamed(
      RouteName.season,
      extra: SeasonNavData.fromItem(
        season,
        tmdbId: _data.tmdbId,
        seriesPosterPath: _data.posterImage,
        backdropPath: _data.backdropImage,
        seasons: _data.seasons,
        seriesTitle: _data.seriesTitle,
      ),
    );
  }

  Future<void> _pickSeason() async {
    final picked = await AppSelectionBottomSheet.show<int>(
      context,
      title: 'Seasons',
      selectedValue: _data.seasonNumber,
      options: [
        for (final season in _seasons)
          AppSelectionOption<int>(
            season.name,
            season.number,
            subtitle: season.episodeCount == null
                ? null
                : '${season.episodeCount} episodes',
          ),
      ],
    );
    if (picked == null || picked == _data.seasonNumber || !mounted) {
      return;
    }
    _openSeason(_seasons.firstWhere((s) => s.number == picked));
  }

  void _openEpisode(EpisodeItem episode) {
    context.pushNamed(
      RouteName.episode,
      extra: EpisodeNavData(
        tmdbId: _data.tmdbId,
        seasonNumber: episode.seasonNumber,
        episodeNumber: episode.number,
        rating: episode.rating,
        posterImage: episode.stillPath ?? _data.backdropImage ?? '',
        seriesPosterPath: _data.posterImage,
        seriesTitle: _data.seriesTitle,
        specificId: episode.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previous = _neighbour(-1);
    final next = _neighbour(1);
    final showBar = _showAll && _seasons.length > 1;

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      bottomNavigationBar: showBar
          ? SequenceNavBar(
              centerLabel: 'Seasons',
              onCenter: _pickSeason,
              onPrevious: previous == null ? null : () => _openSeason(previous),
              nextLabel: next == null ? 'Next' : 'Next · S${next.number}',
              onNext: next == null ? null : () => _openSeason(next),
            )
          : null,
      body: BlocBuilder<SeasonCubit, SeasonState>(
        builder: (context, state) {
          final content = state is SeasonLoaded
              ? state.season.toSeasonContent()
              : null;
          final trailer = content?.trailer;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DetailsHeader(
                data: _data,
                onPlayTrailer: trailer == null
                    ? null
                    : () => showTrailerPlayer(context, trailer),
              ),
              const SizedBox(height: Space.md),
              if (content != null)
                _Loaded(
                  content: content,
                  showAll: _showAll,
                  onShowAll: () => setState(() => _showAll = true),
                  onEpisode: _openEpisode,
                )
              else if (state is SeasonError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
                  child: PagedErrorView(
                    message: state.message,
                    onRetry: () => context.read<SeasonCubit>().load(
                      _data.tmdbId,
                      _data.seasonNumber,
                    ),
                  ),
                )
              else
                _Loading(data: _data),
            ],
          );
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({
    required this.content,
    required this.showAll,
    required this.onShowAll,
    required this.onEpisode,
  });

  static const _pad = EdgeInsets.symmetric(horizontal: Space.lg);

  final SeasonContent content;
  final bool showAll;
  final VoidCallback onShowAll;
  final ValueChanged<EpisodeItem> onEpisode;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: _pad,
        child: DetailsTitleBlock(
          title: content.title,
          meta: content.meta,
          rating: content.rating,
        ),
      ),
      if (content.overview.isNotEmpty) ...[
        const SizedBox(height: Space.x2xl),
        Padding(
          padding: _pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle('Storyline'),
              const SizedBox(height: Space.sm),
              ExpandableText(text: content.overview),
            ],
          ),
        ),
      ],
      const SizedBox(height: Space.x2xl),
      CastRow(
        cast: content.cast,
        onTap: (person) => context.pushNamed(
          RouteName.person,
          pathParameters: {'id': person.id.toString()},
        ),
      ),
      const SizedBox(height: Space.x3xl),
      InformationSection(rows: content.info),
      const SizedBox(height: Space.x3xl),
      EpisodesSection(
        episodes: content.episodes,
        expanded: showAll,
        onShowAll: onShowAll,
        onTap: onEpisode,
        today: DateTime.now(),
      ),
      const SizedBox(height: Space.x3xl),
      if (content.videos.isNotEmpty) ...[
        VideosSection(
          videos: content.videos,
          onPlay: (video) => showTrailerPlayer(context, video),
        ),
        const SizedBox(height: Space.x3xl),
      ],
      SizedBox(height: MediaQuery.paddingOf(context).bottom + Space.x3xl),
    ],
  );
}

/// Season name from the navigation data plus grey blocks while loading.
class _Loading extends StatelessWidget {
  const _Loading({required this.data});

  final SeasonNavData data;

  @override
  Widget build(BuildContext context) {
    final rating = data.rating;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        children: [
          DetailsTitleBlock(
            title: data.seasonName ?? 'Season ${data.seasonNumber}',
            meta: const [],
            rating: rating != null && rating > 0 ? rating : null,
          ),
          const SizedBox(height: Space.x3xl),
          const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/config/animations/widgets/shimmer_loading.dart';
import 'package:movify/core/ads/cubits/interstitial_ad_cubit.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_cubit.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_state.dart';
import 'package:movify/features/details/presentation/feeds/related_fetchers.dart';
import 'package:movify/features/details/presentation/mappers/details_content_mapper.dart';
import 'package:movify/features/details/presentation/mappers/release_countdown.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/details_header.dart';
import 'package:movify/features/details/presentation/widgets/related/related_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/cast_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/collection_row.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_title_block.dart';
import 'package:movify/features/details/presentation/widgets/sections/genre_chips.dart';
import 'package:movify/features/details/presentation/widgets/sections/information_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/last_aired_card.dart';
import 'package:movify/features/details/presentation/widgets/sections/next_episode_card.dart';
import 'package:movify/features/details/presentation/widgets/sections/reviews_section.dart';
import 'package:movify/features/details/presentation/widgets/sections/seasons_row.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';
import 'package:movify/features/details/presentation/widgets/sections/videos_section.dart';
import 'package:movify/features/details/presentation/widgets/trailer_player.dart';
import 'package:movify/features/discover/presentation/models/discover_links.dart';
import 'package:movify/shared/presentation/widgets/expandable_text.dart';

/// Movie or series details (Figma "movie details" / "Series details").
///
/// Needs a [DetailsCubit] above it. The header and title come from [data] so
/// they show immediately; everything below fills in when the cubit loads.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.data});

  final DetailsNavigationData data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Interstitial on enter, after the route transition.
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        context.read<InterstitialAdCubit>().showAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<InterstitialAdCubit>().showAd();
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surfacePrimary,
        body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final content = switch (state) {
              DetailsMovieLoaded(:final movie) => movie.toContent(),
              DetailsSeriesLoaded(:final series) => series.toContent(),
              _ => null,
            };
            final trailer = content?.trailer;

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DetailsHeader(
                  data: data,
                  onPlayTrailer: trailer == null
                      ? null
                      : () => showTrailerPlayer(context, trailer),
                ),
                const SizedBox(height: Space.md),
                if (content != null)
                  _Loaded(content: content)
                else if (state is DetailsError)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
                    child: PagedErrorView(
                      message: state.message,
                      onRetry: () => context.read<DetailsCubit>().load(
                        data.contentType,
                        data.tmdbId,
                      ),
                    ),
                  )
                else
                  _Loading(data: data),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.content});

  final DetailsContent content;

  static const _pad = EdgeInsets.symmetric(horizontal: Space.lg);

  void _openGenre(BuildContext context, DetailsGenre genre) =>
      context.openGenre(content.kind, genre.id, genre.name);

  void _openSeason(BuildContext context, SeasonItem season) {
    context.pushNamed(
      RouteName.season,
      extra: SeasonNavData.fromItem(
        season,
        tmdbId: content.id,
        seriesPosterPath: content.posterPath,
        backdropPath: content.backdropPath,
        seasons: content.seasons,
        seriesTitle: content.title,
      ),
    );
  }

  void _openEpisode(BuildContext context, EpisodeSummary episode) {
    context.pushNamed(
      RouteName.episode,
      extra: EpisodeNavData(
        tmdbId: content.id,
        seasonNumber: episode.seasonNumber,
        episodeNumber: episode.episodeNumber,
        rating: episode.rating,
        posterImage: content.backdropPath ?? content.posterPath ?? '',
        seriesPosterPath: content.posterPath,
        seriesTitle: content.title,
        specificId: episode.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final nextEpisode = content.nextEpisode;
    final lastEpisode = content.lastEpisode;
    final upcoming = content.isUpcoming(today);
    final release = content.releaseDate;
    final fetchers = getIt<RelatedFetchers>();
    final collectionId = content.collectionId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _pad,
          child: DetailsTitleBlock(
            title: content.title,
            meta: content.meta,
            rating: content.rating,
            comingSoon: upcoming,
            releaseLine: upcoming && release != null
                ? releaseCountdown(release, today)
                : null,
          ),
        ),
        if (nextEpisode != null) ...[
          const SizedBox(height: Space.x2xl),
          Padding(
            padding: _pad,
            child: NextEpisodeCard(episode: nextEpisode, today: today),
          ),
        ],
        if (content.genres.isNotEmpty) ...[
          const SizedBox(height: Space.x2xl),
          Padding(
            padding: _pad,
            child: GenreChips(
              genres: content.genres,
              onTap: (genre) => _openGenre(context, genre),
            ),
          ),
        ],
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
        if (lastEpisode != null) ...[
          const SizedBox(height: Space.x2xl),
          Padding(
            padding: _pad,
            child: LastAiredCard(
              episode: lastEpisode,
              onTap: () => _openEpisode(context, lastEpisode),
            ),
          ),
        ],
        if (content.seasons.isNotEmpty) ...[
          const SizedBox(height: Space.x3xl),
          SeasonsRow(
            seasons: content.seasons,
            fallbackPosterPath: content.posterPath,
            onTap: (season) => _openSeason(context, season),
          ),
        ],
        const SizedBox(height: Space.x3xl),
        ReviewsSection(
          reviews: content.reviews,
          onSeeMore: () =>
              context.pushNamed(RouteName.reviews, extra: content.reviews),
        ),
        const SizedBox(height: Space.x3xl),
        if (collectionId != null) ...[
          CollectionRow(collectionId: collectionId, movieId: content.id),
          const SizedBox(height: Space.x3xl),
        ],
        InformationSection(rows: content.info),
        const SizedBox(height: Space.x3xl),
        if (content.videos.isNotEmpty) ...[
          VideosSection(
            videos: content.videos,
            onPlay: (video) => showTrailerPlayer(context, video),
          ),
          const SizedBox(height: Space.x3xl),
        ],
        RelatedRow(
          title: 'Recommended',
          queryKey: 'recommended-${content.kind}-${content.id}',
          fetcher: fetchers.recommended(content.kind, content.id),
        ),
        const SizedBox(height: Space.x3xl),
        RelatedRow(
          title: 'Similar',
          queryKey: 'similar-${content.kind}-${content.id}',
          fetcher: fetchers.similar(content.kind, content.id),
        ),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + Space.x3xl),
      ],
    );
  }
}

/// Title from the navigation data plus grey blocks where the sections go.
class _Loading extends StatelessWidget {
  const _Loading({required this.data});

  final DetailsNavigationData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Widget block(double width, double height) => DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceGenre,
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: SizedBox(width: width, height: height),
    );

    final (title, date, rating) = switch (data) {
      MovieNavData(:final title, :final date, :final rating) => (
        title,
        date,
        rating,
      ),
      SeriesNavData(:final title, :final date, :final rating) => (
        title,
        date,
        rating,
      ),
      _ => ('', null, null),
    };
    final year = date != null && date.length >= 4 ? date.substring(0, 4) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        children: [
          DetailsTitleBlock(
            title: title,
            meta: [if (year != null) year],
            rating: rating != null && rating > 0 ? rating : null,
          ),
          const SizedBox(height: Space.x2xl),
          ShimmerLoading(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    block(96, 40),
                    const SizedBox(width: Space.sm),
                    block(96, 40),
                    const SizedBox(width: Space.sm),
                    block(96, 40),
                  ],
                ),
                const SizedBox(height: Space.x2xl),
                block(140, 24),
                const SizedBox(height: Space.sm),
                block(double.infinity, 96),
                const SizedBox(height: Space.x2xl),
                block(160, 24),
                const SizedBox(height: Space.lg),
                Row(
                  children: [
                    for (var i = 0; i < 4; i++) ...[
                      block(80, 80),
                      const SizedBox(width: Space.md),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

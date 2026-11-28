import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/core/season_neighbours.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_cubit.dart';
import 'package:movify/features/details/presentation/cubits/season_cubit/season_state.dart';
import 'package:movify/features/details/presentation/widgets/content_error.dart';
import 'package:movify/features/details/presentation/widgets/details_header.dart';
import 'package:movify/features/details/presentation/widgets/season_bar.dart';
import 'package:movify/features/details/presentation/widgets/season_slivers.dart';
import 'package:movify/features/details/presentation/widgets/season_loading.dart';
import 'package:movify/features/details/presentation/widgets/trailer_player.dart';

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
  /// Episodes beyond the first few appear once the person asks for them.
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final neighbours = SeasonNeighbours(data.seasons, data.seasonNumber);

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      bottomNavigationBar: neighbours.hasSeveral
          ? SeasonBar(
              neighbours: neighbours,
              currentNumber: data.seasonNumber,
              onSelect: (season) => context.replaceWithSeason(data, season),
            )
          : null,
      body: BlocBuilder<SeasonCubit, SeasonState>(
        builder: (context, state) {
          final content = state is SeasonLoaded ? state.content : null;
          final trailer = content?.trailer;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: DetailsHeader(
                  data: data,
                  onPlayTrailer: trailer == null
                      ? null
                      : () => showTrailerPlayer(context, trailer),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: Space.md)),
              if (content != null)
                SeasonSlivers(
                  content: content,
                  showAll: _showAll,
                  onShowAll: () => setState(() => _showAll = true),
                  onEpisode: (episode) =>
                      context.openSeasonEpisode(data, episode),
                )
              else if (state is SeasonError)
                SliverToBoxAdapter(
                  child: ContentError(
                    message: state.message,
                    onRetry: () => context.read<SeasonCubit>().load(
                      data.tmdbId,
                      data.seasonNumber,
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(child: SeasonLoading(data: data)),
            ],
          );
        },
      ),
    );
  }
}

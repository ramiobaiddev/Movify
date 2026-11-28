import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/show_all_button.dart';
import 'package:movify/features/details/presentation/widgets/sort_toggle.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_tile.dart';
import 'package:movify/shared/presentation/widgets/screen_gutter.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';

/// Episodes of a season as slivers, newest first by default, with a sort
/// toggle. Shows the first few and a "Show all episodes" button until
/// [expanded]. Rows are built lazily, so a season with hundreds of episodes
/// only builds what is on screen.
class EpisodesSliver extends StatefulWidget {
  const EpisodesSliver({
    super.key,
    required this.episodes,
    required this.expanded,
    required this.onShowAll,
    required this.onTap,
    required this.today,
  });

  static const int collapsedCount = 5;

  /// Oldest first.
  final List<EpisodeItem> episodes;
  final bool expanded;
  final VoidCallback onShowAll;
  final ValueChanged<EpisodeItem> onTap;
  final DateTime today;

  @override
  State<EpisodesSliver> createState() => _EpisodesSliverState();
}

class _EpisodesSliverState extends State<EpisodesSliver> {
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    final episodes = widget.episodes;
    if (episodes.isEmpty) {
      return const SliverToBoxAdapter();
    }
    final canCollapse = episodes.length > EpisodesSliver.collapsedCount;
    final collapsed = !widget.expanded && canCollapse;
    final count = collapsed ? EpisodesSliver.collapsedCount : episodes.length;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: ScreenGutter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SectionTitle('Episodes'),
                SortToggle(
                  newestFirst: _newestFirst,
                  onTap: () => setState(() => _newestFirst = !_newestFirst),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: Space.x2xl)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          sliver: SliverList.separated(
            itemCount: count,
            separatorBuilder: (_, _) => const SizedBox(height: Space.md),
            itemBuilder: (context, index) {
              final episode = _newestFirst
                  ? episodes[episodes.length - 1 - index]
                  : episodes[index];

              return EpisodeTile(
                episode: episode,
                today: widget.today,
                onTap: () => widget.onTap(episode),
              );
            },
          ),
        ),
        if (collapsed)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: Space.x2xl),
              child: ShowAllButton(
                label: 'Show all episodes',
                onTap: widget.onShowAll,
              ),
            ),
          ),
      ],
    );
  }
}

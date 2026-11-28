import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/season_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/episode_tile.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';

/// Episodes of a season, newest first by default, with a sort toggle. Shows
/// the first few and a "Show all episodes" button until [expanded].
class EpisodesSection extends StatefulWidget {
  const EpisodesSection({
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
  State<EpisodesSection> createState() => _EpisodesSectionState();
}

class _EpisodesSectionState extends State<EpisodesSection> {
  bool _newestFirst = true;

  @override
  Widget build(BuildContext context) {
    final episodes = widget.episodes;
    if (episodes.isEmpty) {
      return const SizedBox.shrink();
    }
    final colors = context.colors;
    final ordered = _newestFirst ? episodes.reversed.toList() : episodes;
    final canCollapse = ordered.length > EpisodesSection.collapsedCount;
    final shown = widget.expanded || !canCollapse
        ? ordered
        : ordered.take(EpisodesSection.collapsedCount).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SectionTitle('Episodes'),
              GestureDetector(
                onTap: () => setState(() => _newestFirst = !_newestFirst),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Text(
                      _newestFirst ? 'Newest' : 'Oldest',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: Space.sm),
                    Icon(
                      Icons.swap_vert_rounded,
                      size: 16,
                      color: colors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.x2xl),
          for (final episode in shown) ...[
            EpisodeTile(
              episode: episode,
              today: widget.today,
              onTap: () => widget.onTap(episode),
            ),
            const SizedBox(height: Space.md),
          ],
          if (!widget.expanded && canCollapse) ...[
            const SizedBox(height: Space.md),
            Center(
              child: GestureDetector(
                onTap: widget.onShowAll,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.primaryDefault, width: 2),
                    borderRadius: BorderRadius.circular(Radii.lg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Space.x3xl,
                      vertical: Space.lg,
                    ),
                    child: Text(
                      'Show all episodes',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

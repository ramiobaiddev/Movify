import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/section_title.dart';

/// Trailers, teasers and clips as thumbnails with their names.
class VideosSection extends StatelessWidget {
  const VideosSection({super.key, required this.videos, required this.onPlay});

  static const double _thumbWidth = 179;
  static const double _thumbHeight = 88;

  final List<VideoItem> videos;
  final ValueChanged<VideoItem> onPlay;

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Space.lg),
          child: SectionTitle('Videos'),
        ),
        const SizedBox(height: Space.lg),
        SizedBox(
          height: _thumbHeight + Space.sm + 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            itemCount: videos.length,
            separatorBuilder: (_, _) => const SizedBox(width: Space.sm),
            itemBuilder: (context, index) => _VideoTile(
              video: videos[index],
              onTap: () => onPlay(videos[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({required this.video, required this.onTap});

  final VideoItem video;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: VideosSection._thumbWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Radii.md),
              child: SizedBox(
                height: VideosSection._thumbHeight,
                width: double.infinity,
                child: ColoredBox(
                  color: colors.surfaceGenre,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://img.youtube.com/vi/${video.youtubeKey}/mqdefault.jpg',
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => const SizedBox.shrink(),
                      ),
                      Center(
                        child: Icon(
                          Icons.play_circle_fill_rounded,
                          size: 32,
                          color: colors.iconPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Space.sm),
            Text(
              video.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textPrimary),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

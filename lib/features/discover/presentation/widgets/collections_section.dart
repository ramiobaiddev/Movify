import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/models/discover_collection.dart';
import 'package:movify/shared/presentation/widgets/common/section_title.dart';

/// Two-column grid of picture cards, one per hand-picked collection.
class CollectionsSection extends StatelessWidget {
  const CollectionsSection({
    super.key,
    required this.kind,
    required this.collections,
    required this.onTap,
  });

  final ContentType kind;
  final List<DiscoverCollection> collections;
  final ValueChanged<DiscoverCollection> onTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionTitle('Collections'),
      const SizedBox(height: Space.lg),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: Space.lg,
        crossAxisSpacing: Space.sm,
        childAspectRatio: 16 / 9,
        children: [
          for (final collection in collections)
            _CollectionCard(
              name: collection.name,
              picture: collection.pictureFor(kind),
              onTap: () => onTap(collection),
            ),
        ],
      ),
    ],
  );
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.name,
    required this.picture,
    required this.onTap,
  });

  final String name;
  final String picture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radii.sm),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: colors.surfaceGenre),
            CachedNetworkImage(
              imageUrl: tmdbImageSize(TmdbImageSize.w500, picture),
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => const SizedBox.shrink(),
            ),
            ColoredBox(color: colors.surfaceBlurBackground.withValues(alpha: 0.4)),
            Positioned(
              left: Space.md,
              bottom: Space.sm,
              child: Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: colors.iconPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

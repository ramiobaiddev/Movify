import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/extensions/search_tile_extention.dart';
import 'package:movify/features/search/presentation/widgets/dismissable.dart';
import 'package:movify/features/search/presentation/widgets/search_history_list_tile_metadata.dart';
import 'package:movify/features/search/presentation/widgets/thumbnail_preview.dart';

/// Single item tile in the recent searches list matching Figma node `163:3019` & `577:4515`.
class SearchHistoryTile extends StatelessWidget {
  const SearchHistoryTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  final SearchHistoryEntity item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  void _openDetails(BuildContext context) {
    final routeName = item.historyContentType == ContentType.movies
        ? RouteName.movieDetail
        : RouteName.tvDetail;

    context.pushNamed(
      routeName,
      pathParameters: {'id': item.id.toString()},
      extra: item.toCardDisplay().toNavigationData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasPoster = item.posterPath.isNotEmpty;
    final imageUrl = hasPoster
        ? tmdbImageSize(TmdbImageSize.w185, item.posterPath)
        : null;

    return CustomDismisable(
      item: item,
      onDelete: onDelete,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openDetails(context),
          borderRadius: BorderRadius.circular(Radii.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Space.sm),
            child: Row(
              children: [
                Icon(
                  Icons.history_rounded,
                  color: colors.iconSecondary,
                  size: 22,
                ),
                const SizedBox(width: Space.lg),
                Expanded(child: SearchHistoryTileMetaData(item: item)),
                if (hasPoster) ...[
                  ThumbnailPreview(imageUrl: imageUrl),
                  const SizedBox(width: Space.lg),
                ],
                Icon(
                  Icons.arrow_outward_rounded,
                  color: colors.iconSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

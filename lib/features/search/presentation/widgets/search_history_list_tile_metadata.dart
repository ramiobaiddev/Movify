import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';

class SearchHistoryTileMetaData extends StatelessWidget {
  const SearchHistoryTileMetaData({super.key, required this.item});

  final SearchHistoryEntity item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final typeLabel = switch (item.historyContentType) {
      ContentType.movies => 'Movie',
      ContentType.series => 'Series',
      ContentType.seasons => 'Season',
      ContentType.episodes => 'Episode',
    };
    return Column(
      spacing: Space.xsm,
      crossAxisAlignment: .start,
      children: [
        Text(
          item.title,
          style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: Space.sm),
        Text(
          typeLabel,
          style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}

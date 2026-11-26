import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/widgets/search_history_empty_state.dart';
import 'package:movify/features/search/presentation/widgets/search_history_tile.dart';

/// Displays the user's recent searches matching Figma node `784:9166`.
class SearchHistoryView extends StatelessWidget {
  const SearchHistoryView({
    super.key,
    required this.history,
    required this.onItemTap,
    required this.onItemDelete,
    required this.onClearAll,
  });

  final List<SearchHistoryEntity> history;
  final ValueChanged<SearchHistoryEntity> onItemTap;
  final ValueChanged<SearchHistoryEntity> onItemDelete;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const SearchHistoryEmptyState();
    }

    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: Space.lg)),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: textTheme.titleMedium?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: onClearAll,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'clear all',
                  style: textTheme.labelMedium?.copyWith(
                    color: colors.primaryDefault,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: Space.lg)),
        SliverList.separated(
          itemCount: history.length,
          separatorBuilder: (_, _) => Divider(
            height: 1,
            indent: Space.lg,
            endIndent: Space.lg,
            color: colors.surfaceDivider.withValues(alpha: 0.1),
          ),
          itemBuilder: (context, index) {
            final item = history[index];
            return SearchHistoryTile(
              item: item,
              onTap: () => onItemTap(item),
              onDelete: () => onItemDelete(item),
            );
          },
        ),
      ],
    );
  }
}

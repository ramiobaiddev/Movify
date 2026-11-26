import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';

class CustomDismisable extends StatelessWidget {
  const CustomDismisable({
    super.key,
    required this.child,
    required this.onDelete,

    required this.item,
  });
  final Widget child;
  final VoidCallback onDelete;
  final SearchHistoryEntity item;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: ValueKey(
        'history_${item.id}_${item.searchedAt.millisecondsSinceEpoch}${item.historyContentType.text}',
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        color: colors.surfaceError,
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete',
              style: textTheme.labelLarge?.copyWith(color: colors.textOnImage),
            ),
            const SizedBox(width: Space.sm),
            Icon(
              Icons.delete_outline_rounded,
              color: colors.textOnImage,
              size: 22,
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}

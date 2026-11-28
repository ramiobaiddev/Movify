import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Series name with an arrow; a tap opens the series page.
class EpisodeSeriesLink extends StatelessWidget {
  const EpisodeSeriesLink({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: colors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: Space.xsm),
          Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: colors.textPrimary,
          ),
        ],
      ),
    );
  }
}

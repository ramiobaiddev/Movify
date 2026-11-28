import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// "Newest ⇅" / "Oldest ⇅" text button that flips a list's order.
class SortToggle extends StatelessWidget {
  const SortToggle({super.key, required this.newestFirst, required this.onTap});

  final bool newestFirst;
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
          Text(
            newestFirst ? 'Newest' : 'Oldest',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(width: Space.sm),
          Icon(Icons.swap_vert_rounded, size: 16, color: colors.textSecondary),
        ],
      ),
    );
  }
}

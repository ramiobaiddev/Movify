import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Looks like a search input but is a button: a tap opens the search screen.
class DiscoverSearchField extends StatelessWidget {
  const DiscoverSearchField({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      label: 'Search for a movie or series',
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.textPrimary, width: 2),
            borderRadius: BorderRadius.circular(Radii.lg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Space.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search for a movie or series',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
                ),
                Icon(Icons.search_rounded, size: 24, color: colors.iconPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';

/// Movies / Series switch: two equal tabs with a bar under the chosen one.
class KindTabs extends StatelessWidget {
  const KindTabs({super.key, required this.kind, required this.onChanged});

  final ContentType kind;
  final ValueChanged<ContentType> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _Tab(
          label: 'Movies',
          selected: kind == ContentType.movies,
          onTap: () => onChanged(ContentType.movies),
        ),
      ),
      const SizedBox(width: Space.sm),
      Expanded(
        child: _Tab(
          label: 'Series',
          selected: kind == ContentType.series,
          onTap: () => onChanged(ContentType.series),
        ),
      ),
    ],
  );
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.md),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: selected ? colors.textPrimary : colors.textContrast,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: selected ? colors.primaryDefault : colors.surfaceDivider,
                borderRadius: BorderRadius.circular(Radii.full),
              ),
              child: const SizedBox(height: 4, width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

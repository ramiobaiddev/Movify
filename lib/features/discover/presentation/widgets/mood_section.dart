import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/discover/presentation/models/mood.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';

/// Gradient tiles, two per row, one per [Mood].
class MoodSection extends StatelessWidget {
  const MoodSection({super.key, required this.onTap});

  final ValueChanged<Mood> onTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionTitle('Pick a mood'),
      const SizedBox(height: Space.lg),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: Space.md,
        crossAxisSpacing: Space.md,
        childAspectRatio: 3.4,
        children: [
          for (final mood in Mood.values)
            _MoodTile(mood: mood, onTap: () => onTap(mood)),
        ],
      ),
    ],
  );
}

class _MoodTile extends StatelessWidget {
  const _MoodTile({required this.mood, required this.onTap});

  final Mood mood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ink = mood.dark ? colors.textInvert : colors.iconPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [mood.from, mood.to]),
          borderRadius: BorderRadius.circular(Radii.sm),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Row(
            children: [
              Icon(mood.icon, size: 16, color: ink),
              const SizedBox(width: Space.sm),
              Expanded(
                child: Text(
                  mood.label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: ink),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

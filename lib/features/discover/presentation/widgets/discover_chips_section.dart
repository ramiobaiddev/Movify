import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';

/// A section title over a wrapping row of chips. Used for genres and decades.
class DiscoverChipsSection extends StatelessWidget {
  const DiscoverChipsSection({
    super.key,
    required this.title,
    required this.labels,
    required this.onTap,
    this.onTitleTap,
  });

  final String title;
  final List<String> labels;
  final ValueChanged<int> onTap;

  /// When set, the title shows an arrow and opens the full list.
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (onTitleTap == null)
        SectionTitle(title)
      else
        GestureDetector(
          onTap: onTitleTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTitle(title),
              const SizedBox(width: Space.xsm),
              Icon(
                Icons.chevron_right_rounded,
                size: 24,
                color: context.colors.textPrimary,
              ),
            ],
          ),
        ),
      const SizedBox(height: Space.lg),
      Wrap(
        spacing: Space.sm,
        runSpacing: Space.sm,
        children: [
          for (var i = 0; i < labels.length; i++)
            AppChip(label: labels[i], selected: false, onTap: () => onTap(i)),
        ],
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/common/section_title.dart';

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
      SectionTitle(title, onTap: onTitleTap),
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

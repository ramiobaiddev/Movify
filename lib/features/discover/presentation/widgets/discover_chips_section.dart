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
  });

  final String title;
  final List<String> labels;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionTitle(title),
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

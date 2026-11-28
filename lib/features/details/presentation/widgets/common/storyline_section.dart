import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/common/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/common/section_title.dart';

class StorylineSection extends StatelessWidget {
  const StorylineSection({super.key, required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionTitle('Storyline'),
      const SizedBox(height: Space.sm),
      ExpandableText(text: overview),
    ],
  );
}

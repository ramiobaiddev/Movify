import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Category title in See All top bar.
class SeeAllCategoryTitle extends StatelessWidget {
  const SeeAllCategoryTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = context.colors;

    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
    );
  }
}

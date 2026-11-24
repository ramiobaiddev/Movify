import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_back_button.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_category_title.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_reset_button.dart';

/// Top bar for See All screen matching Figma node 913:9548.
/// Composed of back button and category title on left, and optional Reset button on right.
class SeeAllTopBar extends StatelessWidget {
  const SeeAllTopBar({
    super.key,
    required this.title,
    this.showResetButton = true,
    this.onBackTap,
    this.onResetTap,
  });

  final String title;
  final bool showResetButton;
  final VoidCallback? onBackTap;
  final VoidCallback? onResetTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: Space.lg,
      vertical: Space.md,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SeeAllBackButton(onTap: onBackTap),
            const SizedBox(width: Space.md),
            SeeAllCategoryTitle(title: title),
          ],
        ),
        if (showResetButton && onResetTap != null)
          SeeAllResetButton(onReset: onResetTap!),
      ],
    ),
  );
}

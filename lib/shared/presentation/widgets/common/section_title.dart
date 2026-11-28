import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// 24/32 bold title above a section of a screen. With [onTap] a forward
/// chevron follows the text and the whole title opens the full list.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final title = Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(color: colors.textPrimary),
    );
    if (onTap == null) {
      return title;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: title),
          const SizedBox(width: Space.xsm),
          Icon(Icons.chevron_right_rounded, size: 24, color: colors.textSecondary),
        ],
      ),
    );
  }
}

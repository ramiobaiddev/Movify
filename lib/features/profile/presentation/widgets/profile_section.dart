import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Grouped settings section with header and rounded card container matching Figma `Frame 391`.
class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Space.xsm, bottom: Space.sm),
          child: Text(
            title.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              color: colors.textContrast,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surfaceProfileRow,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.15),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: Space.lg,
                    endIndent: Space.lg,
                    color: colors.surfaceDivider,
                  ),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

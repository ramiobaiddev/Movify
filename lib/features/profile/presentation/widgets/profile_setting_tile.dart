import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable 56px profile settings row matching Figma node `534:5439`.
class ProfileSettingTile extends StatelessWidget {
  const ProfileSettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.trailing,
    this.isDestructive = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? value;
  final Widget? trailing;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final iconColor = colors.iconSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            child: Row(
              children: [
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (value != null) ...[
                  Text(
                    value!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textContrast,
                    ),
                  ),
                  const SizedBox(width: Space.sm),
                ],
                trailing ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

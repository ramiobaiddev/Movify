import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/cards/person_avatar.dart';

/// Round photo with a name and an optional line underneath. Used by the Home
/// Popular actors row and the Cast & crew row of a details screen.
class PersonAvatarCard extends StatelessWidget {
  const PersonAvatarCard({
    super.key,
    required this.name,
    required this.onTap,
    this.profilePath,
    this.subtitle,
    this.avatarSize = 86,
  });

  /// Height of a card at the default [avatarSize] (photo, name, subtitle).
  static const double height = 150;

  final String name;
  final String? profilePath;

  /// Second line under the name (department, character...). Hidden when null.
  final String? subtitle;
  final double avatarSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: avatarSize + Space.sm,
        child: Column(
          children: [
            PersonAvatar(profilePath: profilePath, size: avatarSize),
            const SizedBox(height: Space.sm),
            Text(
              name,
              style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: textTheme.bodySmall?.copyWith(color: colors.textContrast),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

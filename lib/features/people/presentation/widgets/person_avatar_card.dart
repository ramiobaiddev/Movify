import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/person_avatar.dart';

/// Round photo with name and department underneath, used in the Home row.
class PersonAvatarCard extends StatelessWidget {
  const PersonAvatarCard({
    super.key,
    required this.person,
    required this.onTap,
  });

  static const double width = 92;
  static const double avatarSize = 86;
  static const double height = 150;

  final PersonItem person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            PersonAvatar(profilePath: person.profilePath, size: avatarSize),
            const SizedBox(height: Space.sm),
            Text(
              person.name,
              style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              person.knownForDepartment ?? 'Acting',
              style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
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

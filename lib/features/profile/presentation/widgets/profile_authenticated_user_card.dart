import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/auth/domain/entities/user_entity.dart';
import 'package:movify/features/profile/presentation/widgets/profile_user_avatar.dart';

/// User profile header card for authenticated users matching Figma `Frame 384`.
class ProfileAuthenticatedUserCard extends StatelessWidget {
  const ProfileAuthenticatedUserCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final name = (user.displayName != null && user.displayName!.trim().isNotEmpty)
        ? user.displayName!
        : 'Movie Fan';
    final email = user.email ?? '';

    return Container(
      padding: const EdgeInsets.all(Space.md),
      decoration: BoxDecoration(
        color: colors.surfaceProfileRow,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(
          color: colors.surfaceDivider.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          ProfileUserAvatar(photoUrl: user.photoUrl),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (email.isNotEmpty) ...[
                  const SizedBox(height: Space.xsm),
                  Text(
                    email,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

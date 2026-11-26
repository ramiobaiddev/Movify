import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/profile/presentation/widgets/profile_user_avatar.dart';

/// User profile header card for guest mode matching Figma `Frame 384`.
class ProfileGuestUserCard extends StatelessWidget {
  const ProfileGuestUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

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
          const ProfileUserAvatar(),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Guest Mode',
                  style: textTheme.titleSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Space.xsm),
                Text(
                  'Sign in to sync your favorites & data',
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.textContrast,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.sm),
          AppChip(
            label: 'Sign in',
            selected: true,
            pill: true,
            onTap: () => context.pushNamed(RouteName.login),
          ),
        ],
      ),
    );
  }
}

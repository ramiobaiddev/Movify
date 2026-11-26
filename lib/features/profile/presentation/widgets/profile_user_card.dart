import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/auth/presentation/cubits/session_cubit.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';

/// User profile header card displaying avatar, name, and email matching Figma `Frame 384`.
class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        final (
          String? name,
          String? subtitle,
          String? photoUrl,
          bool isGuest,
        ) = switch (state) {
          SessionAuthenticated(:final user) => (
            user.displayName!.isNotEmpty ? user.displayName : 'Movie Fan',
            user.email,
            user.photoUrl,
            false,
          ),
          SessionGuest() => (
            'Guest User',
            'Sign in to sync your favorites & data',
            null,
            true,
          ),
          _ => (
            'Guest User',
            'Sign in to sync your favorites & data',
            null,
            true,
          ),
        };

        return Container(
          padding: const EdgeInsets.all(Space.md),
          decoration: BoxDecoration(
            color: colors.surfaceContainerTonal,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                  width: 64,
                  height: 64,
                  color: colors.surfaceGenre,
                  child: photoUrl != null && photoUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: photoUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, _, _) => Image.asset(
                            Assets.imagesProfileAvatar,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.person_rounded,
                              size: 32,
                              color: colors.iconSecondary,
                            ),
                          ),
                        )
                      : Image.asset(
                          Assets.imagesProfileAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Icon(
                            Icons.person_rounded,
                            size: 32,
                            color: colors.iconSecondary,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name ?? '',
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Space.xsm),
                    Text(
                      subtitle ?? '',
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isGuest) ...[
                const SizedBox(width: Space.sm),
                AppChip(
                  label: 'Sign in',
                  selected: true,
                  pill: true,
                  onTap: () => context.pushNamed(RouteName.login),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

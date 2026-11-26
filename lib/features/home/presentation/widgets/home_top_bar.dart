import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';

/// Top bar matching Figma node 822:7652:
/// - "Movify" branding on the left (24px bold Montserrat)
/// - 48x48 squircle search and notification buttons on the right (node 811:7504)
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    this.onSearchTap,
    this.onNotificationTap,
    this.hasUnreadNotifications = true,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    // final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.lg,
        vertical: Space.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Movify', style: textTheme.titleLarge),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ActionSquircleButton(
                icon: Icons.search_rounded,
                onTap: onSearchTap ?? () => context.pushNamed(RouteName.search),
              ),
              const SizedBox(width: Space.sm),
              _NotificationSquircleButton(
                onTap: onNotificationTap,
                hasUnread: hasUnreadNotifications,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionSquircleButton extends StatelessWidget {
  const _ActionSquircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.lg),
        child: Ink(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.surfaceContainerTonal,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.5),
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: colors.iconPrimary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationSquircleButton extends StatelessWidget {
  const _NotificationSquircleButton({
    required this.onTap,
    required this.hasUnread,
  });

  final VoidCallback? onTap;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.lg),
        child: Ink(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colors.surfaceContainerTonal,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: colors.surfaceDivider.withValues(alpha: 0.5),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: colors.iconPrimary,
                size: 24,
              ),
              if (hasUnread)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colors.surfaceError,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

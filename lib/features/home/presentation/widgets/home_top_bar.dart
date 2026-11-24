import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Top bar matching Figma node 822:7652:
/// - "Movify" branding on the left (24px bold Montserrat)
/// - 48x48 squircle notification button on the right (node 811:7504)
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
    this.onNotificationTap,
    this.hasUnreadNotifications = true,
  });

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
          _NotificationSquircleButton(
            onTap: onNotificationTap,
            hasUnread: hasUnreadNotifications,
          ),
        ],
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

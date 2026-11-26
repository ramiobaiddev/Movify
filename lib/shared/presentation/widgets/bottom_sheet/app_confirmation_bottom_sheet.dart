import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable modal confirmation bottom sheet matching Figma component `Bottom Sheet dialog`
/// (Figma nodes `567:3646`, `567:3526`, `801:16816`).
class AppConfirmationBottomSheet extends StatelessWidget {
  const AppConfirmationBottomSheet({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
    this.cancelLabel = 'Cancel',
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String description;
  final String confirmLabel;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final String cancelLabel;

  static Future<void> show(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    required String title,
    required String description,
    required String confirmLabel,
    required Color confirmColor,
    required VoidCallback onConfirm,
    String cancelLabel = 'Cancel',
  }) {
    final colors = context.colors;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: BoxConstraints(maxWidth: MediaQuery.widthOf(context)),
      backgroundColor: colors.surfaceBottomSheet,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (_) => AppConfirmationBottomSheet(
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        title: title,
        description: description,
        confirmLabel: confirmLabel,
        confirmColor: confirmColor,
        onConfirm: onConfirm,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceBottomSheet,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Space.lg,
            Space.md,
            Space.lg,
            Space.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Centered drag handle matching Figma node 567:3131 (w: 45, h: 4)
              Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.surfaceDivider,
                  borderRadius: BorderRadius.circular(Radii.full),
                ),
              ),
              const SizedBox(height: Space.xl),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: iconColor),
              ),
              const SizedBox(height: Space.md),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: colors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Space.xsm),
              Text(
                description,
                style: textTheme.bodySmall?.copyWith(
                  color: colors.textContrast,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Space.xl),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    context.pop();
                    onConfirm();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: confirmColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.lg),
                    ),
                  ),
                  child: Text(
                    confirmLabel,
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.textOnImage,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Space.sm),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () => context.pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.buttonSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.lg),
                    ),
                  ),
                  child: Text(
                    cancelLabel,
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.textOnImage,
                    ),
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

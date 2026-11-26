import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_confirmation_bottom_sheet.dart';

/// Delete account confirmation bottom sheet matching Figma node `567:3220` / `801:16816`.
class DeleteAccountSheet {
  const DeleteAccountSheet._();

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmDelete,
  }) {
    final colors = context.colors;

    return AppConfirmationBottomSheet.show(
      context,
      icon: Icons.delete_forever_rounded,
      iconColor: colors.surfaceError,
      iconBackgroundColor: colors.surfaceError.withValues(alpha: 0.15),
      title: 'Delete your account?',
      description:
          'Your account and your synced favorites will be permanently deleted. This can\'t be undone.',
      confirmLabel: 'Delete account',
      confirmColor: colors.surfaceError,
      onConfirm: onConfirmDelete,
    );
  }
}

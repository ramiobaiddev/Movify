import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_confirmation_bottom_sheet.dart';

/// Sign out confirmation bottom sheet matching Figma node `567:3374` / `567:3526`.
class SignOutSheet {
  const SignOutSheet._();

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmSignOut,
  }) {
    final colors = context.colors;

    return AppConfirmationBottomSheet.show(
      context,
      icon: Icons.logout_rounded,
      iconColor: colors.buttonPrimary,
      iconBackgroundColor: colors.buttonPrimary.withValues(alpha: 0.15),
      title: 'Sign out of Movify?',
      description:
          'Your favorites stay saved in your account. Sign back in any time to see them on this or another device.',
      confirmLabel: 'Sign out',
      confirmColor: colors.buttonPrimary,
      onConfirm: onConfirmSignOut,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_confirmation_bottom_sheet.dart';

/// Confirmation bottom sheet to clear viewing history matching Figma node `567:3615`.
class ClearViewingHistorySheet extends StatelessWidget {
  const ClearViewingHistorySheet({
    super.key,
    required this.onConfirmClear,
  });

  final VoidCallback onConfirmClear;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmClear,
  }) {
    final colors = context.colors;

    return AppConfirmationBottomSheet.show(
      context,
      icon: Icons.history_rounded,
      iconColor: colors.surfaceError,
      iconBackgroundColor: colors.surfaceError.withValues(alpha: 0.15),
      title: 'Clear viewing history?',
      description:
          'This removes your recently viewed titles and the "Continue exploring" row on this device. Your favorites and reminders aren\'t affected.',
      confirmLabel: 'Clear history',
      confirmColor: colors.surfaceError,
      onConfirm: onConfirmClear,
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

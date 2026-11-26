import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Confirmation bottom sheet to clear viewing history matching Figma node `567:3615`.
class ClearViewingHistorySheet extends StatelessWidget {
  const ClearViewingHistorySheet({super.key, required this.onConfirmClear});

  final VoidCallback onConfirmClear;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmClear,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ClearViewingHistorySheet(onConfirmClear: onConfirmClear),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return AppBottomSheet(
      title: 'Clear viewing history?',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Space.lg,
          Space.xsm,
          Space.lg,
          Space.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Space.lg),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: colors.surfaceError.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_sweep_rounded,
                size: 28,
                color: colors.surfaceError,
              ),
            ),
            const SizedBox(height: Space.md),

            Text(
              'This will remove all recently viewed titles from your Home feed activity.',
              style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: Space.md),
                      side: BorderSide(
                        color: colors.surfaceDivider.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Radii.md),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Space.md),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      onConfirmClear();
                      context.pop();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colors.surfaceError,
                      padding: const EdgeInsets.symmetric(vertical: Space.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Radii.md),
                      ),
                    ),
                    child: Text(
                      'Clear',
                      style: textTheme.labelLarge?.copyWith(
                        color: colors.textOnImage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Reusable bottom sheet header matching Figma specifications.
/// Supports optical centering, optional leading/trailing action (e.g. Reset), and close button.
class AppBottomSheetHeader extends StatelessWidget {
  const AppBottomSheetHeader({
    super.key,
    required this.title,
    this.action,
    this.onClose,
  });

  final String title;
  final Widget? action;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final closeButton = IconButton(
      onPressed: onClose ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.close_rounded,
        color: colors.iconPrimary,
        size: 24,
      ),
      splashRadius: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
    );

    if (action != null) {
      // If an action (like Reset) is provided, place close on left and action on right
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          closeButton,
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          action!,
        ],
      );
    }

    // Default: optical spacer on left, title in center, close button on right
    return Row(
      children: [
        const SizedBox(width: 40, height: 40),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        closeButton,
      ],
    );
  }
}

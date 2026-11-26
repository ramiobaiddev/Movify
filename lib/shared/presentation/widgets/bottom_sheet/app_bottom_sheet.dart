import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_header.dart';

/// Reusable modal bottom sheet container matching Figma styling (36px radius, dark surface).
/// Supports intrinsic height for short option sheets and bounded scrollable height for tall sheets.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.action,
    this.bottomBar,
    this.isScrollable = false,
    this.maxHeightFactor = 0.85,
    this.onClose,
  });

  final String title;
  final Widget child;
  final Widget? action;
  final Widget? bottomBar;
  final bool isScrollable;
  final double maxHeightFactor;
  final VoidCallback? onClose;

  /// Turnkey modal presentation helper.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    Widget? action,
    Widget? bottomBar,
    bool isScrollable = false,
    double maxHeightFactor = 0.85,
    VoidCallback? onClose,
  }) {
    final colors = context.colors;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: colors.surfaceBottomSheet,
      constraints: BoxConstraints(maxWidth: MediaQuery.widthOf(context)),
      barrierColor: Colors.black.withValues(alpha: 0.65),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (_) => AppBottomSheet(
        title: title,
        action: action,
        bottomBar: bottomBar,
        isScrollable: isScrollable,
        maxHeightFactor: maxHeightFactor,
        onClose: onClose,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    if (isScrollable) {
      final maxHeight = MediaQuery.sizeOf(context).height * maxHeightFactor;

      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            Space.lg,
            Space.md,
            Space.lg,
            bottomInset + Space.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBottomSheetHeader(
                title: title,
                action: action,
                onClose: onClose,
              ),
              const SizedBox(height: Space.md),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: child,
                ),
              ),
              if (bottomBar != null) ...[
                const SizedBox(height: Space.md),
                bottomBar!,
              ],
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.lg,
        Space.md,
        Space.lg,
        bottomInset + Space.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBottomSheetHeader(title: title, action: action, onClose: onClose),
          const SizedBox(height: Space.md),
          child,
          if (bottomBar != null) ...[
            const SizedBox(height: Space.md),
            bottomBar!,
          ],
        ],
      ),
    );
  }
}

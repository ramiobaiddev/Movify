import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Bottom bar to step through a sequence: previous, a button that opens the
/// full list, next. Used for seasons and, later, episodes.
///
/// A side is greyed out and ignores taps when its callback is null.
class SequenceNavBar extends StatelessWidget {
  const SequenceNavBar({
    super.key,
    required this.centerLabel,
    required this.onCenter,
    this.previousLabel = 'Previous',
    this.onPrevious,
    required this.nextLabel,
    this.onNext,
  });

  static const double height = 84;
  static const double _sideWidth = 80;
  static const double _unavailableOpacity = 0.42;

  final String centerLabel;
  final VoidCallback onCenter;
  final String previousLabel;
  final VoidCallback? onPrevious;
  final String nextLabel;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.surfaceBottomSheet),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Side(
                label: previousLabel,
                icon: Icons.chevron_left_rounded,
                onTap: onPrevious,
              ),
              const SizedBox(width: Space.md),
              GestureDetector(
                onTap: onCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primaryDefault,
                    borderRadius: BorderRadius.circular(Radii.lg),
                  ),
                  child: SizedBox(
                    width: 169,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_rounded,
                          size: 16,
                          color: colors.iconPrimary,
                        ),
                        const SizedBox(width: Space.sm),
                        Text(
                          centerLabel,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(color: colors.iconPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Space.md),
              _Side(
                label: nextLabel,
                icon: Icons.chevron_right_rounded,
                onTap: onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Side extends StatelessWidget {
  const _Side({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Opacity(
      opacity: onTap == null ? SequenceNavBar._unavailableOpacity : 1,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: SequenceNavBar._sideWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: colors.iconPrimary),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.visible,
                softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

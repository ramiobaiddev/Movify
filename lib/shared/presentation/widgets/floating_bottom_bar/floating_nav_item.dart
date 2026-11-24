import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Single interactive tab item inside the floating navigation bar (Figma node 825:8265).
/// - Active: Blue capsule border with icon and text label.
/// - Inactive: Subtle touch-friendly outline icon.
class FloatingNavItem extends StatelessWidget {
  const FloatingNavItem({
    super.key,
    required this.isSelected,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.onTap,
    this.isTablet = false,
  });

  final bool isSelected;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final horizontalPadding = isTablet
        ? (isSelected ? Space.xl : Space.lg)
        : (isSelected ? Space.lg : Space.md);
    final verticalPadding = isTablet ? 12.0 : 10.0;
    final iconSize = isTablet ? 22.0 : 20.0;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primaryDefault.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(
              color: isSelected ? colors.primaryDefault : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : unselectedIcon,
                color: isSelected ? colors.primaryDefault : colors.iconPrimary,
                size: iconSize,
              ),
              if (isSelected) ...[
                SizedBox(width: isTablet ? Space.md : Space.sm),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: colors.textSecondary),
                  child: Text(label),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

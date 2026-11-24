import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/floating_bottom_bar/floating_nav_item.dart';
import 'package:movify/shared/presentation/widgets/size_config.dart';

class FloatingBottomBarDestination {
  const FloatingBottomBarDestination({
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
  });

  final String label;
  final IconData selectedIcon;
  final IconData unselectedIcon;
}

/// Floating stadium pill navigation bar matching Figma node 827:8542.
/// - Dark stadium container (#14151a) with radius 99px.
/// - Centers horizontally and floats above content.
class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<FloatingBottomBarDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final screenWidth = MediaQuery.widthOf(context);
    final isTablet = screenWidth >= SizeConfig.tablet;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset > 0 ? Space.sm : (isTablet ? Space.lg : Space.md),
          left: Space.lg,
          right: Space.lg,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: isTablet ? (screenWidth * 0.58).clamp(500.0, 640.0) : null,
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? Space.lg : Space.md,
              vertical: isTablet ? Space.md : Space.sm,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceBottomSheet,
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: colors.surfaceDivider.withValues(alpha: 0.4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: isTablet ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: isTablet
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: List.generate(destinations.length, (index) {
                final dest = destinations[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet
                        ? 6.0
                        : (index > 0 && index < destinations.length
                              ? 4.0
                              : 0.0),
                  ),
                  child: FloatingNavItem(
                    isSelected: currentIndex == index,
                    selectedIcon: dest.selectedIcon,
                    unselectedIcon: dest.unselectedIcon,
                    label: dest.label,
                    isTablet: isTablet,
                    onTap: () => onTap(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Top centered drag handle indicator for bottom sheets matching Figma specs.
class AppBottomSheetDragHandle extends StatelessWidget {
  const AppBottomSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Container(
        width: 38,
        height: 4,
        margin: const EdgeInsets.only(top: Space.xsm, bottom: Space.xsm),
        decoration: BoxDecoration(
          color: colors.surfaceDivider,
          borderRadius: BorderRadius.circular(Radii.full),
        ),
      ),
    );
  }
}

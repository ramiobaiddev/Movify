import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';

class HeaderCircle extends StatelessWidget {
  const HeaderCircle({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.colors.surfaceBlurBackground,
      borderRadius: BorderRadius.circular(Radii.lg),
    ),
    child: SizedBox.square(dimension: 36, child: Center(child: child)),
  );
}

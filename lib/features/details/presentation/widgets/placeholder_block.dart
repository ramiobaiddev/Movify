import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Grey rounded box that stands in for content while it loads.
class PlaceholderBlock extends StatelessWidget {
  const PlaceholderBlock({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.colors.surfaceGenre,
      borderRadius: BorderRadius.circular(Radii.md),
    ),
    child: SizedBox(width: width, height: height),
  );
}

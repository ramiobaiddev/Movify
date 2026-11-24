import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_utlis.dart';

/// Skeleton placeholder for the Hero 3D carousel while trending items load.
class HomeHeroSkeleton extends StatelessWidget {
  const HomeHeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final s = deckScale(w);
        final h = deckHeight(w);
        final spacing = deckSpacing(w);

        return SizedBox(
          height: h + spacing + 70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Center card skeleton
              Container(
                width: 196 * s,
                height: 295 * s,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerTonal,
                  borderRadius: BorderRadius.circular(Radii.lg),
                ),
              ),
              SizedBox(height: spacing),
              // Title skeleton
              Container(
                width: 160 * s,
                height: 20 * s,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerTonal,
                  borderRadius: BorderRadius.circular(Radii.sm),
                ),
              ),
              SizedBox(height: Space.sm * s),
              // Chips skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70 * s,
                    height: 24 * s,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerTonal,
                      borderRadius: BorderRadius.circular(Radii.sm),
                    ),
                  ),
                  SizedBox(width: Space.sm * s),
                  Container(
                    width: 50 * s,
                    height: 24 * s,
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerTonal,
                      borderRadius: BorderRadius.circular(Radii.sm),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

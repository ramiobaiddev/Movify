import 'package:flutter/material.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_flow_delegate.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_model.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_utlis.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/stacked_carousel_card.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

class StackedCardsOrbitView extends StatelessWidget {
  final List<CardDisplayModel> cards;
  final int current;
  final int direction;
  final AnimationController controller;

  const StackedCardsOrbitView({
    super.key,
    required this.cards,
    required this.current,
    required this.direction,
    required this.controller,
  });

  List<OrbitSlot> _buildSlots(double w) {
    final visibleCount = visibleCountForWidth(w);
    final half = visibleCount ~/ 2;

    final slots = <OrbitSlot>[];
    for (int o = -half; o <= half; o++) {
      final dist = o.abs();
      slots.add(
        OrbitSlot(
          offset: o,
          x: slotX(o, w),
          y: slotY(o, w),
          rotation: slotRotation(o),
          scale: slotScale(o, w),
          opacity: slotOpacity(o),
          z: (half - dist + 1).toDouble(),
        ),
      );
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final slots = _buildSlots(w);

        final children = slots.map((slot) {
          final index = orbitIndex(current, slot.offset, cards.length);
          final card = cards[index];
          return RepaintBoundary(
            key: ValueKey<int>(slot.offset),
            child: StackedCarouselCard(posterPath: card.posterPath),
          );
        }).toList();

        return Flow(
          clipBehavior: Clip.none,
          delegate: OrbitFlowDelegate(
            controller: controller,
            slots: slots,
            direction: direction,
          ),
          children: children,
        );
      },
    );
  }
}

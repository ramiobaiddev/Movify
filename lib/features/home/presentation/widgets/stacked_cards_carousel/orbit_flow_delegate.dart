import 'package:flutter/material.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_model.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/orbit_utlis.dart';

/// FlowDelegate implementing Option 1: "Cinematic Depth Glide" with Tablet Adaptive Scaling
class OrbitFlowDelegate extends FlowDelegate {
  final AnimationController controller;
  final List<OrbitSlot> slots;
  final int direction;

  OrbitFlowDelegate({
    required this.controller,
    required this.slots,
    required this.direction,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final tRaw = controller.value;
    final eased = Curves.easeOutCubic.transform(tRaw);
    final s = deckScale(context.size.width);

    // Sort cards by calculated z-index so top cards paint over deeper cards
    final indices = List.generate(slots.length, (i) => i);
    indices.sort((a, b) => _zOf(a, eased).compareTo(_zOf(b, eased)));

    final cx = context.size.width / 2;
    // Responsive Y-anchor
    final cy = 150.0 * s;

    for (final i in indices) {
      final from = slots[i];
      final to = _targetSlotFor(from);

      final x = _lerp(from.x, to.x, eased);
      final y = _lerp(from.y, to.y, eased);
      final rot = _lerp(from.rotation, to.rotation, eased);
      final scale = _lerp(from.scale, to.scale, eased);
      final opacity = _lerp(from.opacity, to.opacity, eased).clamp(0.0, 1.0);

      final childSize = context.getChildSize(i);
      final childW = childSize?.width ?? 196.0;
      final childH = childSize?.height ?? 295.0;

      final matrix = Matrix4.identity()
        ..translate(cx + x, cy + y)
        ..rotateZ(rot)
        ..scale(scale)
        ..translate(-childW / 2, -childH / 2);

      context.paintChild(i, transform: matrix, opacity: opacity);
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  double _zOf(int i, double eased) {
    final from = slots[i];
    final to = _targetSlotFor(from);
    return _lerp(from.z, to.z, eased);
  }

  OrbitSlot _targetSlotFor(OrbitSlot from) {
    final idx = slots.indexWhere((s) => s.offset == from.offset);
    if (direction == 1) {
      return slots[(idx - 1).clamp(0, slots.length - 1)];
    } else if (direction == -1) {
      return slots[(idx + 1).clamp(0, slots.length - 1)];
    }
    return from;
  }

  @override
  bool shouldRepaint(OrbitFlowDelegate old) =>
      old.controller != controller ||
      old.direction != direction ||
      old.slots != slots;

  @override
  Size getSize(BoxConstraints constraints) {
    final s = deckScale(constraints.maxWidth);
    return Size(constraints.maxWidth, 310 * s);
  }
}

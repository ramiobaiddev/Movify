import 'dart:math';

import 'package:flutter/material.dart';

class ParticleBurst extends StatelessWidget {
  const ParticleBurst({
    super.key,
    required this.progress,
    required this.radius,
    required this.count,
    required this.color,
  });

  final double progress;
  final double radius;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      for (var i = 0; i < count; i++)
        Transform.translate(
          offset: Offset.fromDirection(2 * pi * i / count, radius * progress),
          child: Opacity(
            opacity: 1 - progress,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: const SizedBox(width: 4, height: 4),
            ),
          ),
        ),
    ],
  );
}

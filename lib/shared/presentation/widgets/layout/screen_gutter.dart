import 'package:flutter/widgets.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Side padding for content that sits next to full-bleed rows.
class ScreenGutter extends StatelessWidget {
  const ScreenGutter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Space.lg),
    child: child,
  );
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// A spinner, or the given [child], centred under a header.
class CenteredStatus extends StatelessWidget {
  const CenteredStatus({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
    child: Center(child: child ?? const CircularProgressIndicator.adaptive()),
  );
}

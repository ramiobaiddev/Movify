import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// 24/32 bold title above a section of a screen.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(
      context,
    ).textTheme.headlineMedium?.copyWith(color: context.colors.textPrimary),
  );
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Outlined "Show all …" button centred under a collapsed list.
class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.primaryDefault, width: 2),
            borderRadius: BorderRadius.circular(Radii.lg),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.x3xl,
              vertical: Space.lg,
            ),
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: colors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

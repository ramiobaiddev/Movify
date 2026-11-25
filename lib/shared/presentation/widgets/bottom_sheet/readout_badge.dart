import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Live summary at the top of a filter sheet: an icon, the current value and a
/// one-line explanation. While [active] is false (no filter) it is muted.
class ReadoutBadge extends StatelessWidget {
  const ReadoutBadge({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.active,
    this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool active;

  /// Icon colour while [active]; defaults to the primary button colour.
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    final color = active ? (accent ?? colors.buttonPrimary) : colors.iconSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.md),
      decoration: BoxDecoration(
        color: colors.surfaceContainerTonal.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: colors.surfaceDivider.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: active
                  ? color.withValues(alpha: 0.15)
                  : colors.surfaceContainerTonal.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: text.titleMedium?.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: text.bodySmall?.copyWith(color: colors.textContrast),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

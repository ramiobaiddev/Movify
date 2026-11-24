import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';

/// One chip for every "pick this" control: genres, studios, presets and the
/// filter bar.
///
///  - [selected] fills the chip with the brand colour.
///  - [showCheck] adds a check mark while selected (multi-select chips).
///  - [trailing] replaces the check, e.g. a dropdown arrow or a clear button.
///  - [pill] uses fully rounded corners instead of [Radii.md].
///  - [outlined] drops the fill while not selected.
///
/// Inside an `Expanded` the label is centred; inside a `Wrap` it hugs its text.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.showCheck = false,
    this.trailing,
    this.pill = false,
    this.outlined = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool showCheck;
  final Widget? trailing;
  final bool pill;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(pill ? Radii.full : Radii.md);
    final textColor = selected ? colors.textOnImage : colors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.sm,
          ),
          decoration: BoxDecoration(
            color: selected
                ? colors.surfaceGenreSelected
                : (outlined ? Colors.transparent : colors.surfaceGenre),
            borderRadius: radius,
            border: selected
                ? null
                : Border.all(
                    color: colors.surfaceDivider.withValues(
                      alpha: outlined ? 0.6 : 0.3,
                    ),
                  ),
          ),
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: textColor),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: Space.xsm),
                  trailing!,
                ] else if (selected && showCheck) ...[
                  const SizedBox(width: Space.xsm),
                  Icon(Icons.check_rounded, size: 16, color: textColor),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

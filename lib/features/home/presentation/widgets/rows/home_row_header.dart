import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Title on the left; optional Movies/Series chip and See all on the right.
class HomeRowHeader extends StatelessWidget {
  const HomeRowHeader({
    super.key,
    required this.title,
    this.kindLabel,
    this.onKindTap,
    this.onSeeAll,
  });

  final String title;

  /// Current kind label; shows the chip when [onKindTap] is also set.
  final String? kindLabel;
  final VoidCallback? onKindTap;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.headlineSmall?.copyWith(color: colors.textPrimary),
            ),
          ),
          if (kindLabel != null && onKindTap != null) ...[
            const SizedBox(width: Space.sm),
            _KindChip(label: kindLabel!, onTap: onKindTap!),
          ],
          if (onSeeAll != null) ...[
            const SizedBox(width: Space.sm),
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: text.labelLarge?.copyWith(color: colors.primaryDefault),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surfaceGenre,
      borderRadius: BorderRadius.circular(Radii.full),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.full),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.md,
            vertical: Space.xsm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(width: Space.xsm),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: colors.iconPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

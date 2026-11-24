import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/home/presentation/widgets/rows/kind_chip.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Title + forward caret on the left (taps to See all); optional Movies/Series chip on the right.
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
      padding: const EdgeInsets.symmetric(
        horizontal: Space.lg,
        vertical: Space.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Title + Forward Caret (Navigates to See all) ──
          Flexible(
            child: Semantics(
              button: onSeeAll != null,
              label: '$title ${AppLocalizations.of(context)!.seeAll}',
              child: GestureDetector(
                onTap: onSeeAll,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.headlineSmall,
                      ),
                    ),
                    if (onSeeAll != null) ...[
                      const SizedBox(width: Space.xsm),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24,
                        color: colors.iconSecondary,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // ── Kind Chip (Movies / TV shows switcher) ──
          if (kindLabel != null && onKindTap != null) ...[
            const SizedBox(width: Space.md),
            KindChip(label: kindLabel!, onTap: onKindTap!),
          ],
        ],
      ),
    );
  }
}

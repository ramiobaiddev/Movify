import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Top bar for About View matching Figma node `569:4111`.
class AboutTopBar extends StatelessWidget {
  const AboutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.md),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(Radii.lg),
            child: Ink(
              padding: EdgeInsets.zero,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colors.iconPrimary,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: Space.md),
          Text(l10n?.about ?? 'About', style: textTheme.titleLarge),
        ],
      ),
    );
  }
}

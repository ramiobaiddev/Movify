import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Bottom sheet to pick Movies or Series. Returns the picked kind, or null if
/// dismissed.
Future<ContentType?> showMediaKindSheet(
  BuildContext context, {
  required ContentType selected,
}) => showModalBottomSheet<ContentType>(
  context: context,
  backgroundColor: context.colors.surfaceBottomSheet,
  showDragHandle: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.xl)),
  ),
  builder: (_) => _MediaKindSheet(selected: selected),
);

class _MediaKindSheet extends StatelessWidget {
  const _MediaKindSheet({required this.selected});

  final ContentType selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.lg, Space.none, Space.lg, Space.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Option(
              label: l10n.movies,
              isSelected: selected == ContentType.movies,
              onTap: () => Navigator.of(context).pop(ContentType.movies),
            ),
            Divider(height: 1, color: context.colors.surfaceDivider),
            _Option(
              label: l10n.tvShows,
              isSelected: selected == ContentType.series,
              onTap: () => Navigator.of(context).pop(ContentType.series),
            ),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Space.lg),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? colors.primaryDefault : colors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_rounded, color: colors.primaryDefault),
          ],
        ),
      ),
    );
  }
}

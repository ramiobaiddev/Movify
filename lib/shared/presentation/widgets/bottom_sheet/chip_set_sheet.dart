import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/draft_sheet.dart';

/// Multi-select sheet: a wrap of chips, each an `(label, id)` pair.
/// Genres and studios/networks are both this with a different list.
abstract final class ChipSetSheet {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<(String label, int id)> options,
    required Set<int> initial,
    required ValueChanged<Set<int>> onApply,
  }) => DraftSheet.show<Set<int>>(
    context,
    title: title,
    initial: initial,
    emptyValue: const {},
    onApply: onApply,
    builder: (context, selected, set) => Padding(
      padding: const EdgeInsets.only(top: Space.sm),
      child: Wrap(
        spacing: Space.sm,
        runSpacing: Space.sm,
        children: [
          for (final (label, id) in options)
            AppChip(
              label: label,
              selected: selected.contains(id),
              showCheck: true,
              onTap: () => set(
                selected.contains(id)
                    ? (Set.of(selected)..remove(id))
                    : (Set.of(selected)..add(id)),
              ),
            ),
        ],
      ),
    ),
  );
}

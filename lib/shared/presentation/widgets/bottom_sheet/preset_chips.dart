import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// One scrolling row of quick-pick chips. A preset is selected when its value
/// equals [selected] (records and numbers compare by value).
class PresetChips<T> extends StatelessWidget {
  const PresetChips({
    super.key,
    required this.presets,
    required this.selected,
    required this.onSelect,
  });

  final List<(String label, T value)> presets;
  final T selected;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      spacing: Space.xsm,
      children: [
        for (final (label, value) in presets)
          AppChip(
            label: label,
            pill: true,
            selected: value == selected,
            onTap: () => onSelect(value),
          ),
      ],
    ),
  );
}

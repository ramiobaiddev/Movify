import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Filter bar chip: an arrow while idle, a clear button once a value is set.
class SeeAllFilterChip extends StatelessWidget {
  const SeeAllFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final canClear = isSelected && onClear != null;

    return AppChip(
      label: label,
      selected: isSelected,
      outlined: true,
      onTap: onTap,
      trailing: canClear
          ? GestureDetector(
              onTap: onClear,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: colors.textOnImage,
              ),
            )
          : Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: isSelected ? colors.textOnImage : colors.iconContrast,
            ),
    );
  }
}

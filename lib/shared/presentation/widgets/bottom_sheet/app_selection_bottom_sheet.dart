import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_radio_tile.dart';

/// Turnkey generic single-selection bottom sheet for enum or value lists.
class AppSelectionBottomSheet<T> extends StatelessWidget {
  const AppSelectionBottomSheet({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelect,
  });

  final List<(String label, T value)> options;
  final T selectedValue;
  final ValueChanged<T> onSelect;

  /// Displays the selection bottom sheet and returns the picked value.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<(String label, T value)> options,
    required T selectedValue,
    bool? isScrollable,
  }) => AppBottomSheet.show<T>(
    context,
    title: title,
    isScrollable: isScrollable ?? (options.length > 6),
    child: AppSelectionBottomSheet<T>(
      options: options,
      selectedValue: selectedValue,
      onSelect: (val) => Navigator.of(context).pop(val),
    ),
  );

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final (label, value) in options) ...[
        AppBottomSheetRadioTile(
          title: label,
          isSelected: selectedValue == value,
          onTap: () => onSelect(value),
        ),
        const SizedBox(height: Space.sm),
      ],
    ],
  );
}

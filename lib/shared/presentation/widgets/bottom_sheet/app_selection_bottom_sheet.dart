import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_radio_tile.dart';

/// Single option model for [AppSelectionBottomSheet].
class AppSelectionOption<T> {
  final String label;
  final String? subtitle;
  final T value;

  const AppSelectionOption(
    this.label,
    this.value, {
    this.subtitle,
  });
}

/// Generic selection bottom sheet for choosing from a list of options using radio tiles.
class AppSelectionBottomSheet<T> extends StatelessWidget {
  const AppSelectionBottomSheet({
    super.key,
    required this.options,
    required this.selectedValue,
    this.onSelect,
  });

  final List<AppSelectionOption<T>> options;
  final T selectedValue;
  final ValueChanged<T>? onSelect;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppSelectionOption<T>> options,
    required T selectedValue,
    bool? isScrollable,
  }) =>
      AppBottomSheet.show<T>(
        context,
        title: title,
        isScrollable: isScrollable ?? (options.length > 6),
        child: AppSelectionBottomSheet<T>(
          options: options,
          selectedValue: selectedValue,
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in options) ...[
            AppBottomSheetRadioTile(
              title: option.label,
              subtitle: option.subtitle,
              isSelected: selectedValue == option.value,
              onTap: () {
                if (onSelect != null) {
                  onSelect!(option.value);
                } else {
                  Navigator.of(context, rootNavigator: true).pop(option.value);
                }
              },
            ),
            const SizedBox(height: Space.sm),
          ],
        ],
      );
}

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
///
/// Long lists ([scrollable]) are built lazily, so a series with dozens of
/// seasons does not build every row when the sheet opens.
class AppSelectionBottomSheet<T> extends StatelessWidget {
  const AppSelectionBottomSheet({
    super.key,
    required this.options,
    required this.selectedValue,
    this.onSelect,
    this.scrollable = false,
  });

  final List<AppSelectionOption<T>> options;
  final T selectedValue;
  final ValueChanged<T>? onSelect;
  final bool scrollable;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<AppSelectionOption<T>> options,
    required T selectedValue,
    bool? isScrollable,
  }) {
    final scrollable = isScrollable ?? (options.length > 6);

    return AppBottomSheet.show<T>(
      context,
      title: title,
      isScrollable: scrollable,
      lazyList: scrollable,
      child: AppSelectionBottomSheet<T>(
        options: options,
        selectedValue: selectedValue,
        scrollable: scrollable,
      ),
    );
  }

  void _select(BuildContext context, T value) {
    if (onSelect != null) {
      onSelect!(value);
    } else {
      Navigator.of(context, rootNavigator: true).pop(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (scrollable) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(height: Space.sm),
        itemBuilder: (context, index) => _OptionTile<T>(
          option: options[index],
          selected: selectedValue == options[index].value,
          onTap: () => _select(context, options[index].value),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final option in options) ...[
          _OptionTile<T>(
            option: option,
            selected: selectedValue == option.value,
            onTap: () => _select(context, option.value),
          ),
          const SizedBox(height: Space.sm),
        ],
      ],
    );
  }
}

class _OptionTile<T> extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final AppSelectionOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => AppBottomSheetRadioTile(
    title: option.label,
    subtitle: option.subtitle,
    isSelected: selected,
    onTap: onTap,
  );
}

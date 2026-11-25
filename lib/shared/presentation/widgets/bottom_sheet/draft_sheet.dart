import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/filter_action_buttons.dart';

/// A bottom sheet that edits a copy of a value and only hands it back when
/// the user taps Apply. Dismissing the sheet changes nothing.
///
/// Every filter sheet is this plus a body:
///
///   DraftSheet.show<double?>(
///     context,
///     title: 'Rating',
///     initial: current,
///     emptyValue: null,                      // what Reset goes back to
///     onApply: (value) => ...,
///     builder: (context, value, set) => MySlider(value: value, onChanged: set),
///   );
class DraftSheet<T> extends StatefulWidget {
  const DraftSheet({
    super.key,
    required this.initial,
    required this.emptyValue,
    required this.onApply,
    required this.builder,
  });

  final T initial;

  /// The value Reset puts back (no filter).
  final T emptyValue;
  final ValueChanged<T> onApply;

  /// Builds the body from the current draft; call `set` to change it.
  final Widget Function(BuildContext context, T value, ValueChanged<T> set)
  builder;

  static Future<void> show<T>(
    BuildContext context, {
    required String title,
    required T initial,
    required T emptyValue,
    required ValueChanged<T> onApply,
    required Widget Function(BuildContext context, T value, ValueChanged<T> set)
    builder,
  }) => AppBottomSheet.show<void>(
    context,
    title: title,
    child: DraftSheet<T>(
      initial: initial,
      emptyValue: emptyValue,
      onApply: onApply,
      builder: builder,
    ),
  );

  @override
  State<DraftSheet<T>> createState() => _DraftSheetState<T>();
}

class _DraftSheetState<T> extends State<DraftSheet<T>> {
  late T _draft = widget.initial;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.7,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: widget.builder(
              context,
              _draft,
              (value) => setState(() => _draft = value),
            ),
          ),
        ),
        const SizedBox(height: Space.lg),
        FilterActionButtons(
          onReset: () => setState(() => _draft = widget.emptyValue),
          onApply: () {
            widget.onApply(_draft);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

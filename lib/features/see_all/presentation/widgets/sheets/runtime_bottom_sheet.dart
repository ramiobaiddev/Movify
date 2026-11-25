import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/filter_action_buttons.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/runtime/runtime_preset_chips.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/runtime/runtime_range_slider_bar.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/runtime/runtime_readout_badge.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Dedicated Runtime Bottom Sheet with dual-thumb duration range slider and presets.
class RuntimeBottomSheet extends StatefulWidget {
  const RuntimeBottomSheet({
    super.key,
    required this.initialMinRuntime,
    required this.initialMaxRuntime,
    required this.onApply,
  });

  final int? initialMinRuntime;
  final int? initialMaxRuntime;
  final void Function(int? min, int? max) onApply;

  static Future<void> show(
    BuildContext context, {
    required int? minRuntime,
    required int? maxRuntime,
    required void Function(int? min, int? max) onSelectRuntime,
  }) => AppBottomSheet.show<void>(
    context,
    title: 'Runtime',
    isScrollable: false,
    child: RuntimeBottomSheet(
      initialMinRuntime: minRuntime,
      initialMaxRuntime: maxRuntime,
      onApply: onSelectRuntime,
    ),
  );

  @override
  State<RuntimeBottomSheet> createState() => _RuntimeBottomSheetState();
}

class _RuntimeBottomSheetState extends State<RuntimeBottomSheet> {
  late int? _minRuntime;
  late int? _maxRuntime;

  @override
  void initState() {
    super.initState();
    _minRuntime = widget.initialMinRuntime;
    _maxRuntime = widget.initialMaxRuntime;
  }

  void _onReset() {
    setState(() {
      _minRuntime = null;
      _maxRuntime = null;
    });
  }

  void _onApply() {
    widget.onApply(_minRuntime, _maxRuntime);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      RuntimeReadoutBadge(minRuntime: _minRuntime, maxRuntime: _maxRuntime),
      const SizedBox(height: Space.md),
      RuntimePresetChips(
        minRuntime: _minRuntime,
        maxRuntime: _maxRuntime,
        onSelect: (min, max) => setState(() {
          _minRuntime = min;
          _maxRuntime = max;
        }),
      ),
      const SizedBox(height: Space.sm),
      RuntimeRangeSliderBar(
        minRuntime: _minRuntime,
        maxRuntime: _maxRuntime,
        onChanged: (min, max) => setState(() {
          _minRuntime = min;
          _maxRuntime = max;
        }),
      ),
      const SizedBox(height: Space.lg),
      FilterActionButtons(onReset: _onReset, onApply: _onApply),
    ],
  );
}

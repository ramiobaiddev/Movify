import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/release_date/release_date_preset_chips.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/release_date/release_date_range_slider_bar.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/release_date/release_date_readout_badge.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/filter_action_buttons.dart';

/// Dedicated Release Date Bottom Sheet with dual-thumb range slider, readout badge, and decade presets.
class ReleaseDateBottomSheet extends StatefulWidget {
  const ReleaseDateBottomSheet({
    super.key,
    required this.initialFromYear,
    required this.initialToYear,
    required this.onApply,
  });

  final int? initialFromYear;
  final int? initialToYear;
  final void Function(int? from, int? to) onApply;

  static Future<void> show(
    BuildContext context, {
    required int? fromYear,
    required int? toYear,
    required void Function(int? from, int? to) onSelectYears,
  }) => AppBottomSheet.show<void>(
    context,
    title: 'Release Date',
    child: ReleaseDateBottomSheet(
      initialFromYear: fromYear,
      initialToYear: toYear,
      onApply: onSelectYears,
    ),
  );

  @override
  State<ReleaseDateBottomSheet> createState() => _ReleaseDateBottomSheetState();
}

class _ReleaseDateBottomSheetState extends State<ReleaseDateBottomSheet> {
  late int? _fromYear;
  late int? _toYear;

  @override
  void initState() {
    super.initState();
    _fromYear = widget.initialFromYear;
    _toYear = widget.initialToYear;
  }

  void _onReset() {
    setState(() {
      _fromYear = null;
      _toYear = null;
    });
  }

  void _onApply() {
    widget.onApply(_fromYear, _toYear);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ReleaseDateReadoutBadge(fromYear: _fromYear, toYear: _toYear),
      const SizedBox(height: Space.md),
      ReleaseDatePresetChips(
        fromYear: _fromYear,
        toYear: _toYear,
        onSelect: (from, to) => setState(() {
          _fromYear = from;
          _toYear = to;
        }),
      ),
      const SizedBox(height: Space.sm),
      ReleaseDateRangeSliderBar(
        fromYear: _fromYear,
        toYear: _toYear,
        onChanged: (from, to) => setState(() {
          _fromYear = from;
          _toYear = to;
        }),
      ),
      const SizedBox(height: Space.lg),
      FilterActionButtons(onReset: _onReset, onApply: _onApply),
    ],
  );
}

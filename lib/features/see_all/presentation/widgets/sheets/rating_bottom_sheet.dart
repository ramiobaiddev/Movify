import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/rating/rating_preset_chips.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/rating/rating_readout_badge.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/rating/rating_slider_bar.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/shared/filter_action_buttons.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Dedicated Rating Bottom Sheet with interactive slider, readout badge, and presets.
class RatingBottomSheet extends StatefulWidget {
  const RatingBottomSheet({
    super.key,
    required this.initialRating,
    required this.onApply,
  });

  final double? initialRating;
  final ValueChanged<double?> onApply;

  static Future<void> show(
    BuildContext context, {
    required double? selectedRating,
    required ValueChanged<double?> onSelectRating,
  }) => AppBottomSheet.show<void>(
    context,
    title: 'Rating',
    child: RatingBottomSheet(
      initialRating: selectedRating,
      onApply: onSelectRating,
    ),
  );

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  late double? _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _onReset() {
    setState(() {
      _currentRating = null;
    });
  }

  void _onApply() {
    widget.onApply(_currentRating);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      RatingReadoutBadge(rating: _currentRating),
      const SizedBox(height: Space.lg),
      RatingPresetChips(
        selectedRating: _currentRating,
        onSelect: (val) => setState(() => _currentRating = val),
      ),
      const SizedBox(height: Space.sm),
      RatingSliderBar(
        rating: _currentRating,
        onChanged: (val) => setState(() => _currentRating = val),
      ),
      const SizedBox(height: Space.lg),
      FilterActionButtons(onReset: _onReset, onApply: _onApply),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/shared/filter_action_buttons.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/shared/filter_genre_chips.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Dedicated Genre Multi-Selection Bottom Sheet matching Figma node 791:14106.
class GenreBottomSheet extends StatefulWidget {
  const GenreBottomSheet({
    super.key,
    required this.kind,
    required this.initialGenreIds,
    required this.onApply,
  });

  final ContentType kind;
  final Set<int> initialGenreIds;
  final ValueChanged<Set<int>> onApply;

  static Future<void> show(
    BuildContext context, {
    required ContentType kind,
    required Set<int> initialGenreIds,
    required ValueChanged<Set<int>> onApply,
  }) => AppBottomSheet.show<void>(
    context,
    title: 'Genres',
    child: GenreBottomSheet(
      kind: kind,
      initialGenreIds: initialGenreIds,
      onApply: onApply,
    ),
  );

  @override
  State<GenreBottomSheet> createState() => _GenreBottomSheetState();
}

class _GenreBottomSheetState extends State<GenreBottomSheet> {
  late Set<int> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set<int>.from(widget.initialGenreIds);
  }

  void _toggle(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _reset() {
    setState(() {
      _selectedIds.clear();
    });
  }

  void _apply() {
    widget.onApply(_selectedIds);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.7,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Space.sm),
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FilterGenreChips(
              kind: widget.kind,
              selectedGenreIds: _selectedIds,
              onToggleGenre: _toggle,
            ),
          ),
        ),
        const SizedBox(height: Space.lg),
        FilterActionButtons(onReset: _reset, onApply: _apply),
      ],
    ),
  );
}

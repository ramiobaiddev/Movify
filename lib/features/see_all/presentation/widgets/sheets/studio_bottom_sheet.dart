import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/shared/filter_action_buttons.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/studio/studio_chip_item.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Dedicated Studios (Movies) and Networks (Series) Bottom Sheet.
class StudioBottomSheet extends StatefulWidget {
  const StudioBottomSheet({
    super.key,
    required this.kind,
    required this.initialStudioIds,
    required this.onApply,
  });

  final ContentType kind;
  final Set<int> initialStudioIds;
  final ValueChanged<Set<int>> onApply;

  static const movieStudios = <(String name, int id)>[
    ('Marvel Studios', 420),
    ('Warner Bros.', 174),
    ('Universal Pictures', 33),
    ('Walt Disney Pictures', 2),
    ('Columbia Pictures', 5),
    ('Paramount', 4),
    ('A24', 41077),
    ('20th Century Studios', 127928),
    ('Pixar', 3),
    ('Lionsgate', 1632),
    ('Netflix', 178464),
  ];

  static const tvNetworks = <(String name, int id)>[
    ('Netflix', 213),
    ('HBO', 49),
    ('Apple TV+', 2552),
    ('Disney+', 2739),
    ('Amazon Prime', 1024),
    ('AMC', 174),
    ('BBC', 4),
    ('Hulu', 453),
  ];

  static Future<void> show(
    BuildContext context, {
    required ContentType kind,
    required Set<int> initialStudioIds,
    required ValueChanged<Set<int>> onApply,
  }) => AppBottomSheet.show<void>(
    context,
    title: kind == ContentType.movies ? 'Studios' : 'Networks',
    child: StudioBottomSheet(
      kind: kind,
      initialStudioIds: initialStudioIds,
      onApply: onApply,
    ),
  );

  @override
  State<StudioBottomSheet> createState() => _StudioBottomSheetState();
}

class _StudioBottomSheetState extends State<StudioBottomSheet> {
  late Set<int> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set<int>.from(widget.initialStudioIds);
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
  Widget build(BuildContext context) {
    final list = widget.kind == ContentType.movies
        ? StudioBottomSheet.movieStudios
        : StudioBottomSheet.tvNetworks;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.65,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: Space.sm,
                runSpacing: Space.sm,
                children: [
                  for (final item in list)
                    StudioChipItem(
                      name: item.$1,
                      isSelected: _selectedIds.contains(item.$2),
                      onTap: () => _toggle(item.$2),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Space.lg),
          FilterActionButtons(onReset: _reset, onApply: _apply),
        ],
      ),
    );
  }
}

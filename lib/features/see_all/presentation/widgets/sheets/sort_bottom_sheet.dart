import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/shared/filter_action_buttons.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/sort/sort_option_tile.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';

/// Dedicated Sort by Bottom Sheet with interactive direction toggle matching Figma design.
class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({
    super.key,
    required this.initialSort,
    required this.onApply,
    this.kind,
  });

  final DiscoverSort initialSort;
  final ValueChanged<DiscoverSort> onApply;
  final ContentType? kind;

  static Future<void> show(
    BuildContext context, {
    required DiscoverSort selectedSort,
    required ValueChanged<DiscoverSort> onSelectSort,
    ContentType? kind,
  }) => AppBottomSheet.show<void>(
    context,
    title: 'Sort by',
    child: SortBottomSheet(
      initialSort: selectedSort,
      onApply: onSelectSort,
      kind: kind,
    ),
  );

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late DiscoverSort _currentSort;

  @override
  void initState() {
    super.initState();
    _currentSort = widget.initialSort;
  }

  void _onSelectPopularity() {
    setState(() {
      if (_currentSort == DiscoverSort.popularityDesc) {
        _currentSort = DiscoverSort.popularityAsc;
      } else if (_currentSort == DiscoverSort.popularityAsc) {
        _currentSort = DiscoverSort.popularityDesc;
      } else {
        _currentSort = DiscoverSort.popularityDesc;
      }
    });
  }

  void _onSelectRating() {
    setState(() {
      if (_currentSort == DiscoverSort.ratingDesc) {
        _currentSort = DiscoverSort.ratingAsc;
      } else if (_currentSort == DiscoverSort.ratingAsc) {
        _currentSort = DiscoverSort.ratingDesc;
      } else {
        _currentSort = DiscoverSort.ratingDesc;
      }
    });
  }

  void _onSelectReleaseDate() {
    setState(() {
      if (_currentSort == DiscoverSort.releaseDateDesc) {
        _currentSort = DiscoverSort.releaseDateAsc;
      } else if (_currentSort == DiscoverSort.releaseDateAsc) {
        _currentSort = DiscoverSort.releaseDateDesc;
      } else {
        _currentSort = DiscoverSort.releaseDateDesc;
      }
    });
  }

  void _onSelectRevenue() {
    setState(() {
      if (_currentSort == DiscoverSort.revenueDesc) {
        _currentSort = DiscoverSort.revenueAsc;
      } else if (_currentSort == DiscoverSort.revenueAsc) {
        _currentSort = DiscoverSort.revenueDesc;
      } else {
        _currentSort = DiscoverSort.revenueDesc;
      }
    });
  }

  void _onReset() {
    setState(() {
      _currentSort = DiscoverSort.popularityDesc;
    });
  }

  void _onApply() {
    widget.onApply(_currentSort);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isPop =
        _currentSort == DiscoverSort.popularityDesc ||
        _currentSort == DiscoverSort.popularityAsc;
    final isRate =
        _currentSort == DiscoverSort.ratingDesc ||
        _currentSort == DiscoverSort.ratingAsc;
    final isDate =
        _currentSort == DiscoverSort.releaseDateDesc ||
        _currentSort == DiscoverSort.releaseDateAsc;
    final isRev =
        _currentSort == DiscoverSort.revenueDesc ||
        _currentSort == DiscoverSort.revenueAsc;
    final showRevenue = widget.kind != ContentType.series;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SortOptionTile(
          title: 'Popularity',
          directionLabel: isPop
              ? (_currentSort.isAscending
                    ? 'Lowest to Highest (Ascending)'
                    : 'Highest to Lowest (Descending)')
              : 'Sort by popularity',
          isSelected: isPop,
          isAscending: isPop && _currentSort.isAscending,
          onTap: _onSelectPopularity,
        ),
        const SizedBox(height: Space.sm),
        SortOptionTile(
          title: 'Rating',
          directionLabel: isRate
              ? (_currentSort.isAscending
                    ? 'Lowest to Highest (Ascending)'
                    : 'Highest to Lowest (Descending)')
              : 'Sort by user rating',
          isSelected: isRate,
          isAscending: isRate && _currentSort.isAscending,
          onTap: _onSelectRating,
        ),
        const SizedBox(height: Space.sm),
        SortOptionTile(
          title: 'Release date',
          directionLabel: isDate
              ? (_currentSort.isAscending ? 'Oldest First' : 'Newest First')
              : 'Sort by release date',
          isSelected: isDate,
          isAscending: isDate && _currentSort.isAscending,
          onTap: _onSelectReleaseDate,
        ),
        if (showRevenue) ...[
          const SizedBox(height: Space.sm),
          SortOptionTile(
            title: 'Revenue',
            directionLabel: isRev
                ? (_currentSort.isAscending
                      ? 'Lowest Box Office First (↑)'
                      : 'Highest Box Office First (↓)')
                : 'Sort by box office gross',
            isSelected: isRev,
            isAscending: isRev && _currentSort.isAscending,
            onTap: _onSelectRevenue,
          ),
        ],
        const SizedBox(height: Space.lg),
        FilterActionButtons(onReset: _onReset, onApply: _onApply),
      ],
    );
  }
}

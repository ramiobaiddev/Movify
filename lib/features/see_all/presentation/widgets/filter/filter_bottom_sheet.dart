import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_action_buttons.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_genre_chips.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_media_kind_switcher.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_section_title.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_sheet_header.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_sort_options.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';
import 'package:movify/shared/domain/enums/discover_sort.dart';
import 'package:movify/shared/domain/genre_mapping.dart';

/// Modal bottom sheet matching Figma filter design for See All screen.
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialKind,
    required this.initialFilters,
    required this.onApply,
  });

  final ContentType initialKind;
  final DiscoverFilters initialFilters;
  final void Function(ContentType kind, DiscoverFilters filters) onApply;

  /// Helper method to present the modal sheet.
  static Future<void> show(
    BuildContext context, {
    required ContentType initialKind,
    required DiscoverFilters initialFilters,
    required void Function(ContentType kind, DiscoverFilters filters) onApply,
  }) {
    final colors = context.colors;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surfaceBottomSheet,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      builder: (context) => FilterBottomSheet(
        initialKind: initialKind,
        initialFilters: initialFilters,
        onApply: onApply,
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ContentType _kind;
  late Set<int> _genreIds;
  late DiscoverSort _sort;

  @override
  void initState() {
    super.initState();
    _kind = widget.initialKind;
    _genreIds = Set<int>.from(widget.initialFilters.genreIds);
    _sort = widget.initialFilters.sort;
  }

  void _onKindChanged(ContentType newKind) {
    if (_kind == newKind) return;
    final conversion = GenreMapping.convert(_genreIds, from: _kind, to: newKind);
    setState(() {
      _kind = newKind;
      _genreIds = conversion.mapped;
    });
  }

  void _onToggleGenre(int genreId) {
    setState(() {
      if (_genreIds.contains(genreId)) {
        _genreIds.remove(genreId);
      } else {
        _genreIds.add(genreId);
      }
    });
  }

  void _onSortChanged(DiscoverSort newSort) {
    setState(() {
      _sort = newSort;
    });
  }

  void _reset() {
    setState(() {
      _genreIds.clear();
      _sort = DiscoverSort.popularity;
    });
  }

  void _apply() {
    final updatedFilters = widget.initialFilters.copyWith(
      sort: _sort,
      genreIds: _genreIds,
    );
    widget.onApply(_kind, updatedFilters);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.85;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Space.md),
              FilterSheetHeader(
                onClose: () => Navigator.of(context).pop(),
                onReset: _reset,
              ),
              const SizedBox(height: Space.md),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FilterSectionTitle(title: 'Media Type'),
                      const SizedBox(height: Space.sm),
                      FilterMediaKindSwitcher(
                        selectedKind: _kind,
                        onKindChanged: _onKindChanged,
                      ),
                      const SizedBox(height: Space.xl),
                      const FilterSectionTitle(title: 'Genres'),
                      const SizedBox(height: Space.sm),
                      FilterGenreChips(
                        kind: _kind,
                        selectedGenreIds: _genreIds,
                        onToggleGenre: _onToggleGenre,
                      ),
                      const SizedBox(height: Space.xl),
                      const FilterSectionTitle(title: 'Sort by'),
                      const SizedBox(height: Space.sm),
                      FilterSortOptions(
                        selectedSort: _sort,
                        onSortChanged: _onSortChanged,
                      ),
                      const SizedBox(height: Space.xl),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Space.md),
                child: FilterActionButtons(
                  onReset: _reset,
                  onApply: _apply,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

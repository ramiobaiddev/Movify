import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/see_all_filter_chip.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/see_all_media_switcher.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/genre_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/language_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/rating_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/release_date_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/runtime_bottom_sheet.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/studio_bottom_sheet.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

/// One chip of the bar: what it says, whether a value is set, how to open its
/// sheet, and the filters with this value cleared.
class _FilterChipSpec {
  const _FilterChipSpec({
    required this.label,
    required this.active,
    required this.onOpen,
    required this.cleared,
  });

  final String label;
  final bool active;
  final VoidCallback onOpen;
  final DiscoverFilters cleared;
}

/// Movies/Series switch followed by one chip per filter. Opening a sheet and
/// applying its result happens here; the screen only receives the new filters.
class SeeAllFilterBar extends StatelessWidget {
  const SeeAllFilterBar({
    super.key,
    required this.kind,
    required this.filters,
    required this.onKindChanged,
    required this.onFiltersChanged,
  });

  final ContentType kind;
  final DiscoverFilters filters;
  final ValueChanged<ContentType> onKindChanged;
  final ValueChanged<DiscoverFilters> onFiltersChanged;

  /// "First" or "First +2" for a multi-select filter.
  static String _firstPlusMore(String first, int count) =>
      count == 1 ? first : '$first +${count - 1}';

  String _genreLabel(BuildContext context) {
    if (filters.genreIds.isEmpty) {
      return 'Genres';
    }
    final id = filters.genreIds.first;
    final name = kind == ContentType.movies
        ? MovieGenre.values.where((g) => g.id == id).firstOrNull
        : TvGenre.values.where((g) => g.id == id).firstOrNull;
    return _firstPlusMore(
      name?.localizedText(context) ?? '',
      filters.genreIds.length,
    );
  }

  String _ratingLabel() => filters.minRating == null
      ? 'Rating'
      : '★ ${filters.minRating!.toStringAsFixed(1)}+';

  String _dateLabel() {
    final (from, to) = (filters.fromYear, filters.toYear);
    if (from == null && to == null) {
      return 'Release date';
    }
    if (from != null && to != null) {
      return from == to ? '$from' : '$from-$to';
    }
    return from != null ? '$from+' : '≤ $to';
  }

  String _runtimeLabel() {
    final (min, max) = (filters.minRuntime, filters.maxRuntime);
    if (min == null && max == null) {
      return 'Runtime';
    }
    if (min != null && max != null) {
      return '$min–${max}m';
    }
    return min != null ? '>$min m' : '<$max m';
  }

  String _studioLabel() {
    final isMovie = kind == ContentType.movies;
    if (filters.studioIds.isEmpty) {
      return isMovie ? 'Studios' : 'Networks';
    }
    final list = isMovie
        ? StudioBottomSheet.movieStudios
        : StudioBottomSheet.tvNetworks;
    final id = filters.studioIds.first;
    final name = list.where((item) => item.$2 == id).firstOrNull?.$1;
    return _firstPlusMore(name ?? 'Selected', filters.studioIds.length);
  }

  List<_FilterChipSpec> _specs(BuildContext context) {
    final f = filters;
    return [
      _FilterChipSpec(
        label: _genreLabel(context),
        active: f.genreIds.isNotEmpty,
        cleared: f.copyWith(genreIds: const {}),
        onOpen: () => GenreBottomSheet.show(
          context,
          kind: kind,
          initialGenreIds: f.genreIds,
          onApply: (ids) => onFiltersChanged(f.copyWith(genreIds: ids)),
        ),
      ),
      _FilterChipSpec(
        label: _ratingLabel(),
        active: f.minRating != null,
        cleared: f.copyWith(minRating: () => null),
        onOpen: () => RatingBottomSheet.show(
          context,
          selectedRating: f.minRating,
          onSelectRating: (r) =>
              onFiltersChanged(f.copyWith(minRating: () => r)),
        ),
      ),
      _FilterChipSpec(
        label: _dateLabel(),
        active: f.fromYear != null || f.toYear != null,
        cleared: f.copyWith(fromYear: () => null, toYear: () => null),
        onOpen: () => ReleaseDateBottomSheet.show(
          context,
          fromYear: f.fromYear,
          toYear: f.toYear,
          onSelectYears: (from, to) => onFiltersChanged(
            f.copyWith(fromYear: () => from, toYear: () => to),
          ),
        ),
      ),
      _FilterChipSpec(
        label: f.languageCode == null
            ? 'Language'
            : LanguageBottomSheet.nameFor(f.languageCode!),
        active: f.languageCode != null,
        cleared: f.copyWith(languageCode: () => null),
        onOpen: () => LanguageBottomSheet.show(
          context,
          selectedLanguage: f.languageCode,
          onSelectLanguage: (code) =>
              onFiltersChanged(f.copyWith(languageCode: () => code)),
        ),
      ),
      _FilterChipSpec(
        label: _runtimeLabel(),
        active: f.minRuntime != null || f.maxRuntime != null,
        cleared: f.copyWith(minRuntime: () => null, maxRuntime: () => null),
        onOpen: () => RuntimeBottomSheet.show(
          context,
          minRuntime: f.minRuntime,
          maxRuntime: f.maxRuntime,
          onSelectRuntime: (min, max) => onFiltersChanged(
            f.copyWith(minRuntime: () => min, maxRuntime: () => max),
          ),
        ),
      ),
      _FilterChipSpec(
        label: _studioLabel(),
        active: f.studioIds.isNotEmpty,
        cleared: f.copyWith(studioIds: const {}),
        onOpen: () => StudioBottomSheet.show(
          context,
          kind: kind,
          initialStudioIds: f.studioIds,
          onApply: (ids) => onFiltersChanged(f.copyWith(studioIds: ids)),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: Space.lg),
    child: Row(
      spacing: Space.sm,
      children: [
        SeeAllMediaSwitcher(selectedKind: kind, onKindChanged: onKindChanged),
        for (final spec in _specs(context))
          SeeAllFilterChip(
            label: spec.label,
            isSelected: spec.active,
            onTap: spec.onOpen,
            onClear: spec.active ? () => onFiltersChanged(spec.cleared) : null,
          ),
      ],
    ),
  );
}

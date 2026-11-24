import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/see_all_filter_chip.dart';
import 'package:movify/features/see_all/presentation/widgets/filter_bar/see_all_media_switcher.dart';
import 'package:movify/features/see_all/presentation/widgets/sheets/studio_bottom_sheet.dart';
import 'package:movify/shared/domain/entites/discover_filters.dart';

/// Horizontal scrolling filter bar right beneath the top bar matching Figma node 785:10086.
class SeeAllFilterBar extends StatelessWidget {
  const SeeAllFilterBar({
    super.key,
    required this.kind,
    required this.filters,
    required this.onKindChanged,
    required this.onOpenGenres,
    required this.onClearGenres,
    required this.onOpenRating,
    required this.onClearRating,
    required this.onOpenReleaseDate,
    required this.onClearReleaseDate,
    required this.onOpenLanguage,
    required this.onClearLanguage,
    required this.onOpenRuntime,
    required this.onClearRuntime,
    required this.onOpenStudios,
    required this.onClearStudios,
  });

  final ContentType kind;
  final DiscoverFilters filters;
  final ValueChanged<ContentType> onKindChanged;
  final VoidCallback onOpenGenres;
  final VoidCallback onClearGenres;
  final VoidCallback onOpenRating;
  final VoidCallback onClearRating;
  final VoidCallback onOpenReleaseDate;
  final VoidCallback onClearReleaseDate;
  final VoidCallback onOpenLanguage;
  final VoidCallback onClearLanguage;
  final VoidCallback onOpenRuntime;
  final VoidCallback onClearRuntime;
  final VoidCallback onOpenStudios;
  final VoidCallback onClearStudios;

  String _formatGenreLabel(BuildContext context) {
    if (filters.genreIds.isEmpty) return 'Genres';
    final firstId = filters.genreIds.first;
    String firstName = '';
    if (kind == ContentType.movies) {
      final match = MovieGenre.values.where((g) => g.id == firstId);
      if (match.isNotEmpty) firstName = match.first.localizedText(context);
    } else {
      final match = TvGenre.values.where((g) => g.id == firstId);
      if (match.isNotEmpty) firstName = match.first.localizedText(context);
    }
    if (filters.genreIds.length == 1) return firstName;
    return '$firstName +${filters.genreIds.length - 1}';
  }

  String _formatRatingLabel() {
    if (filters.minRating == null) return 'Rating';
    return '★ ${filters.minRating!.toStringAsFixed(1)}+';
  }

  String _formatDateLabel() {
    if (filters.fromYear == null && filters.toYear == null) {
      return 'Release date';
    }
    if (filters.fromYear != null && filters.toYear != null) {
      if (filters.fromYear == filters.toYear) return '${filters.fromYear}';
      return '${filters.fromYear}-${filters.toYear}';
    }
    if (filters.fromYear != null) return '${filters.fromYear}+';
    return '≤ ${filters.toYear}';
  }

  String _formatLanguageLabel() {
    if (filters.languageCode == null) return 'Language';
    const langNames = <String, String>{
      'en': 'English',
      'ko': 'Korean',
      'ja': 'Japanese',
      'es': 'Spanish',
      'fr': 'French',
      'ar': 'Arabic',
      'de': 'German',
      'it': 'Italian',
      'tr': 'Turkish',
      'hi': 'Hindi',
      'zh': 'Chinese',
    };
    return langNames[filters.languageCode] ?? filters.languageCode!.toUpperCase();
  }

  String _formatRuntimeLabel() {
    final min = filters.minRuntime;
    final max = filters.maxRuntime;
    if (min == null && max == null) return 'Runtime';
    if (min != null && max != null) return '${min}–${max}m';
    if (min != null) return '>$min m';
    return '<$max m';
  }

  String _formatStudioLabel() {
    final isMovie = kind == ContentType.movies;
    if (filters.studioIds.isEmpty) {
      return isMovie ? 'Studios' : 'Networks';
    }
    final list = isMovie
        ? StudioBottomSheet.movieStudios
        : StudioBottomSheet.tvNetworks;
    final firstId = filters.studioIds.first;
    final match = list.where((item) => item.$2 == firstId);
    final firstName = match.isNotEmpty ? match.first.$1 : 'Selected';
    if (filters.studioIds.length == 1) return firstName;
    return '$firstName +${filters.studioIds.length - 1}';
  }

  @override
  Widget build(BuildContext context) {
    final hasGenres = filters.genreIds.isNotEmpty;
    final hasRating = filters.minRating != null;
    final hasDate = filters.fromYear != null || filters.toYear != null;
    final hasLanguage = filters.languageCode != null;
    final hasRuntime = filters.minRuntime != null || filters.maxRuntime != null;
    final hasStudios = filters.studioIds.isNotEmpty;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Row(
        children: [
          SeeAllMediaSwitcher(
            selectedKind: kind,
            onKindChanged: onKindChanged,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatGenreLabel(context),
            isSelected: hasGenres,
            onTap: onOpenGenres,
            onClear: hasGenres ? onClearGenres : null,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatRatingLabel(),
            isSelected: hasRating,
            onTap: onOpenRating,
            onClear: hasRating ? onClearRating : null,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatDateLabel(),
            isSelected: hasDate,
            onTap: onOpenReleaseDate,
            onClear: hasDate ? onClearReleaseDate : null,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatLanguageLabel(),
            isSelected: hasLanguage,
            onTap: onOpenLanguage,
            onClear: hasLanguage ? onClearLanguage : null,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatRuntimeLabel(),
            isSelected: hasRuntime,
            onTap: onOpenRuntime,
            onClear: hasRuntime ? onClearRuntime : null,
          ),
          const SizedBox(width: Space.sm),
          SeeAllFilterChip(
            label: _formatStudioLabel(),
            isSelected: hasStudios,
            onTap: onOpenStudios,
            onClear: hasStudios ? onClearStudios : null,
          ),
        ],
      ),
    );
  }
}

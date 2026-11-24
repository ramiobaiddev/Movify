import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';
import 'package:movify/features/see_all/presentation/widgets/filter/filter_genre_chip.dart';

/// Wrap collection of genre chips based on selected media kind.
class FilterGenreChips extends StatelessWidget {
  const FilterGenreChips({
    super.key,
    required this.kind,
    required this.selectedGenreIds,
    required this.onToggleGenre,
  });

  final ContentType kind;
  final Set<int> selectedGenreIds;
  final ValueChanged<int> onToggleGenre;

  @override
  Widget build(BuildContext context) {
    if (kind == ContentType.movies) {
      return Wrap(
        spacing: Space.sm,
        runSpacing: Space.sm,
        children: [
          for (final genre in MovieGenre.values)
            FilterGenreChip(
              label: genre.localizedText(context),
              isSelected: selectedGenreIds.contains(genre.id),
              onTap: () => onToggleGenre(genre.id),
            ),
        ],
      );
    }

    return Wrap(
      spacing: Space.sm,
      runSpacing: Space.sm,
      children: [
        for (final genre in TvGenre.values)
          FilterGenreChip(
            label: genre.localizedText(context),
            isSelected: selectedGenreIds.contains(genre.id),
            onTap: () => onToggleGenre(genre.id),
          ),
      ],
    );
  }
}

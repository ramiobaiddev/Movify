import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';

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
            AppChip(
              label: genre.localizedText(context),
              selected: selectedGenreIds.contains(genre.id),
              showCheck: true,
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
          AppChip(
            label: genre.localizedText(context),
            selected: selectedGenreIds.contains(genre.id),
            showCheck: true,
            onTap: () => onToggleGenre(genre.id),
          ),
      ],
    );
  }
}

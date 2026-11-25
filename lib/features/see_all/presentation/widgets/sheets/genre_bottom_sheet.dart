import 'package:flutter/material.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/core/enum/movie_genre.dart';
import 'package:movify/features/discover/core/enum/tv_genre.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/chip_set_sheet.dart';

/// Genre multi-select for the current kind (movie and TV ids differ).
abstract final class GenreBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required ContentType kind,
    required Set<int> initialGenreIds,
    required ValueChanged<Set<int>> onApply,
  }) => ChipSetSheet.show(
    context,
    title: 'Genres',
    initial: initialGenreIds,
    onApply: onApply,
    options: kind == ContentType.movies
        ? [for (final g in MovieGenre.values) (g.localizedText(context), g.id)]
        : [for (final g in TvGenre.values) (g.localizedText(context), g.id)],
  );
}

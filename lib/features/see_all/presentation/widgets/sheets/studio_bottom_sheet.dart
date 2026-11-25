import 'package:flutter/material.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/chip_set_sheet.dart';

/// Studios (movies) or networks (series) multi-select. Ids are TMDB company
/// ids for movies and network ids for series.
abstract final class StudioBottomSheet {
  static const movieStudios = <(String label, int id)>[
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

  static const tvNetworks = <(String label, int id)>[
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
  }) => ChipSetSheet.show(
    context,
    title: kind == ContentType.movies ? 'Studios' : 'Networks',
    initial: initialStudioIds,
    onApply: onApply,
    options: kind == ContentType.movies ? movieStudios : tvNetworks,
  );
}

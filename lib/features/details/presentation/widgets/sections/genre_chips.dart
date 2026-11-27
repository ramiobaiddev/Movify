import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';

/// Genres as chips that wrap onto as many lines as needed. Tapping one opens
/// that genre's list.
class GenreChips extends StatelessWidget {
  const GenreChips({super.key, required this.genres, required this.onTap});

  final List<DetailsGenre> genres;
  final ValueChanged<DetailsGenre> onTap;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: Space.sm,
    runSpacing: Space.sm,
    children: [
      for (final genre in genres)
        AppChip(
          label: genre.name,
          selected: false,
          onTap: () => onTap(genre),
        ),
    ],
  );
}

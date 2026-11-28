import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/models/discover_genre.dart';
import 'package:movify/features/discover/presentation/models/discover_links.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';

/// Every genre for one kind, opened from the arrow next to "Genres".
class GenresScreen extends StatelessWidget {
  const GenresScreen({super.key, required this.kind});

  final ContentType kind;

  @override
  Widget build(BuildContext context) {
    final genres = GenreOption.forKind(kind);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeeAllTopBar(
                title: 'Genres',
                showResetButton: false,
                onBackTap: Navigator.of(context).maybePop,
              ),
              const SizedBox(height: Space.lg),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: Space.x3xl),
                  child: Wrap(
                    spacing: Space.sm,
                    runSpacing: Space.sm,
                    children: [
                      for (final genre in genres)
                        AppChip(
                          label: genre.name,
                          selected: false,
                          onTap: () =>
                              context.openGenre(kind, genre.id, genre.name),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

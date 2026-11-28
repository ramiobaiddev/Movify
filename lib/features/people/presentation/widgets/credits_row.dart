import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_row_header.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/cards/media_poster_card.dart';

/// Header and a horizontal list of poster cards from an in-memory list.
///
/// The whole filmography is already loaded, so this needs no paging; only the
/// first [maxItems] are built and See all shows the rest.
class CreditsRow extends StatelessWidget {
  const CreditsRow({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
    required this.onSeeAll,
    this.maxItems = 20,
  });

  final String title;
  final List<CardDisplayModel> items;
  final ValueChanged<CardDisplayModel> onItemTap;
  final VoidCallback onSeeAll;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    final count = items.length < maxItems ? items.length : maxItems;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeRowHeader(title: title, onSeeAll: onSeeAll),
        const SizedBox(height: Space.sm),
        SizedBox(
          height: PosterRowMetrics.height(context),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            itemCount: count,
            separatorBuilder: (_, _) => const SizedBox(width: Space.md),
            itemBuilder: (context, index) {
              final item = items[index];
              return MediaPosterCard(item: item, onTap: () => onItemTap(item));
            },
          ),
        ),
      ],
    );
  }
}

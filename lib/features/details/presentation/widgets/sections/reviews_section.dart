import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/review_card.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';

/// First review and a link to the rest.
class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.reviews, this.onSeeMore});

  final List<ReviewItem> reviews;

  /// Opens the full list. The link is hidden when null or when there is
  /// nothing more to show.
  final VoidCallback? onSeeMore;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const SizedBox.shrink();
    }
    final showLink = onSeeMore != null && reviews.length > 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Reviews'),
          const SizedBox(height: Space.lg),
          ReviewCard(review: reviews.first),
          if (showLink) ...[
            const SizedBox(height: Space.sm),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: onSeeMore,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'See more reviews',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.colors.primaryDefault,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/details/review_card.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';

/// Every review TMDB sent with the details, one card each.
class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key, required this.reviews});

  final List<ReviewItem> reviews;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.surfacePrimary,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        child: ListView.separated(
          itemCount: reviews.length + 1,
          separatorBuilder: (_, index) =>
              SizedBox(height: index == 0 ? Space.sm : Space.lg),
          itemBuilder: (context, index) => index == 0
              ? const SeeAllTopBar(title: 'Reviews', showResetButton: false)
              : ReviewCard(review: reviews[index - 1]),
        ),
      ),
    ),
  );
}

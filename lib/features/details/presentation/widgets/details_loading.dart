import 'package:flutter/material.dart';
import 'package:movify/config/animations/widgets/shimmer_loading.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/placeholder_block.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_title_block.dart';
import 'package:movify/shared/presentation/widgets/screen_gutter.dart';

/// Title from the navigation data plus grey blocks where the sections go.
class DetailsSkeletonLoading extends StatelessWidget {
  const DetailsSkeletonLoading({super.key, required this.data});

  final DetailsNavigationData data;

  @override
  Widget build(BuildContext context) {
    final (title, date, rating) = switch (data) {
      MovieNavData(:final title, :final date, :final rating) => (
        title,
        date,
        rating,
      ),
      SeriesNavData(:final title, :final date, :final rating) => (
        title,
        date,
        rating,
      ),
      _ => ('', null, null),
    };
    final year = date != null && date.length >= 4 ? date.substring(0, 4) : null;

    return ScreenGutter(
      child: Column(
        children: [
          DetailsTitleBlock(
            title: title,
            meta: [if (year != null) year],
            rating: rating != null && rating > 0 ? rating : null,
          ),
          const SizedBox(height: Space.x2xl),
          const ShimmerLoading(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChipsPlaceholder(),
                SizedBox(height: Space.x2xl),
                PlaceholderBlock(width: 140, height: 24),
                SizedBox(height: Space.sm),
                PlaceholderBlock(width: double.infinity, height: 96),
                SizedBox(height: Space.x2xl),
                PlaceholderBlock(width: 160, height: 24),
                SizedBox(height: Space.lg),
                _CastPlaceholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipsPlaceholder extends StatelessWidget {
  const _ChipsPlaceholder();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      PlaceholderBlock(width: 96, height: 40),
      SizedBox(width: Space.sm),
      PlaceholderBlock(width: 96, height: 40),
      SizedBox(width: Space.sm),
      PlaceholderBlock(width: 96, height: 40),
    ],
  );
}

class _CastPlaceholder extends StatelessWidget {
  const _CastPlaceholder();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      PlaceholderBlock(width: 80, height: 80),
      SizedBox(width: Space.md),
      PlaceholderBlock(width: 80, height: 80),
      SizedBox(width: Space.md),
      PlaceholderBlock(width: 80, height: 80),
      SizedBox(width: Space.md),
      PlaceholderBlock(width: 80, height: 80),
    ],
  );
}

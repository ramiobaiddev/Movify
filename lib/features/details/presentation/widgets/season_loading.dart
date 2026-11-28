import 'package:flutter/material.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/centered_status.dart';
import 'package:movify/features/details/presentation/widgets/sections/details_title_block.dart';
import 'package:movify/shared/presentation/widgets/screen_gutter.dart';

/// Season name from the navigation data plus a spinner while loading.
class SeasonLoading extends StatelessWidget {
  const SeasonLoading({super.key, required this.data});

  final SeasonNavData data;

  @override
  Widget build(BuildContext context) {
    final rating = data.rating;

    return Column(
      children: [
        ScreenGutter(
          child: DetailsTitleBlock(
            title: data.seasonName ?? 'Season ${data.seasonNumber}',
            meta: const [],
            rating: rating != null && rating > 0 ? rating : null,
          ),
        ),
        const CenteredStatus(),
      ],
    );
  }
}

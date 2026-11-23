import 'package:flutter/material.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_poster_row.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// In theater now, Upcoming movies, On the air, Airing today: one real TMDB
/// endpoint, no chip.
class HomeFixedRow extends StatelessWidget {
  const HomeFixedRow({
    super.key,
    required this.title,
    required this.kind,
    required this.endPoint,
    required this.fetchers,
    required this.onItemTap,
    required this.onSeeAll,
  });

  final String title;
  final ContentType kind;
  final String endPoint;
  final FeedFetchers fetchers;
  final ValueChanged<CardDisplayModel> onItemTap;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) => HomePosterRow(
    title: title,
    queryKey: endPoint,
    fetcher: fetchers.fixed(kind, endPoint),
    onItemTap: onItemTap,
    onSeeAll: onSeeAll,
  );
}

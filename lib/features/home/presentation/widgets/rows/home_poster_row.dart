import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/widgets/paged_horizontal_list.dart';
import 'package:movify/features/home/presentation/widgets/rows/home_row_header.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_skeleton.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/keep_alive_wrapper.dart';
import 'package:movify/shared/presentation/widgets/media_poster_card.dart';

/// One home row: header + horizontal list of poster cards.
///
/// The row owns a [PagedCubit] built from [fetcher]. To change what it shows
/// (e.g. Movies -> Series), pass a different [queryKey]; the row then builds a
/// fresh cubit and drops the old one.
class HomePosterRow extends StatelessWidget {
  const HomePosterRow({
    super.key,
    required this.title,
    required this.fetcher,
    required this.queryKey,
    required this.onItemTap,
    this.onSeeAll,
    this.kindLabel,
    this.onKindTap,
  });

  final String title;
  final PageFetcher<CardDisplayModel> fetcher;
  final Object queryKey;
  final ValueChanged<CardDisplayModel> onItemTap;
  final VoidCallback? onSeeAll;
  final String? kindLabel;
  final VoidCallback? onKindTap;

  @override
  Widget build(BuildContext context) => KeepAliveWrapper(
    child: BlocProvider<PagedCubit<CardDisplayModel>>(
      key: ValueKey(queryKey),
      create: (_) => PagedCubit<CardDisplayModel>(fetcher)..load(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeRowHeader(
            title: title,
            kindLabel: kindLabel,
            onKindTap: onKindTap,
            onSeeAll: onSeeAll,
          ),
          const SizedBox(height: Space.sm),
          PagedHorizontalList<CardDisplayModel>(
            height: PosterRowMetrics.height(context),
            loadingBuilder: (_) => const PosterRowSkeleton(),
            itemBuilder: (context, item, _) =>
                MediaPosterCard(item: item, onTap: () => onItemTap(item)),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/widgets/paged_horizontal_list.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_skeleton.dart';
import 'package:movify/shared/presentation/extensions/open_media_details.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/common/section_title.dart';
import 'package:movify/shared/presentation/widgets/layout/keep_alive_wrapper.dart';
import 'package:movify/shared/presentation/widgets/cards/media_poster_card.dart';

/// "Recommended" / "Similar" row of a details screen (Figma: plain title, 95 px
/// posters, no See all). Collapses when there is nothing to show.
///
/// Pass a different [queryKey] (e.g. the title id) to start over with a new
/// [fetcher]; the row then builds a fresh cubit.
class RelatedRow extends StatelessWidget {
  const RelatedRow({
    super.key,
    required this.title,
    required this.fetcher,
    required this.queryKey,
    this.onTitleTap,
  });

  static const double posterWidth = 95;

  final String title;
  final PageFetcher<CardDisplayModel> fetcher;
  final Object queryKey;

  /// Opens the full list. Adds a chevron to the title.
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) => KeepAliveWrapper(
    child: BlocProvider<PagedCubit<CardDisplayModel>>(
      key: ValueKey(queryKey),
      create: (_) => PagedCubit<CardDisplayModel>(fetcher)..load(),
      child: _RelatedRowBody(title: title, onTitleTap: onTitleTap),
    ),
  );
}

class _RelatedRowBody extends StatelessWidget {
  const _RelatedRowBody({required this.title, required this.onTitleTap});

  final String title;
  final VoidCallback? onTitleTap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        child: SectionTitle(title, onTap: onTitleTap),
      ),
      const SizedBox(height: Space.lg),
      PagedHorizontalList<CardDisplayModel>(
        height: PosterRowMetrics.height(
          context,
          width: RelatedRow.posterWidth,
        ),
        loadingBuilder: (_) => const PosterRowSkeleton(
          posterWidth: RelatedRow.posterWidth,
        ),
        itemBuilder: (context, item, _) => MediaPosterCard(
          item: item,
          width: RelatedRow.posterWidth,
          onTap: () => context.openMediaDetails(item),
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/widgets/sliver_paged_grid.dart';
import 'package:movify/features/details/presentation/feeds/related_fetchers.dart';
import 'package:movify/features/details/presentation/models/related_args.dart';
import 'package:movify/features/see_all/presentation/widgets/grid/see_all_grid_skeleton.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/presentation/extensions/open_media_details.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';
import 'package:movify/shared/presentation/widgets/cards/media_poster_card.dart';
import 'package:movify/shared/presentation/widgets/layout/poster_grid_layout.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Full Recommended or Similar list of a title, as a paged poster grid.
class RelatedView extends StatelessWidget {
  const RelatedView({super.key, required this.args});

  final RelatedArgs args;

  @override
  Widget build(BuildContext context) {
    final fetchers = getIt<RelatedFetchers>();
    final fetcher = switch (args.list) {
      RelatedList.recommended => fetchers.recommended(args.kind, args.id),
      RelatedList.similar => fetchers.similar(args.kind, args.id),
    };
    final layout = PosterGridLayout.of(context);

    return BlocProvider<PagedCubit<CardDisplayModel>>(
      create: (_) => PagedCubit<CardDisplayModel>(fetcher)..load(),
      child: Scaffold(
        backgroundColor: context.colors.surfacePrimary,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ScreenGutter(
                  child: SeeAllTopBar(
                    title: args.list.title,
                    showResetButton: false,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  Space.lg,
                  Space.lg,
                  Space.lg,
                  MediaQuery.paddingOf(context).bottom + Space.x3xl,
                ),
                sliver: SliverPagedGrid<CardDisplayModel>(
                  gridDelegate: layout.delegate,
                  loadingBuilder: (context) => SeeAllGridSkeleton(
                    columns: layout.columns,
                    childAspectRatio: layout.childAspectRatio,
                  ),
                  itemBuilder: (context, item, _) => MediaPosterCard(
                    item: item,
                    width: null,
                    onTap: () => context.openMediaDetails(item),
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

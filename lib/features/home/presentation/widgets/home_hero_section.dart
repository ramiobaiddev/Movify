import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/paged_cubit.dart';
import 'package:movify/core/paging/paged_state.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/home/presentation/widgets/home_hero_skeleton.dart';
import 'package:movify/features/home/presentation/widgets/stacked_cards_carousel/stacked_cards_carousel.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Wraps the 3D Hero Carousel with a [PagedCubit] driven by [FeedFetchers.trending].
class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key, required this.fetchers});

  final FeedFetchers fetchers;

  @override
  Widget build(
    BuildContext context,
  ) => BlocProvider<PagedCubit<CardDisplayModel>>(
    create: (_) => PagedCubit<CardDisplayModel>(fetchers.trending())..load(),
    child:
        BlocBuilder<PagedCubit<CardDisplayModel>, PagedState<CardDisplayModel>>(
          builder: (context, state) {
            if (state.isFirstLoading) {
              return const HomeHeroSkeleton();
            }

            if (state.isFirstError) {
              return _HeroErrorView(
                onRetry: () =>
                    context.read<PagedCubit<CardDisplayModel>>().load(),
              );
            }

            if (state.items.isEmpty) {
              return const SizedBox.shrink();
            }

            return StackedCardsCarousel(cardModel: state.items);
          },
        ),
  );
}

class _HeroErrorView extends StatelessWidget {
  const _HeroErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Space.xl,
        horizontal: Space.lg,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, color: colors.iconSecondary, size: 36),
            const SizedBox(height: Space.sm),
            Text(
              'Failed to load trending titles',
              style: textTheme.bodyMedium?.copyWith(color: colors.textContrast),
            ),
            const SizedBox(height: Space.sm),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: textTheme.labelLarge?.copyWith(
                  color: colors.primaryDefault,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

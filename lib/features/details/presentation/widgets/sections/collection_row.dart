import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/details/presentation/cubits/fetch_collection_cubit/fetch_collection_cubit.dart';
import 'package:movify/features/details/presentation/cubits/fetch_collection_cubit/fetch_collection_states.dart';
import 'package:movify/features/details/presentation/extensions/part_extension.dart';
import 'package:movify/features/details/presentation/widgets/sections/section_title.dart';
import 'package:movify/features/home/presentation/widgets/rows/poster_row_metrics.dart';
import 'package:movify/shared/presentation/extensions/open_media_details.dart';
import 'package:movify/shared/presentation/widgets/keep_alive_wrapper.dart';
import 'package:movify/shared/presentation/widgets/media_poster_card.dart';

/// Other films of the same collection (movies only). Collapses when the movie
/// is the only one, or when the collection can't be loaded.
class CollectionRow extends StatelessWidget {
  const CollectionRow({
    super.key,
    required this.collectionId,
    required this.movieId,
  });

  static const double posterWidth = 95;

  final int collectionId;
  final int movieId;

  @override
  Widget build(BuildContext context) => KeepAliveWrapper(
    child: BlocProvider<FetchCollectionCubit>(
      create: (_) =>
          getIt<FetchCollectionCubit>()..fetchCollection(collectionId, movieId),
      child: BlocBuilder<FetchCollectionCubit, FetchCollectionState>(
        builder: (context, state) {
          if (state is! FetchCollectionSuccess ||
              state.collection.parts.isEmpty) {
            return const SizedBox.shrink();
          }
          final parts = state.collection.parts;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Space.lg),
                child: SectionTitle('Collection'),
              ),
              const SizedBox(height: Space.lg),
              SizedBox(
                height: PosterRowMetrics.height(context, width: posterWidth),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: Space.lg),
                  itemCount: parts.length,
                  separatorBuilder: (_, _) => const SizedBox(width: Space.md),
                  itemBuilder: (context, index) {
                    final item = parts[index].toCardDisplay();
                    return MediaPosterCard(
                      item: item,
                      width: posterWidth,
                      onTap: () => context.openMediaDetails(item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

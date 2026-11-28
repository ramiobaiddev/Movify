import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/ads/cubits/interstitial_ad_cubit.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_cubit.dart';
import 'package:movify/features/details/presentation/cubits/details_cubit/details_state.dart';
import 'package:movify/features/details/presentation/mappers/movie_content_mapper.dart';
import 'package:movify/features/details/presentation/mappers/series_content_mapper.dart';
import 'package:movify/features/details/presentation/widgets/details_body.dart';
import 'package:movify/features/details/presentation/widgets/content_error.dart';
import 'package:movify/features/details/presentation/widgets/details_header.dart';
import 'package:movify/features/details/presentation/widgets/details_loading.dart';
import 'package:movify/features/details/presentation/widgets/trailer_player.dart';

/// Movie or series details (Figma "movie details" / "Series details").
///
/// Needs a [DetailsCubit] above it. The header and title come from [data] so
/// they show immediately; everything below fills in when the cubit loads.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.data});

  final DetailsNavigationData data;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Interstitial on enter, after the route transition.
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        context.read<InterstitialAdCubit>().showAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<InterstitialAdCubit>().showAd();
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.surfacePrimary,
        body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            final content = switch (state) {
              DetailsMovieLoaded(:final movie) => movie.toContent(),
              DetailsSeriesLoaded(:final series) => series.toContent(),
              _ => null,
            };
            final trailer = content?.trailer;

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DetailsHeader(
                  data: data,
                  onPlayTrailer: trailer == null
                      ? null
                      : () => showTrailerPlayer(context, trailer),
                ),
                const SizedBox(height: Space.md),
                if (content != null)
                  DetailsBody(content: content)
                else if (state is DetailsError)
                  ContentError(
                    message: state.message,
                    onRetry: () => context.read<DetailsCubit>().load(
                      data.contentType,
                      data.tmdbId,
                    ),
                  )
                else
                  DetailsSkeletonLoading(data: data),
              ],
            );
          },
        ),
      ),
    );
  }
}

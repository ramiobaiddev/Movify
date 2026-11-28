import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/features/home/presentation/feeds/feed_fetchers.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_cubit.dart';
import 'package:movify/features/see_all/presentation/cubit/see_all_state.dart';
import 'package:movify/features/see_all/presentation/models/see_all_args.dart';
import 'package:movify/features/see_all/presentation/views/see_all_view_body.dart';

/// Screen container for See All and filtering.
class SeeAllView extends StatelessWidget {
  const SeeAllView({super.key, required this.args, this.fetchers});

  final SeeAllArgs args;
  final FeedFetchers? fetchers;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocProvider<SeeAllCubit>(
      create: (context) =>
          SeeAllCubit(args: args, fetchers: fetchers ?? getIt<FeedFetchers>()),
      child: BlocListener<SeeAllCubit, SeeAllState>(
        listenWhen: (previous, current) =>
            current.droppedGenreIds.isNotEmpty &&
            current.droppedGenreIds != previous.droppedGenreIds,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Some selected genres were not available for this media type.',
              ),
              backgroundColor: colors.surfaceCommentCard,
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<SeeAllCubit>().clearNotice();
        },
        child: Scaffold(
          backgroundColor: colors.surfacePrimary,
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Space.lg),
              child: SeeAllViewBody(args: args),
            ),
          ),
        ),
      ),
    );
  }
}

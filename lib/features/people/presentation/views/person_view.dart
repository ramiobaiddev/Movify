import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/config/animations/widgets/shimmer_loading.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/presentation/cubits/person_details_cubit.dart';
import 'package:movify/features/people/presentation/cubits/person_details_state.dart';
import 'package:movify/features/people/presentation/models/person_credits_args.dart';
import 'package:movify/features/people/presentation/widgets/credits_row.dart';
import 'package:movify/features/people/presentation/widgets/person_header.dart';
import 'package:movify/shared/domain/entites/media_item.dart';
import 'package:movify/shared/presentation/extensions/open_media_details.dart';
import 'package:movify/shared/presentation/models/card_display_mappers.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Actor details: photo, facts, biography and their movies and series.
///
/// Expects a [PersonDetailsCubit] above it (the route provides one).
class PersonView extends StatelessWidget {
  const PersonView({super.key, required this.personId});

  final int personId;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.surfacePrimary,
    body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
      builder: (context, state) => switch (state) {
        PersonDetailsLoading() => const _PersonSkeleton(),
        PersonDetailsError(:final message) => SafeArea(
          child: PagedErrorView(
            message: message,
            onRetry: () => context.read<PersonDetailsCubit>().load(personId),
          ),
        ),
        PersonDetailsLoaded(:final details) => _PersonContent(details: details),
      },
    ),
  );
}

class _PersonContent extends StatelessWidget {
  const _PersonContent({required this.details});

  final PersonDetails details;

  List<CardDisplayModel> _cards(List<MediaItem> items) =>
      items.map((m) => m.toCardDisplay()).toList(growable: false);

  void _seeAll(BuildContext context, String title, List<CardDisplayModel> list) {
    context.pushNamed(
      RouteName.personCredits,
      extra: PersonCreditsArgs(title: title, items: list),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movies = _cards(details.movies);
    final series = _cards(details.series);

    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        PersonHeader(details: details),
        const SizedBox(height: Space.xl),
        CreditsRow(
          title: 'Movies',
          items: movies,
          onItemTap: context.openMediaDetails,
          onSeeAll: () => _seeAll(context, 'Movies', movies),
        ),
        const SizedBox(height: Space.xl),
        CreditsRow(
          title: 'Series',
          items: series,
          onItemTap: context.openMediaDetails,
          onSeeAll: () => _seeAll(context, 'Series', series),
        ),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + Space.xl),
      ],
    );
  }
}

class _PersonSkeleton extends StatelessWidget {
  const _PersonSkeleton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Widget box(double w, double h, {double radius = Radii.md}) => DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceGenre,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(width: w, height: h),
    );

    return SafeArea(
      child: ShimmerLoading(
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: box(44, 44, radius: 22),
              ),
              const SizedBox(height: Space.lg),
              box(170, 238, radius: Radii.xl),
              const SizedBox(height: Space.lg),
              box(180, 24),
              const SizedBox(height: Space.md),
              box(120, 14),
              const SizedBox(height: Space.xl),
              box(double.infinity, 14),
              const SizedBox(height: Space.sm),
              box(double.infinity, 14),
              const SizedBox(height: Space.sm),
              box(double.infinity, 14),
            ],
          ),
        ),
      ),
    );
  }
}

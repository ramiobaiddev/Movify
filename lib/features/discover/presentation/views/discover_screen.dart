import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/discover/presentation/models/discover_collection.dart';
import 'package:movify/features/discover/presentation/models/discover_genre.dart';
import 'package:movify/features/discover/presentation/models/discover_links.dart';
import 'package:movify/features/discover/presentation/widgets/collections_section.dart';
import 'package:movify/features/discover/presentation/widgets/discover_chips_section.dart';
import 'package:movify/features/discover/presentation/widgets/discover_search_field.dart';
import 'package:movify/features/discover/presentation/widgets/kind_tabs.dart';
import 'package:movify/features/discover/presentation/widgets/mood_section.dart';

/// Discover tab: every tile opens See all with a starting query. The only
/// state is the Movies / Series choice, so it lives here and is not persisted.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  /// Start years of the decade chips.
  static const decades = [2020, 2010, 2000, 1990, 1980];

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  ContentType _kind = ContentType.movies;

  @override
  Widget build(BuildContext context) {
    const genres = DiscoverGenre.all;

    return Scaffold(
      body: SafeArea(
        bottom: false,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: ListView(
            children: [
              const SizedBox(height: Space.xl),
              Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: Space.lg),
              DiscoverSearchField(
                onTap: () => context.pushNamed(RouteName.search),
              ),
              const SizedBox(height: Space.x2xl),
              KindTabs(
                kind: _kind,
                onChanged: (kind) => setState(() => _kind = kind),
              ),
              const SizedBox(height: Space.x2xl),
              DiscoverChipsSection(
                title: 'Genres',
                onTitleTap: () =>
                    context.pushNamed(RouteName.genres, extra: _kind),
                labels: [for (final g in genres) g.name],
                onTap: (i) => context.openGenre(
                  _kind,
                  genres[i].idFor(_kind),
                  genres[i].name,
                ),
              ),
              const SizedBox(height: Space.x2xl),
              CollectionsSection(
                kind: _kind,
                collections: DiscoverCollection.all,
                onTap: (c) => context.openCollection(_kind, c),
              ),
              const SizedBox(height: Space.x2xl),
              MoodSection(onTap: (mood) => context.openMood(_kind, mood)),
              const SizedBox(height: Space.x2xl),
              DiscoverChipsSection(
                title: 'Travel through time',
                labels: [for (final d in DiscoverScreen.decades) '${d}s'],
                onTap: (i) =>
                    context.openDecade(_kind, DiscoverScreen.decades[i]),
              ),
              const SizedBox(height: Space.lg),
            ],
          ),
        ),
      ),
    );
  }
}

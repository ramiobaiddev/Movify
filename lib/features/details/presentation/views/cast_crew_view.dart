import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_links.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/see_all/presentation/widgets/top_bar/see_all_top_bar.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/cards/person_list_tile.dart';
import 'package:movify/shared/presentation/widgets/layout/screen_gutter.dart';

/// Everyone listed for a title, one row each. Uses the cast the details
/// screen already loaded, so nothing is fetched here.
class CastCrewView extends StatelessWidget {
  const CastCrewView({super.key, required this.cast});

  final List<CastMember> cast;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.surfacePrimary,
    body: SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: ScreenGutter(
              child: SeeAllTopBar(title: 'Cast & crew', showResetButton: false),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              Space.lg,
              Space.sm,
              Space.lg,
              MediaQuery.paddingOf(context).bottom + Space.x3xl,
            ),
            sliver: SliverList.builder(
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final person = cast[index];

                return PersonListTile(
                  person: PersonItem(
                    id: person.id,
                    name: person.name,
                    profilePath: person.profilePath,
                  ),
                  onTap: () => context.openPerson(person.id),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

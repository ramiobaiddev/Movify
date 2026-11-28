import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/shared/presentation/widgets/section_title.dart';
import 'package:movify/shared/presentation/widgets/person_avatar_card.dart';

/// "Cast & crew": round photos with name and character.
class CastRow extends StatelessWidget {
  const CastRow({
    super.key,
    required this.cast,
    required this.onTap,
    this.title = 'Cast & crew',
    this.dense = false,
  });

  static const double _avatarSize = 80;

  final List<CastMember> cast;
  final ValueChanged<CastMember> onTap;
  final String title;

  /// Smaller 18/24 title and tighter gaps (episode screen).
  final bool dense;

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: dense
              ? Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.colors.textPrimary,
                  ),
                )
              : SectionTitle(title),
        ),
        const SizedBox(height: Space.lg),
        SizedBox(
          height: _avatarSize + 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            itemCount: cast.length,
            separatorBuilder: (_, _) => SizedBox(width: dense ? Space.sm : Space.md),
            itemBuilder: (context, index) {
              final person = cast[index];
              return PersonAvatarCard(
                name: person.name,
                profilePath: person.profilePath,
                subtitle: person.character,
                avatarSize: _avatarSize,
                onTap: () => onTap(person),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/domain/entites/person_item.dart';
import 'package:movify/shared/presentation/widgets/person_avatar.dart';

/// One person per row.
///
/// [detailed] (search results) adds the department and a chevron. Without it
/// (Popular actors) the row is just photo and name, with a divider underneath.
class PersonListTile extends StatelessWidget {
  const PersonListTile({
    super.key,
    required this.person,
    required this.onTap,
    this.detailed = false,
  });

  final PersonItem person;
  final VoidCallback onTap;
  final bool detailed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: detailed
              ? null
              : Border(bottom: BorderSide(color: colors.surfaceDivider)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Space.sm),
          child: Row(
            children: [
              PersonAvatar(profilePath: person.profilePath, size: 48),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      person.name,
                      style: textTheme.titleSmall?.copyWith(
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (detailed) ...[
                      const SizedBox(height: Space.xsm),
                      Text(
                        person.knownForDepartment ?? 'Acting',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.textContrast,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (detailed)
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.iconSecondary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

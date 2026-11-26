import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/shared/domain/entites/person_item.dart';

/// Person row tile showing circular avatar, name, and known-for department.
class SearchPersonTile extends StatelessWidget {
  const SearchPersonTile({super.key, required this.person, this.onTap});

  final PersonItem person;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    final hasProfile = person.profilePath?.isNotEmpty ?? false;
    final imageUrl = hasProfile
        ? tmdbImageSize(TmdbImageSize.w185, person.profilePath ?? '')
        : null;

    final department = person.knownForDepartment ?? 'Acting';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.lg,
            vertical: Space.sm,
          ),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                  width: 52,
                  height: 52,
                  color: colors.surfaceGenre,
                  child: hasProfile
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          errorWidget: (_, _, _) => Icon(
                            Icons.person_rounded,
                            color: colors.iconSecondary,
                            size: 26,
                          ),
                        )
                      : Icon(
                          Icons.person_rounded,
                          color: colors.iconSecondary,
                          size: 26,
                        ),
                ),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      person.name,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Space.xsm),
                    Text(
                      department,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
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

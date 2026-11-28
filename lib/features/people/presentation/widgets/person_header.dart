import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/shared/presentation/widgets/common/expandable_text.dart';
import 'package:movify/shared/presentation/widgets/headers/header_circle_action.dart';
import 'package:movify/shared/presentation/widgets/headers/photo_header.dart';
import 'package:share_plus/share_plus.dart';

/// Actor header (Figma "Actor View"): the shared photo header, then name,
/// facts and biography.
class PersonHeader extends StatelessWidget {
  const PersonHeader({super.key, required this.details, DateTime? today})
    : _today = today;

  final PersonDetails details;
  final DateTime? _today;

  String? get _birthLine {
    final born = details.birthday;
    if (born == null) {
      return null;
    }
    final age = details.ageAt(_today ?? DateTime.now());
    final date = DateFormat.yMMMd().format(born);
    return age == null ? date : '$date ($age)';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final path = details.profilePath;
    final hasPhoto = path != null && path.isNotEmpty;
    final photoUrl = hasPhoto ? tmdbImageSize(TmdbImageSize.h632, path) : null;
    final birthLine = _birthLine;
    final secondary = textTheme.labelMedium?.copyWith(
      color: colors.textContrast,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhotoHeader(
          backdropUrl: photoUrl,
          portraitUrl: photoUrl,
          portraitFallback: Icon(
            Icons.person_rounded,
            size: 64,
            color: colors.iconSecondary,
          ),
          onBack: () => Navigator.of(context).maybePop(),
          actions: [
            HeaderCircleAction(
              icon: Icons.ios_share_rounded,
              label: 'Share',
              onTap: () => SharePlus.instance.share(
                ShareParams(
                  text: 'https://www.themoviedb.org/person/${details.id}',
                ),
              ),
            ),
            HeaderCircleAction(
              icon: Icons.home_rounded,
              label: 'Home',
              onTap: () => context.goNamed(RouteName.home),
            ),
          ],
        ),
        const SizedBox(height: Space.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Center(
            child: Column(
              children: [
                Text(
                  details.name,
                  style: textTheme.headlineSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Space.xsm),
                Text(
                  '${details.knownForDepartment} Â· ${details.creditCount} credits',
                  style: secondary,
                ),
                if (birthLine != null) ...[
                  const SizedBox(height: Space.xsm),
                  Text(birthLine, style: secondary),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.x3xl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (details.placeOfBirth.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 24,
                      color: colors.iconSecondary,
                    ),
                    const SizedBox(width: Space.sm),
                    Expanded(
                      child: Text(
                        details.placeOfBirth,
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Space.md),
              ],
              if (details.biography.isNotEmpty)
                ExpandableText(text: details.biography),
            ],
          ),
        ),
      ],
    );
  }
}

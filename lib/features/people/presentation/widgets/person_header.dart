import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/network/api/services/tmdb/tmdb_image_size.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/people/domain/entities/person_details.dart';
import 'package:movify/features/people/presentation/widgets/expandable_biography.dart';
import 'package:share_plus/share_plus.dart';

/// Actor header (Figma "Actor View"): full-width photo that fades to the
/// screen colour, a portrait overlapping the fade, name, facts and biography.
///
/// The photo is not blurred in the design; the fade is a plain gradient, which
/// costs nothing compared to a real layer blur.
class PersonHeader extends StatelessWidget {
  const PersonHeader({super.key, required this.details, DateTime? today})
    : _today = today;

  static const double _backdropHeight = 420;
  static const double _fadeHeight = 90;
  static const double _portraitTop = 251;
  static const double _portraitWidth = 148;
  static const double _portraitHeight = 223;
  static const double _stackHeight = _portraitTop + _portraitHeight;

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
      color: colors.textSecondary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _stackHeight,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              if (photoUrl != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: _backdropHeight,
                  child: CachedNetworkImage(
                    imageUrl: photoUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                top: _backdropHeight - _fadeHeight,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.surfacePrimary.withValues(alpha: 0),
                        colors.surfacePrimary,
                      ],
                      stops: const [
                        0,
                        _fadeHeight / (_stackHeight - _backdropHeight + _fadeHeight),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _portraitTop,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.lg),
                  child: SizedBox(
                    width: _portraitWidth,
                    height: _portraitHeight,
                    child: ColoredBox(
                      color: colors.surfaceGenre,
                      child: photoUrl == null
                          ? Icon(
                              Icons.person_rounded,
                              size: 64,
                              color: colors.iconSecondary,
                            )
                          : CachedNetworkImage(
                              imageUrl: photoUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.paddingOf(context).top + Space.sm,
                left: Space.lg,
                right: Space.lg,
                child: Row(
                  children: [
                    _CircleAction(
                      icon: Icons.arrow_back_ios_new_rounded,
                      label: 'Back',
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                    const Spacer(),
                    _CircleAction(
                      icon: Icons.ios_share_rounded,
                      label: 'Share',
                      onTap: () => SharePlus.instance.share(
                        ShareParams(
                          text:
                              'https://www.themoviedb.org/person/${details.id}',
                        ),
                      ),
                    ),
                    const SizedBox(width: Space.sm),
                    _CircleAction(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      onTap: () => context.goNamed(RouteName.home),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                  '${details.knownForDepartment} · ${details.creditCount} credits',
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
                ExpandableBiography(text: details.biography),
            ],
          ),
        ),
      ],
    );
  }
}

/// 36 px dark circle button on the photo (Figma "icon container").
class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceBlurBackground,
            borderRadius: BorderRadius.circular(Radii.lg),
          ),
          child: SizedBox.square(
            dimension: 36,
            child: Icon(icon, size: 18, color: colors.iconPrimary),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui' show ImageFilter;

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

/// Blurred photo backdrop, portrait, name, facts and biography.
class PersonHeader extends StatelessWidget {
  const PersonHeader({super.key, required this.details, DateTime? today})
    : _today = today;

  static const double _backdropHeight = 300;
  static const double _portraitWidth = 170;

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
    final birthLine = _birthLine;
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return Column(
      children: [
        SizedBox(
          height: _backdropHeight,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              if (path != null && path.isNotEmpty)
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: CachedNetworkImage(
                      imageUrl: tmdbImageSize(TmdbImageSize.w185, path),
                      fit: BoxFit.cover,
                      memCacheWidth: MediaQuery.widthOf(context) * dpr ~/ 4,
                    ),
                  ),
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.surfacePrimary.withValues(alpha: 0.4),
                        colors.surfacePrimary,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Space.lg,
                    vertical: Space.md,
                  ),
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
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.xl),
                  child: SizedBox(
                    width: _portraitWidth,
                    height: _portraitWidth * 1.4,
                    child: ColoredBox(
                      color: colors.surfaceGenre,
                      child: path == null || path.isEmpty
                          ? Icon(
                              Icons.person_rounded,
                              size: 64,
                              color: colors.iconSecondary,
                            )
                          : CachedNetworkImage(
                              imageUrl: tmdbImageSize(TmdbImageSize.w500, path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Space.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      details.name,
                      style: textTheme.headlineMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Space.xsm),
                    Text(
                      '${details.knownForDepartment} · ${details.creditCount} credits',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Space.lg),
              if (birthLine != null)
                _FactRow(icon: Icons.cake_outlined, text: birthLine),
              if (details.placeOfBirth.isNotEmpty)
                _FactRow(
                  icon: Icons.place_outlined,
                  text: details.placeOfBirth,
                ),
              if (details.biography.isNotEmpty) ...[
                const SizedBox(height: Space.md),
                Text('Biography', style: textTheme.titleMedium),
                const SizedBox(height: Space.sm),
                ExpandableBiography(text: details.biography),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colors.iconSecondary),
          const SizedBox(width: Space.sm),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceGenre,
            shape: BoxShape.circle,
          ),
          child: SizedBox.square(
            dimension: 44,
            child: Icon(icon, size: 20, color: colors.iconPrimary),
          ),
        ),
      ),
    );
  }
}

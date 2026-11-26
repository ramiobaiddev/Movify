import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';

class FavoriteEmptyState extends StatelessWidget {
  const FavoriteEmptyState({super.key, required this.kind});

  final ContentType kind;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final browseLabel = kind == ContentType.movies
        ? 'Browse movies'
        : 'Browse series';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.x2xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.popcornIcon, width: 92, height: 92),
            const SizedBox(height: Space.lg),
            Text(
              'Your collection starts here',
              style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.sm),
            Text(
              'Save the movies and series you love, and find them all in one '
              'place.',
              style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Space.x2xl),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteName.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.buttonPrimary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: Space.x3xl,
                  vertical: Space.md,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.lg),
                ),
              ),
              child: Text(
                browseLabel,
                style: textTheme.labelLarge?.copyWith(
                  color: colors.textOnImage,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// App identity header matching Figma node `573:4346`.
/// Displays 80x80 app icon, app name, and version number.
class AboutAppIdentity extends StatelessWidget {
  const AboutAppIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Radii.md),
          child: Image.asset(
            Assets.iconsMovify,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colors.surfaceProfileRow,
                borderRadius: BorderRadius.circular(Radii.md),
              ),
              child: Icon(
                Icons.movie_rounded,
                size: 40,
                color: colors.iconPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: Space.md),
        Text(
          'Movify',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: Space.xsm),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final version = snapshot.data?.version ?? '1.0.1';
            final build = snapshot.data?.buildNumber;
            final label = build != null && build.isNotEmpty
                ? 'Version $version ($build)'
                : 'Version $version';

            return Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colors.textContrast,
              ),
            );
          },
        ),
      ],
    );
  }
}

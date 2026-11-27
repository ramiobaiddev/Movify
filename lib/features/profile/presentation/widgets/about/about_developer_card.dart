import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movify/constant.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

/// Developer card matching Figma node `575:4352`.
/// Features portrait avatar, developer name, website link, and social profiles.
class AboutDeveloperCard extends StatelessWidget {
  const AboutDeveloperCard({super.key});

  Future<void> _launch(String urlString) async {
    final uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      AppLogger.error('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Space.lg,
        vertical: Space.lg,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceProfileRow,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(
          color: colors.surfaceDivider.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colors.surfaceDivider,
            backgroundImage: const AssetImage(Assets.imagesProfileAvatar),
          ),
          const SizedBox(height: Space.md),
          Text(
            'Developed by',
            style: textTheme.bodySmall?.copyWith(color: colors.textContrast),
          ),
          const SizedBox(height: Space.xsm),
          Text('Rami Obaid', style: textTheme.titleMedium),
          const SizedBox(height: Space.xsm),
          InkWell(
            onTap: () => _launch(Constants.developerWebsite),
            borderRadius: BorderRadius.circular(Radii.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Space.sm,
                vertical: Space.xsm,
              ),
              child: Text(
                'ramiobaid.com',
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.buttonPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: Space.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _launch(Constants.developerLinkedIn),
                icon: FaIcon(
                  FontAwesomeIcons.linkedin,
                  size: 24,
                  color: colors.iconPrimary,
                ),
                tooltip: 'LinkedIn',
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () => _launch(Constants.developerTwitter),
                icon: FaIcon(
                  FontAwesomeIcons.xTwitter,
                  size: 20,
                  color: colors.iconPrimary,
                ),
                tooltip: 'X (Twitter)',
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () => _launch(Constants.developerInstagram),
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  size: 20,
                  color: colors.iconPrimary,
                ),
                tooltip: 'Instagram',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

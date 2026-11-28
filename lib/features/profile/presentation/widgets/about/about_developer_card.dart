import 'package:flutter/material.dart';
import 'package:movify/constant.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/about/card_container_decorator.dart';
import 'package:movify/features/profile/presentation/widgets/about/social_media_row.dart';
import 'package:movify/shared/presentation/extensions/launcher_helper.dart';

/// Developer card matching Figma node `575:4352`.
/// Features portrait avatar, developer name, website link, and social profiles.
class AboutDeveloperCard extends StatelessWidget {
  const AboutDeveloperCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return CardContainerDecorator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: colors.surfaceDivider,
            backgroundImage: const AssetImage(Assets.imagesDeveloperAvatar),
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
            onTap: () => context.openUrl(Constants.developerWebsite),
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
          const SocialMediaRow(),
        ],
      ),
    );
  }
}

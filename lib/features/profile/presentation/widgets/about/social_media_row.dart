import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movify/constant.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/features/profile/presentation/widgets/about/social_icon_button.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) => const Row(
    spacing: Space.x4xl,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SocialIconButton(
        icon: FontAwesomeIcons.linkedin,
        url: Constants.developerLinkedIn,
        tooltip: 'LinkedIn',
      ),
      SizedBox(width: 40),
      SocialIconButton(
        icon: FontAwesomeIcons.xTwitter,
        url: Constants.developerTwitter,
        tooltip: 'X (Twitter)',
      ),
      SizedBox(width: 40),
      SocialIconButton(
        icon: FontAwesomeIcons.instagram,
        url: Constants.developerInstagram,
        tooltip: 'Instagram',
      ),
    ],
  );
}

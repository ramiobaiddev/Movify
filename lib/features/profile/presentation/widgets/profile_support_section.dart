import 'package:flutter/material.dart';
import 'package:movify/constant.dart';
import 'package:movify/core/ads/consent_manager.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/utils/show_snack_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Support and legal section containing rate, share, feedback, and privacy tiles.
class ProfileSupportSection extends StatelessWidget {
  const ProfileSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context)!;

    return ProfileSection(
      title: 'Support & legal',
      children: [
        ProfileSettingTile(
          icon: Icons.star_outline_rounded,
          title: 'Rate Movify',
          onTap: () {
            showSnackBar(
              context,
              text: 'Thank you for your rating!',
              color: colors.surfaceSuccess,
            );
          },
        ),
        ProfileSettingTile(
          icon: Icons.share_outlined,
          title: l10n.share,
          onTap: () {
            SharePlus.instance.share(ShareParams(text: Constants.appLinlk));
          },
        ),
        ProfileSettingTile(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'Send feedback',
          onTap: () async {
            final uri = Uri.parse('mailto:${Constants.supportEmail}');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
        ),
        ProfileSettingTile(
          icon: Icons.privacy_tip_outlined,
          title: l10n.about,
          onTap: () async {
            await ConsentManager.showPrivacyOptionsForm();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movify/constant.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/app_logger.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Legal section matching Figma node `572:4259`.
/// Reuses ProfileSection and ProfileSettingTile for Privacy Policy & Terms of Use.
class AboutLegalSection extends StatelessWidget {
  const AboutLegalSection({super.key});

  Future<void> _launch(String urlString) async {
    final uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      AppLogger.error('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return ProfileSection(
      title: 'LEGAL',
      children: [
        ProfileSettingTile(
          icon: Icons.privacy_tip_outlined,
          title: l10n?.privacyPolicy ?? 'Privacy policy',
          trailing: Icon(
            Icons.open_in_new_rounded,
            size: 20,
            color: colors.iconSecondary,
          ),
          onTap: () => _launch(Constants.privacyPolicyUrl),
        ),
        ProfileSettingTile(
          icon: Icons.description_outlined,
          title: l10n?.terms ?? 'Terms of use',
          trailing: Icon(
            Icons.open_in_new_rounded,
            size: 20,
            color: colors.iconSecondary,
          ),
          onTap: () => _launch(Constants.termsOfUseUrl),
        ),
      ],
    );
  }
}

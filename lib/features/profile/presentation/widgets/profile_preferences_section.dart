import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/profile_appearance_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_language_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';

/// Preferences section containing notifications, appearance, and language settings.
class ProfilePreferencesSection extends StatelessWidget {
  const ProfilePreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ProfileSection(
      title: 'Preferences',
      children: [
        ProfileSettingTile(
          icon: Icons.notifications,
          title: "Notifications",
          onTap: () {},
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: colors.iconSecondary,
          ),
        ),
        const ProfileAppearanceTile(),
        const ProfileLanguageTile(),
      ],
    );
  }
}

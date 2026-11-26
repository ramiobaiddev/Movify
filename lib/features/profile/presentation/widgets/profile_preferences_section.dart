import 'package:flutter/material.dart';
import 'package:movify/features/profile/presentation/widgets/profile_appearance_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_language_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_notification_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';

/// Preferences section containing notifications, appearance, and language settings.
class ProfilePreferencesSection extends StatelessWidget {
  const ProfilePreferencesSection({super.key});

  @override
  Widget build(BuildContext context) => const ProfileSection(
    title: 'Preferences',
    children: [
      ProfileNotificationTile(),
      ProfileAppearanceTile(),
      ProfileLanguageTile(),
    ],
  );
}

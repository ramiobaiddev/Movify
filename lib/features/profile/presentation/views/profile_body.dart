import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/profile_account_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_data_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_preferences_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_support_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_user_card.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Body of the Profile screen matching Figma node `413:3939`.
class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Space.md),
          Text(
            l10n.profile,
            style: textTheme.titleLarge?.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: Space.lg),
          const ProfileUserCard(),
          const SizedBox(height: Space.xl),
          const ProfilePreferencesSection(),
          const SizedBox(height: Space.xl),
          const ProfileDataSection(),
          const SizedBox(height: Space.xl),
          const ProfileSupportSection(),
          const SizedBox(height: Space.xl),
          const ProfileAccountSection(),
          const SizedBox(height: Space.x10xl),
        ],
      ),
    );
  }
}

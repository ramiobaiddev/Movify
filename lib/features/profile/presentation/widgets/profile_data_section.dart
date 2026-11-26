import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/profile/presentation/widgets/clear_viewing_history_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/utils/show_snack_bar.dart';

/// Your data section containing viewing history and search history settings.
class ProfileDataSection extends StatelessWidget {
  const ProfileDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context)!;

    return ProfileSection(
      title: 'Your data',
      children: [
        ProfileSettingTile(
          icon: Icons.history_rounded,
          title: 'Viewing history',
          onTap: () {
            ClearViewingHistorySheet.show(
              context,
              onConfirmClear: () {
                showSnackBar(
                  context,
                  text: 'Viewing history cleared',
                  color: colors.surfaceSuccess,
                );
              },
            );
          },
        ),
        ProfileSettingTile(
          icon: Icons.history,
          title: l10n.searchHistory,
          onTap: () {
            context.pushNamed(RouteName.search);
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/theme/cubit/theme_cubit.dart';
import 'package:movify/core/theme/cubit/theme_state.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_theme_sheet.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Setting tile that displays current theme mode and opens appearance sheet.
class ProfileAppearanceTile extends StatelessWidget {
  const ProfileAppearanceTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final themeLabel = switch (themeState.mode) {
          ThemeMode.dark => 'Dark',
          ThemeMode.light => 'Light',
          ThemeMode.system => 'System default',
        };

        return ProfileSettingTile(
          icon: Icons.palette_outlined,
          title: l10n.theme,
          value: themeLabel,
          onTap: () => ProfileThemeSheet.show(context),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/language/presentation/cubits/language_cubit.dart';
import 'package:movify/core/language/presentation/cubits/language_state.dart';
import 'package:movify/features/profile/presentation/widgets/profile_language_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Setting tile that displays current language and opens language selector sheet.
class ProfileLanguageTile extends StatelessWidget {
  const ProfileLanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        final langLabel = switch (languageState.locale.languageCode) {
          'ar' => 'العربية',
          'tr' => 'Türkçe',
          'es' => 'Español',
          'fr' => 'Français',
          'de' => 'Deutsch',
          _ => 'English',
        };

        return ProfileSettingTile(
          icon: Icons.language_rounded,
          title: l10n.language,
          value: langLabel,
          onTap: () => ProfileLanguageSheet.show(context),
        );
      },
    );
  }
}

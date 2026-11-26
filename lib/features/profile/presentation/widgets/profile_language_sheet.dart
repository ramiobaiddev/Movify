import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/language/presentation/cubits/language_cubit.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Language selection bottom sheet matching Figma node `567:3796` & `567:4009`.
abstract final class ProfileLanguageSheet {
  static const _supportedLanguages = [
    AppSelectionOption('English', 'en', subtitle: 'English'),
    AppSelectionOption('العربية', 'ar', subtitle: 'Arabic'),
    AppSelectionOption('Türkçe', 'tr', subtitle: 'Turkish'),
    AppSelectionOption('Español', 'es', subtitle: 'Spanish'),
    AppSelectionOption('Français', 'fr', subtitle: 'French'),
    AppSelectionOption('Deutsch', 'de', subtitle: 'German'),
  ];

  static Future<void> show(BuildContext context) async {
    final currentCode = context.read<LanguageCubit>().state.locale.languageCode;

    final picked = await AppSelectionBottomSheet.show<String>(
      context,
      title: 'Language',
      options: _supportedLanguages,
      selectedValue: currentCode,
    );

    if (picked != null && context.mounted) {
      context.read<LanguageCubit>().changeLanguage(picked);
    }
  }
}

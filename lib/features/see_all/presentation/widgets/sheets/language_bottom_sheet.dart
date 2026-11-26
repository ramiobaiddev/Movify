import 'package:flutter/material.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Dedicated Original Language Bottom Sheet.
abstract final class LanguageBottomSheet {
  static const _options = <AppSelectionOption<String?>>[
    AppSelectionOption('All Languages', null),
    AppSelectionOption('English', 'en'),
    AppSelectionOption('Korean (한국어)', 'ko'),
    AppSelectionOption('Japanese (日本語)', 'ja'),
    AppSelectionOption('Spanish (Español)', 'es'),
    AppSelectionOption('French (Français)', 'fr'),
    AppSelectionOption('Arabic (العربية)', 'ar'),
    AppSelectionOption('German (Deutsch)', 'de'),
    AppSelectionOption('Italian (Italiano)', 'it'),
    AppSelectionOption('Turkish (Türkçe)', 'tr'),
    AppSelectionOption('Hindi (हिन्दी)', 'hi'),
    AppSelectionOption('Chinese (中文)', 'zh'),
  ];

  /// English name for a language code ("ko" -> "Korean"), or the upper-cased
  /// code when it is not in the list.
  static String nameFor(String code) {
    for (final option in _options) {
      if (option.value == code) {
        return option.label.split(' (').first;
      }
    }
    return code.toUpperCase();
  }

  static Future<void> show(
    BuildContext context, {
    required String? selectedLanguage,
    required ValueChanged<String?> onSelectLanguage,
  }) async {
    final picked = await AppSelectionBottomSheet.show<String?>(
      context,
      title: 'Original Language',
      options: _options,
      selectedValue: selectedLanguage,
    );
    if (picked != null || selectedLanguage != null) {
      onSelectLanguage(picked);
    }
  }
}

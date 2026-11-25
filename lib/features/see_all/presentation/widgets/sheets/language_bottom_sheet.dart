import 'package:flutter/material.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Dedicated Original Language Bottom Sheet.
abstract final class LanguageBottomSheet {
  static const _options = <(String label, String? code)>[
    ('All Languages', null),
    ('English', 'en'),
    ('Korean (한국어)', 'ko'),
    ('Japanese (日本語)', 'ja'),
    ('Spanish (Español)', 'es'),
    ('French (Français)', 'fr'),
    ('Arabic (العربية)', 'ar'),
    ('German (Deutsch)', 'de'),
    ('Italian (Italiano)', 'it'),
    ('Turkish (Türkçe)', 'tr'),
    ('Hindi (हिन्दी)', 'hi'),
    ('Chinese (中文)', 'zh'),
  ];

  /// English name for a language code ("ko" -> "Korean"), or the upper-cased
  /// code when it is not in the list.
  static String nameFor(String code) {
    for (final (label, value) in _options) {
      if (value == code) {
        return label.split(' (').first;
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

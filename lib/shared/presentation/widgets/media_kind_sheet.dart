import 'package:flutter/material.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Bottom sheet to pick Movies or Series matching Figma node 783:8712 ("type bottom sheet").
/// Returns the picked kind, or null if dismissed.
Future<ContentType?> showMediaKindSheet(
  BuildContext context, {
  required ContentType selected,
}) {
  final l10n = AppLocalizations.of(context)!;

  return AppSelectionBottomSheet.show<ContentType>(
    context,
    title: 'Type',
    options: [
      (l10n.movies, ContentType.movies),
      (l10n.tvShows, ContentType.series),
    ],
    selectedValue: selected,
  );
}

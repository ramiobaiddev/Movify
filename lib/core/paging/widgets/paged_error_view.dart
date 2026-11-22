import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Default first-page error: message and a retry button.
class PagedErrorView extends StatelessWidget {
  const PagedErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: Space.sm),
        TextButton(
          onPressed: onRetry,
          child: Text(AppLocalizations.of(context)!.retry),
        ),
      ],
    ),
  );
}

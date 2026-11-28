import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/paging/widgets/paged_error_view.dart';

/// Error message with a retry button, spaced for a details-style page.
class ContentError extends StatelessWidget {
  const ContentError({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: Space.x3xl),
    child: PagedErrorView(message: message, onRetry: onRetry),
  );
}

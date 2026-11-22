import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';

/// Poster metadata below the image: Title & optional Media Type / Genre subtitle.
class PosterMetadata extends StatelessWidget {
  const PosterMetadata({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelLarge?.copyWith(color: colors.textPrimary),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: colors.textContrast,
            ),
          ),
        ],
      ],
    );
  }
}

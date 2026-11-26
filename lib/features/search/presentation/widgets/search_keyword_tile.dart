import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/shared/domain/entites/keyword.dart';

/// Keyword row tile showing tag icon, keyword name, and chevron arrow.
class SearchKeywordTile extends StatelessWidget {
  const SearchKeywordTile({
    super.key,
    required this.keyword,
    required this.onTap,
  });

  final Keyword keyword;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.lg,
            vertical: Space.md,
          ),
          child: Row(
            children: [
              Icon(
                Icons.tag_rounded,
                color: colors.iconSecondary,
                size: 20,
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Text(
                  keyword.name,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colors.iconSecondary,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

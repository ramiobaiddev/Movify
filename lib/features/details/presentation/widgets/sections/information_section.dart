import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/features/details/presentation/widgets/sections/section_title.dart';

/// Label and value rows with a divider under each.
class InformationSection extends StatelessWidget {
  const InformationSection({super.key, required this.rows});

  final List<InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Information'),
          const SizedBox(height: Space.lg),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        row.label,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: Space.lg),
                      Flexible(
                        child: Text(
                          row.value,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.textContrast,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Space.sm),
                  Divider(height: 1, thickness: 1, color: colors.surfaceDivider),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

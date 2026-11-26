import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Search input field following Figma styling with pure design tokens.
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.hintText = 'Search movies, series, actors...',
    this.autofocus = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String hintText;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: colors.surfaceGenre,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(
          color: colors.surfaceDivider.withValues(alpha: 0.15),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Space.md),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: colors.iconContrast, size: 22),
          const SizedBox(width: Space.sm),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: autofocus,
              style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
              cursorColor: colors.primaryDefault,

              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colors.textContrast,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChanged,
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: colors.iconSecondary,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                splashRadius: 18,
                onPressed: () {
                  controller.clear();
                  onClear();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

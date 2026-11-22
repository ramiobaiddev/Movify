import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/core/design_system/tokens/radii.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/core/formatters/formatted_date_method.dart';
import 'package:movify/core/utils/helper/get_gener_name.dart';
import 'package:movify/shared/presentation/models/card_display_model.dart';

/// Metadata section rendered directly beneath the carousel cards.
/// Matches Figma node `5:691`:
/// - Title: 24px Bold Montserrat
/// - 3 Pill Badges: Genre (18px Medium), Year (16px Regular), Rating (16px + Star)
/// - AnimatedSwitcher cross-fade between items
class HeroMetadataView extends StatelessWidget {
  const HeroMetadataView({
    super.key,
    required this.cardModel,
  });

  final CardDisplayModel cardModel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    String genreName = '';
    if (cardModel.genreIds?.isNotEmpty == true) {
      try {
        genreName = getGenreName(cardModel.genreIds!.first, context);
      } catch (_) {
        genreName = '';
      }
    }
    final year = FormattedDateMethods.formatDateYear(cardModel.date);
    final rating = cardModel.rating != null && cardModel.rating! > 0
        ? cardModel.rating!.toStringAsFixed(1)
        : null;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.15),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: Column(
        key: ValueKey<int>(cardModel.id),
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Title ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            child: Text(
              cardModel.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium?.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: Space.sm),

          // ── 3 Pill Badges Row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Genre Pill
              if (genreName.isNotEmpty) ...[
                _BadgePill(
                  child: Text(
                    genreName,
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: Space.sm),
              ],

              // Year Pill
              if (year.isNotEmpty && year != 'Unknown') ...[
                _BadgePill(
                  child: Text(
                    year,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: Space.sm),
              ],

              // Rating Pill
              if (rating != null)
                _BadgePill(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFAA01),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerTonal.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(Radii.sm),
      ),
      child: child,
    );
  }
}

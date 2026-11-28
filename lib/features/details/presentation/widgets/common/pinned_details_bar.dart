import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/core/details_data_navigation.dart';
import 'package:movify/features/details/presentation/widgets/common/details_actions.dart';
import 'package:movify/shared/presentation/widgets/headers/pinned_bar_scroll.dart';

/// Back arrow and title on the left, heart / share / home on the right
/// (Figma "movie details app bar pinned").
class PinnedDetailsBar extends StatelessWidget {
  const PinnedDetailsBar({super.key, required this.title, required this.data});

  final String title;
  final DetailsNavigationData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.surfaceProfileRow),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: SizedBox(
          height: PinnedBarScroll.toolbarHeight,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Space.sm,
              right: Space.sm,
              bottom: Space.md,
              top: Space.md,
            ),
            child: Row(
              children: [
                Semantics(
                  button: true,
                  label: 'Back',
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: Space.xsm),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                  ),
                ),
                ...barActions(context, data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

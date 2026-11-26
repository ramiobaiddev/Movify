import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_cubit.dart';
import 'package:movify/features/favorite/presentation/models/favorite_card_mapper.dart';
import 'package:movify/features/home/presentation/extensions/main_vertical_card_extention.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

/// Long-press actions for one favorite: view, share, remove.
class FavoriteActionsSheet extends StatelessWidget {
  const FavoriteActionsSheet({
    super.key,
    required this.item,
    required this.onView,
    required this.onShare,
    required this.onRemove,
  });

  final FavoriteEntity item;
  final VoidCallback onView;
  final VoidCallback onShare;
  final VoidCallback onRemove;

  static Future<void> show(BuildContext context, FavoriteEntity item) {
    // The sheet lives on the root navigator, so grab what it needs here.
    final cubit = context.read<FavoriteCubit>();
    final router = GoRouter.of(context);
    final root = Navigator.of(context, rootNavigator: true);

    return AppBottomSheet.show<void>(
      context,
      title: item.title,
      child: FavoriteActionsSheet(
        item: item,
        onView: () {
          root.pop();
          final card = item.toCardDisplay();
          router.pushNamed(
            card.contentType == ContentType.movies
                ? RouteName.movieDetail
                : RouteName.tvDetail,
            pathParameters: {'id': card.id.toString()},
            extra: card.toNavigationData(),
          );
        },
        onShare: () {
          root.pop();
          SharePlus.instance.share(
            ShareParams(
              subject: 'Share this ${item.contentType.text}',
              text:
                  'https://www.themoviedb.org/'
                  '${item.contentType == ContentType.movies ? 'movie' : 'tv'}'
                  '/${item.specificId}',
            ),
          );
        },
        onRemove: () {
          root.pop();
          cubit.toggleFavorite(item);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionRow(
          label: 'View',
          icon: Icons.info_outline_rounded,
          color: colors.textPrimary,
          onTap: onView,
        ),
        _ActionRow(
          label: 'Share',
          icon: Icons.ios_share_rounded,
          color: colors.textPrimary,
          onTap: onShare,
        ),
        Divider(color: colors.surfaceDivider, height: Space.x2xl),
        _ActionRow(
          label: 'Remove from favorites',
          icon: Icons.heart_broken_rounded,
          color: colors.surfaceError,
          onTap: onRemove,
        ),
        const SizedBox(height: Space.lg),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.md),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: color,
              ),
            ),
          ),
          Icon(icon, color: color, size: 24),
        ],
      ),
    ),
  );
}

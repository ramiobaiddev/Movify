import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_cubit.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';

/// Top-right status: where the favorites are stored right now.
class FavoriteStatusBadge extends StatelessWidget {
  const FavoriteStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      buildWhen: (previous, current) => current is FavoriteLoaded,
      builder: (context, state) {
        if (state is! FavoriteLoaded) {
          return const SizedBox.shrink();
        }
        final isGuest = state.isGuest;
        final color = isGuest ? colors.textSecondary : colors.surfaceSuccess;

        return Row(
          mainAxisSize: MainAxisSize.min,
          spacing: Space.sm,
          children: [
            Icon(
              isGuest ? Icons.cloud_off_outlined : Icons.cloud_done_outlined,
              color: color,
              size: 24,
            ),
            Text(
              isGuest ? 'Saved on phone' : 'Synced',
              style: textTheme.labelMedium?.copyWith(color: color),
            ),
          ],
        );
      },
    );
  }
}

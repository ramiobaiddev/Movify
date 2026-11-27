import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/favorite/domain/entities/favorite_entity.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_cubit.dart';
import 'package:movify/features/favorite/presentation/cubits/favorite_state.dart';
import 'package:movify/features/favorite/presentation/widgets/particle_heart_button.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.favoriteEntity,
    this.size = 32,
    this.shaded = true,
  });

  final FavoriteEntity favoriteEntity;
  final double size;

  /// Soft dark backing so the heart reads on a poster. Off when the heart sits
  /// on a button that already has its own background.
  final bool shaded;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) => cubit.isFavorite(
        favoriteEntity.specificId,
        favoriteEntity.contentType,
      ),
      builder: (context, isFavorited) {
        final heart = ParticleHeartButton(
          isFavorited: isFavorited,
          size: size,
          onTap: () {
            HapticFeedback.heavyImpact();
            cubit.toggleFavorite(favoriteEntity);
          },
        );
        if (!shaded) {
          return heart;
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surfaceBlurBackground.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(Radii.lg),
          ),
          child: heart,
        );
      },
    );
  }
}

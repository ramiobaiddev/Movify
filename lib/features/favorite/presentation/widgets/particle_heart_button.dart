import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/favorite/presentation/widgets/particle_burst.dart';

/// Heart toggle with a small particle burst when it becomes a favorite.
///
/// The burst is only built while it plays, so a list full of favorited hearts
/// carries no extra widgets while idle.
class ParticleHeartButton extends HookWidget {
  const ParticleHeartButton({
    super.key,
    required this.isFavorited,
    required this.onTap,
    this.size = 32,
    this.color,
  });

  static const int _particleCount = 8;

  final bool isFavorited;
  final VoidCallback onTap;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final heartColor = context.colors.surfaceError;
    final defaultColor = color ?? context.colors.textOnImage;

    final scaleController = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    final particleController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final scaleAnimation = useMemoized(
      () => Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: scaleController, curve: Curves.easeOut),
      ),
      [scaleController],
    );

    final prevIsFavorited = usePrevious(isFavorited);
    useEffect(() {
      if (isFavorited && prevIsFavorited == false) {
        scaleController.forward().then((_) => scaleController.reverse());
        particleController.forward(from: 0);
      }
      return null;
    }, [isFavorited]);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size * 2,
        height: size * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: particleController,
              builder: (context, _) => particleController.isAnimating
                  ? RepaintBoundary(
                      child: ParticleBurst(
                        progress: particleController.value,
                        radius: size * 0.9,
                        count: _particleCount,
                        color: heartColor,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            ScaleTransition(
              scale: scaleAnimation,
              child: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? heartColor : defaultColor,
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

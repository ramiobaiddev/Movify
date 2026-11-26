import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';

/// 64x64 circular user avatar with network image loading and asset fallback.
class ProfileUserAvatar extends StatelessWidget {
  const ProfileUserAvatar({
    super.key,
    this.photoUrl,
    this.size = 64,
  });

  final String? photoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final hasNetworkImage = photoUrl != null && photoUrl!.trim().isNotEmpty;

    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: colors.surfaceGenre,
        child: hasNetworkImage
            ? CachedNetworkImage(
                imageUrl: photoUrl!,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => Image.asset(
                  Assets.imagesProfileAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.person_rounded,
                    size: size / 2,
                    color: colors.iconSecondary,
                  ),
                ),
              )
            : Image.asset(
                Assets.imagesProfileAvatar,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Icon(
                  Icons.person_rounded,
                  size: size / 2,
                  color: colors.iconSecondary,
                ),
              ),
      ),
    );
  }
}

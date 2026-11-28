import 'package:flutter/material.dart';
import 'package:movify/constants/assets.dart';
import 'package:movify/core/design_system/design_system.dart';

/// 64x64 circular user avatar with network image loading and asset fallback.
class ProfileUserAvatar extends StatelessWidget {
  const ProfileUserAvatar({super.key, this.photoUrl, this.size = 64});

  final String? photoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipOval(
      child: Container(
        width: 48,
        height: 48,
        color: colors.surfaceGenre,
        child: Image.asset(
          Assets.guestAvatar,
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

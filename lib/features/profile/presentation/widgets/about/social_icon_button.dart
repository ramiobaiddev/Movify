import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/shared/presentation/extensions/launcher_helper.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  final FaIconData icon;
  final String url;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return IconButton(
      onPressed: () => context.openUrl(url),
      icon: FaIcon(icon, size: 22, color: colors.iconPrimary),
      tooltip: tooltip,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Play trailer',
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: FaIcon(
        FontAwesomeIcons.youtube,
        color: context.colors.textOnImage,
        size: 18,
      ),
    ),
  );
}

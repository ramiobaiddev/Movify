import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/app_colors.dart';
import 'package:movify/shared/presentation/widgets/headers/header_circle.dart';

class HeaderCircleAction extends StatelessWidget {
  const HeaderCircleAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: HeaderCircle(
        child: Icon(icon, size: 18, color: context.colors.textOnImage),
      ),
    ),
  );
}

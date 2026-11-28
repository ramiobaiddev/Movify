import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/shared/presentation/widgets/headers/header_circle_action.dart';

class HeaderButtonRow extends StatelessWidget {
  const HeaderButtonRow({
    super.key,
    required this.onBack,
    this.actions = const [],
  });

  final VoidCallback onBack;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      HeaderCircleAction(
        icon: Icons.arrow_back_ios_new_rounded,
        label: 'Back',
        onTap: onBack,
      ),
      const Spacer(),
      for (var i = 0; i < actions.length; i++) ...[
        if (i > 0) const SizedBox(width: Space.sm),
        actions[i],
      ],
    ],
  );
}

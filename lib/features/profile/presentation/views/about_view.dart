import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_view_body.dart';

/// About screen matching Figma node `549:5708`.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      body: const SafeArea(
        child: AboutViewBody(),
      ),
    );
  }
}

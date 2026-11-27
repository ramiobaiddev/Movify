import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_app_identity.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_developer_card.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_legal_section.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_tmdb_credits_card.dart';
import 'package:movify/features/profile/presentation/widgets/about/about_top_bar.dart';

/// Body of AboutView matching Figma node `549:5708`.
class AboutViewBody extends StatelessWidget {
  const AboutViewBody({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      AboutTopBar(),
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Space.lg),
          child: Column(
            children: [
              SizedBox(height: Space.lg),
              AboutAppIdentity(),
              SizedBox(height: Space.x2xl),
              AboutDeveloperCard(),
              SizedBox(height: Space.lg),
              AboutTmdbCreditsCard(),
              SizedBox(height: Space.lg),
              AboutLegalSection(),
              SizedBox(height: Space.x2xl),
            ],
          ),
        ),
      ),
    ],
  );
}

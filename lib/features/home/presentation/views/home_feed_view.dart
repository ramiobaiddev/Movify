import 'package:flutter/material.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/features/home/presentation/views/home_feed_view_body.dart';

class HomeFeedView extends StatelessWidget {
  const HomeFeedView({super.key});

  @override
  Widget build(BuildContext context) => const SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Space.lg),
      child: HomeFeedViewBody(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:movify/features/profile/presentation/views/profile_body.dart';

/// Profile screen following Figma node `413:3939`.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: SafeArea(bottom: false, child: ProfileViewBody()));
}

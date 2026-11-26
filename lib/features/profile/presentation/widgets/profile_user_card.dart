import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/features/auth/presentation/cubits/session_cubit.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';
import 'package:movify/features/profile/presentation/widgets/profile_authenticated_user_card.dart';
import 'package:movify/features/profile/presentation/widgets/profile_guest_user_card.dart';

/// User profile header card displaying avatar, name, and email matching Figma `Frame 384`.
/// Dispatches cleanly between [ProfileAuthenticatedUserCard] and [ProfileGuestUserCard].
class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, SessionState>(
    builder: (context, state) => switch (state) {
      SessionAuthenticated(:final user) => ProfileAuthenticatedUserCard(
        user: user,
      ),
      _ => const ProfileGuestUserCard(),
    },
  );
}
